library ieee;
use ieee.std_logic_1164.all;

entity Counter8exp is
    port (
        CLK, RESETN, EN: in std_logic;
        cnt_exp: out std_logic                   -- Output signal when the counter reaches 8
    );
end;

architecture Structural of Counter8exp is
    component enARdFF_2 is
        port (
            i_resetBar: in std_logic;
            i_d: in std_logic;
            i_enable: in std_logic;
            i_clock: in std_logic;
            o_q, o_qBar: out std_logic
        );
    end component;
    
    signal signalValue: std_logic_vector(3 downto 0); -- Expanded to 4 bits
    signal signalD: std_logic_vector(3 downto 0);     -- Expanded to 4 bits
begin
    signalD(3) <= signalValue(3) xor (signalValue(2) and signalValue(1) and signalValue(0));
    signalD(2) <= signalValue(2) xor (signalValue(1) and signalValue(0));
    signalD(1) <= signalValue(1) xor signalValue(0);
    signalD(0) <= not signalValue(0);

    generateDFF: for i in 3 downto 0 generate
        dffInst: enARdFF_2
            port map (
                i_resetBar => RESETN,
                i_d => signalD(i),
                i_enable => EN,
                i_clock => CLK,
                o_q => signalValue(i)
            );
    end generate;
    
    -- Set cnt_exp when counter reaches 8 (binary "1000")
    cnt_exp <= '1' when signalValue = "1000" else '0';
end;