library ieee;
use ieee.std_logic_1164.all;

entity TransmitterController is
	port(
		i_clock, i_resetbar, i_enable: in std_logic;
		i_TDRE: in std_logic;
		o_TDRE, TDRE_load: out std_logic;--SCSR
		TDR_load:out std_logic;--TDR
		TSR_MODE: out std_logic_vector(1 downto 0);
		se_load: out std_logic
	);
end TransmitterController;

architecture Structural of TransmitterController is
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
	signal signal_se_load: std_logic;
	signal CapY2, CapY1, CapY0: std_logic;
	signal y2, y1, y0: std_logic;
	signal noty2, noty1, noty0: std_logic;
	
begin
	dFFInst2: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
				i_d => CapY2, 
				i_enable => i_enable,
				i_clock => i_clock,
				o_q => y2,
				o_qBar => noty2);
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
	signal_se_load <= (not(y2) and y1 and y0) or (y2 and y1 and y0);--start s3:100| end s5:111
	signal_cnt_enable <= y2 and y1 and not(y0);--s4:110
	
	CapY2 <= (y0 and i_TDRE and i_resetbar) or 
			(y1 and noty0 and not(i_TDRE)) or
			(y2 and noty1 and not(i_TDRE) and i_resetbar and not(signal_cnt_exp));
	CapY1 <= (noty1 and y0 and i_resetbar) or
			(y2 and noty0 and i_resetbar);
	CapY0 <= (i_TDRE and i_resetbar) or 
			(noty2 and y0 and i_resetbar) or 
			(y1 and noty0 and i_resetbar);
			
	TDR_load <= (noty2 and noty1 and noty0 and i_TDRE and i_resetbar);
	o_TDRE <= not(noty2 and noty1 and y0) or (noty2 and y1 and y0);--s1:001|s2:011
	TDRE_load <= (noty2 and noty1 and y0) or (noty2 and y1 and y0);
	--s1:001|s3:100
	--00 latch| 01 paraload|11 shiftright
	TSR_MODE(1) <=not(noty2 and noty1 and y0) or (y2 and noty1 and noty0);
	TSR_MODE(0) <=(noty2 and noty1 and y0) or (y2 and noty1 and noty0);
	
	--s2:001 0(start)
	--s5:111 1(end)
	se_load <= not(noty2 and y1 and y0) or (y2 and y1 and y0);
	
end Structural;