library ieee;
use ieee.std_logic_1164.all;

entity sebitgiver is
	port(
		i_clock, i_resetbar, i_enable: in std_logic;
		i_load: in std_logic;
		o_se: out std_logic
	);
end sebitgiver;

architecture Rtl of sebitgiver is
begin
	o_se <= i_clock and i_resetbar and i_load and i_enable;
end Rtl;