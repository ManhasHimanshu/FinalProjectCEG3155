library ieee;
use ieee.std_logic_1164.all;

entity Counter41 is
    port (
        CLK, RESETN, EN: in std_logic;
        VALUE: out std_logic
    );
end;

architecture Structural of Counter41 is
    component enARdFF_2 is
        port (
            i_resetBar: in std_logic;
            i_d: in std_logic;
            i_enable: in std_logic;
            i_clock: in std_logic;
            o_q, o_qBar: out std_logic
        );
    end component;
    
    signal signalValue: std_logic_vector(5 downto 0);
    signal signalD: std_logic_vector(5 downto 0);
    signal maxCountReached: std_logic;
	 signal toggle: std_logic;
begin
    -- Counting logic
    signalD(5) <= signalValue(5) xor (signalValue(4) and signalValue(3) and signalValue(2) and signalValue(1) and signalValue(0));
    signalD(4) <= signalValue(4) xor (signalValue(3) and signalValue(2) and signalValue(1) and signalValue(0));
    signalD(3) <= signalValue(3) xor (signalValue(2) and signalValue(1) and signalValue(0));
    signalD(2) <= signalValue(2) xor (signalValue(1) and signalValue(0));
    signalD(1) <= signalValue(1) xor signalValue(0);
    signalD(0) <= not signalValue(0);

    -- Detect if the counter has reached 41
    maxCountReached <= '1' when signalValue = "101001" else '0';

    generateDFF: for i in 5 downto 0 generate
        dffInst: enARdFF_2
            port map (
                i_resetBar => RESETN or maxCountReached,
                i_d => signalD(i),
                i_enable => EN,
                i_clock => CLK,
                o_q => signalValue(i)
            );
    end generate;
    
    -- Toggle flip-flop to change state every time counter hits 41
    toggleDFF: enARdFF_2
        port map (
            i_resetBar => RESETN,
            i_d => not toggle,
            i_enable => maxCountReached,
            i_clock => CLK,
            o_q => toggle
        );

    VALUE <= toggle;
end;