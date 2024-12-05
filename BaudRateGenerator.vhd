library ieee;
library altera;
use ieee.std_logic_1164.all;
use altera.altera_primitives_components.all;

entity BaudRateGenerator is
    port (
        GReset: in std_logic;
        
        UARTClock: in std_logic;
        
        SEL: in std_logic_vector(2 downto 0);
        BaudClock: out std_logic;
        BaudClock8: out std_logic
    );
end;

architecture Structural of BaudRateGenerator is
	 component Counter41 is
		  port (
			  CLK, RESETN, EN: in std_logic;
			  VALUE: out std_logic
		  );
	 end component;
    
    component Counter256 is
        port (
            CLK, RESETN, EN: in std_logic;
            VALUE: out std_logic_vector(7 downto 0)
        );
    end component;
    
    component Counter8 is
        port (
            CLK, RESETN, EN: in std_logic;
            VALUE: out std_logic_vector(2 downto 0)
        );
    end component;
    
    component MUX8 is
        port (
            I7, I6, I5, I4, I3, I2, I1, I0: in std_logic_vector(7 downto 0);
            O: out std_logic_vector(7 downto 0);
            C: in std_logic_vector(2 downto 0)
        );
    end component;
    
    signal clock41: std_logic;
    signal clock256: std_logic_vector(7 downto 0);
    signal clockSel: std_logic;
begin
	 instCounter41: Counter41
        port map (
            CLK => UARTClock,
            RESETN => GReset,
            EN => '1',
            VALUE => clock41
        );
    
    instCounter256: Counter256
        port map (
            CLK => clock41,
            RESETN => GReset,
            EN => '1',
            VALUE => clock256
        );
        
    instMUX8: MUX8
        port map (
            I7(0) => clock256(7),
            I6(0) => clock256(6),
            I5(0) => clock256(5),
            I4(0) => clock256(4),
            I3(0) => clock256(3),
            I2(0) => clock256(2),
            I1(0) => clock256(1),
            I0(0) => clock256(0),
            O(0) => clockSel,
            C => SEL
        );
    
    instCounter8Divider: Counter8
        port map (
            CLK => clockSel,
            RESETN => GReset,
            EN => '1',
            VALUE(2) => BaudClock
        );
    
    BaudClock8 <= clockSel;
end;
