library ieee;
use ieee.std_logic_1164.all;

entity MUX4 is
    generic (
        T: integer := 1
    );
    port (
        I3, I2, I1, I0: in std_logic_vector(T downto 0);
        O: out std_logic_vector(T downto 0);
        C: in std_logic_vector(1 downto 0)
    );
end;

ARCHITECTURE rtl OF MUX4 IS
	BEGIN
		
		O(0) <= (C(1)AND C(0) AND I3(0)) OR (not(C(1))AND C(0) AND 	I2(0)) OR (C(1) AND not(C(0)) AND I1(0)) OR(not(C(1)) AND not(C(0)) AND I0(0));
		O(1) <= (C(1)AND C(0) AND I3(1)) OR (not(C(1))AND C(0) AND 	I2(1)) OR (C(1) AND not(C(0)) AND I1(1)) OR(not(C(1)) AND not(C(0)) AND I0(1));
		O(2) <= (C(1)AND C(0) AND I3(2)) OR (not(C(1))AND C(0) AND 	I2(2)) OR (C(1) AND not(C(0)) AND I1(2)) OR(not(C(1)) AND not(C(0)) AND I0(2));
		O(3) <= (C(1)AND C(0) AND I3(3)) OR (not(C(1))AND C(0) AND 	I2(3)) OR (C(1) AND not(C(0)) AND I1(3)) OR(not(C(1)) AND not(C(0)) AND I0(3));
		O(4) <= (C(1)AND C(0) AND I3(4)) OR (not(C(1))AND C(0) AND 	I2(4)) OR (C(1) AND not(C(0)) AND I1(4)) OR(not(C(1)) AND not(C(0)) AND I0(4));
		O(5) <= (C(1)AND C(0) AND I3(5)) OR (not(C(1))AND C(0) AND 	I2(5)) OR (C(1) AND not(C(0)) AND I1(5)) OR(not(C(1)) AND not(C(0)) AND I0(5));
		O(6) <= (C(1)AND C(0) AND I3(6)) OR (not(C(1))AND C(0) AND 	I2(6)) OR (C(1) AND not(C(0)) AND I1(6)) OR(not(C(1)) AND not(C(0)) AND I0(6));
		O(7) <= (C(1)AND C(0) AND I3(7)) OR (not(C(1))AND C(0) AND 	I2(7)) OR (C(1) AND not(C(0)) AND I1(7)) OR(not(C(1)) AND not(C(0)) AND I0(7));
	
	END rtl;