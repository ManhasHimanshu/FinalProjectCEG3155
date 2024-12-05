library ieee;
use ieee.std_logic_1164.all;

entity MUX8 is
    port (
        I7, I6, I5, I4, I3, I2, I1, I0: in std_logic_vector(7 downto 0);
        O: out std_logic_vector(7 downto 0);
        C: in std_logic_vector(2 downto 0)
    );
end;
architecture rtl of MUX8 is
begin
    O(0) <= (C(2) AND C(1) AND C(0) AND I7(0)) OR 
            (C(2) AND C(1) AND NOT(C(0)) AND I6(0)) OR 
            (C(2) AND NOT(C(1)) AND C(0) AND I5(0)) OR 
            (C(2) AND NOT(C(1)) AND NOT(C(0)) AND I4(0)) OR 
            (NOT(C(2)) AND C(1) AND C(0) AND I3(0)) OR 
            (NOT(C(2)) AND C(1) AND NOT(C(0)) AND I2(0)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND C(0) AND I1(0)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND NOT(C(0)) AND I0(0));

    O(1) <= (C(2) AND C(1) AND C(0) AND I7(1)) OR 
            (C(2) AND C(1) AND NOT(C(0)) AND I6(1)) OR 
            (C(2) AND NOT(C(1)) AND C(0) AND I5(1)) OR 
            (C(2) AND NOT(C(1)) AND NOT(C(0)) AND I4(1)) OR 
            (NOT(C(2)) AND C(1) AND C(0) AND I3(1)) OR 
            (NOT(C(2)) AND C(1) AND NOT(C(0)) AND I2(1)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND C(0) AND I1(1)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND NOT(C(0)) AND I0(1));

    O(2) <= (C(2) AND C(1) AND C(0) AND I7(2)) OR 
            (C(2) AND C(1) AND NOT(C(0)) AND I6(2)) OR 
            (C(2) AND NOT(C(1)) AND C(0) AND I5(2)) OR 
            (C(2) AND NOT(C(1)) AND NOT(C(0)) AND I4(2)) OR 
            (NOT(C(2)) AND C(1) AND C(0) AND I3(2)) OR 
            (NOT(C(2)) AND C(1) AND NOT(C(0)) AND I2(2)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND C(0) AND I1(2)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND NOT(C(0)) AND I0(2));

    O(3) <= (C(2) AND C(1) AND C(0) AND I7(3)) OR 
            (C(2) AND C(1) AND NOT(C(0)) AND I6(3)) OR 
            (C(2) AND NOT(C(1)) AND C(0) AND I5(3)) OR 
            (C(2) AND NOT(C(1)) AND NOT(C(0)) AND I4(3)) OR 
            (NOT(C(2)) AND C(1) AND C(0) AND I3(3)) OR 
            (NOT(C(2)) AND C(1) AND NOT(C(0)) AND I2(3)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND C(0) AND I1(3)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND NOT(C(0)) AND I0(3));

    O(4) <= (C(2) AND C(1) AND C(0) AND I7(4)) OR 
            (C(2) AND C(1) AND NOT(C(0)) AND I6(4)) OR 
            (C(2) AND NOT(C(1)) AND C(0) AND I5(4)) OR 
            (C(2) AND NOT(C(1)) AND NOT(C(0)) AND I4(4)) OR 
            (NOT(C(2)) AND C(1) AND C(0) AND I3(4)) OR 
            (NOT(C(2)) AND C(1) AND NOT(C(0)) AND I2(4)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND C(0) AND I1(4)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND NOT(C(0)) AND I0(4));

    O(5) <= (C(2) AND C(1) AND C(0) AND I7(5)) OR 
            (C(2) AND C(1) AND NOT(C(0)) AND I6(5)) OR 
            (C(2) AND NOT(C(1)) AND C(0) AND I5(5)) OR 
            (C(2) AND NOT(C(1)) AND NOT(C(0)) AND I4(5)) OR 
            (NOT(C(2)) AND C(1) AND C(0) AND I3(5)) OR 
            (NOT(C(2)) AND C(1) AND NOT(C(0)) AND I2(5)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND C(0) AND I1(5)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND NOT(C(0)) AND I0(5));

    O(6) <= (C(2) AND C(1) AND C(0) AND I7(6)) OR 
            (C(2) AND C(1) AND NOT(C(0)) AND I6(6)) OR 
            (C(2) AND NOT(C(1)) AND C(0) AND I5(6)) OR 
            (C(2) AND NOT(C(1)) AND NOT(C(0)) AND I4(6)) OR 
            (NOT(C(2)) AND C(1) AND C(0) AND I3(6)) OR 
            (NOT(C(2)) AND C(1) AND NOT(C(0)) AND I2(6)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND C(0) AND I1(6)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND NOT(C(0)) AND I0(6));

    O(7) <= (C(2) AND C(1) AND C(0) AND I7(7)) OR 
            (C(2) AND C(1) AND NOT(C(0)) AND I6(7)) OR 
            (C(2) AND NOT(C(1)) AND C(0) AND I5(7)) OR 
            (C(2) AND NOT(C(1)) AND NOT(C(0)) AND I4(7)) OR 
            (NOT(C(2)) AND C(1) AND C(0) AND I3(7)) OR 
            (NOT(C(2)) AND C(1) AND NOT(C(0)) AND I2(7)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND C(0) AND I1(7)) OR 
            (NOT(C(2)) AND NOT(C(1)) AND NOT(C(0)) AND I0(7));
end rtl;