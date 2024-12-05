library ieee;
use ieee.std_logic_1164.all;

entity MUX4x1 is
    port(
        INPUT: in std_logic_vector(3 downto 0);
        OUTPUT: out std_logic;
        C: in std_logic_vector(1 downto 0)
    );
end;

architecture Rtl of MUX4x1 is
	begin
    OUTPUT <= (INPUT(3) AND C(1) AND C(0)) OR 
					(INPUT(2) AND C(1) AND not(C(0))) OR 
					(INPUT(1) AND not(C(1)) AND C(0)) OR 
					(INPUT(0) AND not(C(1)) AND not(C(0)));
end Rtl;