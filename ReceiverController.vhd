library ieee;
use ieee.std_logic_1164.all;

entity ReceiverController is
	port(
		i_clock, i_resetbar, i_enable: in std_logic;
		i_RDRF: in std_logic;
		i_RxD: in std_logic;
		i_verify: in std_logic;
		o_RDRF, RDRF_load: out std_logic;--SCSR
		o_shiftbit: out std_logic;
		RSR_MODE: out std_logic_vector(1 downto 0)
	);
end ReceiverController;

architecture Structural of ReceiverController is
	component enARdFF_2 is
		port (
				i_resetBar: in std_logic;
            i_d: in std_logic;
            i_enable: in std_logic;
            i_clock: in std_logic;
            o_q, o_qBar: out std_logic
		);
	end component;	
	
	component Counter8exp is
		port (
        CLK, RESETN, EN: in std_logic;
        cnt_exp: out std_logic 
		);
	end component;
	
	signal signal_cnt_enable: std_logic;
	signal signal_cnt_exp: std_logic;
	signal CapY1, CapY0: std_logic;
	signal y1, y0: std_logic;
	signal noty1, noty0: std_logic;
	
begin
	dFFInst1: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
				i_d => CapY1, 
				i_enable => i_enable,
				i_clock => i_clock,
				o_q => y1,
				o_qBar => noty1);
	dFFInst0: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
				i_d => CapY0, 
				i_enable => i_enable,
				i_clock => i_clock,
				o_q => y0,
				o_qBar => noty0);
	cnt8: Counter8exp
	PORT MAP (CLK => i_clock,
				RESETN => i_resetbar,
				EN => signal_cnt_enable,
				cnt_exp  => signal_cnt_exp
				);
				
	signal_cnt_enable <= noty1 and noty0;--s0:00
	CapY1 <= not(noty1 and noty0 and signal_cnt_exp and not(i_RDRF)) or
				(noty1 and y0 and i_RDRF) or
				(y1 and y0 and i_verify) or
				not(y1 and noty0);
	CapY0	<= (noty1 and noty0 and signal_cnt_exp and not(i_RDRF)) or
				(noty1 and y0 and i_RDRF) or
				not(y1 and y0 and i_verify) or
				not(y1 and noty0);
	o_RDRF <= (noty1 and y0) or not(y1 and noty0);--s1:01 1|s3:10 0
	RDRF_load <= (noty1 and y0) or (y1 and noty0);
	RSR_MODE(1) <= (noty1 and noty0) or '0';
	RSR_MODE(0) <= (noty1 and noty0) or '0';
	o_shiftbit <= i_RxD;
End Structural;
	
	