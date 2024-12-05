LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Receiver IS
    PORT(
        i_resetBar : IN STD_LOGIC;
        i_enable : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_RDRF : IN STD_LOGIC;
        i_RxD : IN STD_LOGIC;
        o_RDRF : OUT STD_LOGIC;
        o_value : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END Receiver;

ARCHITECTURE structural OF Receiver IS
    
    component Register8 is
        PORT(
            i_resetBar, i_load : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            i_Value : IN STD_LOGIC_VECTOR(7 downto 0);
            o_Value : OUT STD_LOGIC_VECTOR(7 downto 0));
    END component;
    
    component ShiftRegister8 is
        port (
            i_clock, i_resetbar: in std_logic;
            MODE: in std_logic_vector(1 downto 0);
            SERIAL_IN_LEFT, SERIAL_IN_RIGHT: in std_logic;
            PARALLEL_IN: in std_logic_vector(7 downto 0);
            PARALLEL_OUT: out std_logic_vector(7 downto 0);
            SERIAL_OUT: out std_logic
        );
    END component;

    signal signalMODE : std_logic_vector(1 downto 0);
    signal signalLoad : std_logic;
    signal signalSerialOut : std_logic;
    signal signalParallelOut : std_logic_vector(7 downto 0);
    signal signalPreParallelOut : std_logic_vector(7 downto 0);
    signal internal_counter : INTEGER := 0;  -- Counter signal
    
BEGIN 
    RDR: Register8
        PORT MAP (
            i_resetBar => i_resetBar,
            i_load => signalLoad,
            i_clock => i_clock,
            i_Value => signalPreParallelOut,
            o_Value => o_value);
        
    RSR: ShiftRegister8
        PORT MAP (
            i_clock => i_clock,
            i_resetbar => i_resetBar,  -- fixed typo: i_resetbar -> i_resetBar
            MODE => signalMODE,
            SERIAL_IN_LEFT => i_RxD,
            SERIAL_IN_RIGHT => '0',
            PARALLEL_IN => "00000000",
            PARALLEL_OUT => signalParallelOut,
            SERIAL_OUT => signalSerialOut);    
        
    -- Logic for loading data from RSR to RDR
    process(i_clock, i_resetBar)
    begin
        if i_resetBar = '0' then
            -- Reset logic
            signalMODE <= "00";
            signalLoad <= '0';
            signalPreParallelOut <= "00000000";
            internal_counter <= 0;
            o_RDRF <= '0';  -- Ensure output status is also reset
        elsif rising_edge(i_clock) then
            if i_enable = '1' then
                -- Increment counter with each clock cycle
                internal_counter <= internal_counter + 1;
                
                -- Shift data and manage load signals
                if internal_counter = 1 then
                    signalMODE <= "10"; -- Mode for start bit detection
                elsif internal_counter >= 2 and internal_counter <= 9 then
                    -- Shifting data bits
                    signalPreParallelOut(internal_counter - 2) <= i_RxD;
                elsif internal_counter = 10 then
                    -- All data bits received, load to RDR
                    signalLoad <= '1'; -- Trigger load
                    o_RDRF <= '1';  -- Data ready
                    signalMODE <= "01"; -- Mode for parallel load
                elsif internal_counter > 10 then
                    -- Reset counter and wait for next start bit
                    internal_counter <= 0;
                    signalLoad <= '0';
                    o_RDRF <= '0';  -- Data has been read
                end if;
            else
                -- If not enabled, do not count
                internal_counter <= 0;
            end if;
        end if;
    end process;
END structural;