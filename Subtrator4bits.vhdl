library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Subtrator4bits is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
           B : in  STD_LOGIC_VECTOR(3 downto 0);
           S : buffer  STD_LOGIC_VECTOR(3 downto 0);
			  carry_out : buffer boolean);
end Subtrator4bits;

architecture Behavioral of Subtrator4bits is

component Somador5bits is
    Port ( A5 : in  STD_LOGIC_VECTOR(4 downto 0);
           B5 : in  STD_LOGIC_VECTOR(4 downto 0);
			  C_in5 :in STD_LOGIC;
           S5 : out  STD_LOGIC_VECTOR(4 downto 0);
			  C_out5: out std_logic
			  );
			  
end component;

component Complementode2 is
    Port ( A2 : in  STD_LOGIC_VECTOR(3 downto 0);
           S2 : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

component Complementode25 is
    Port ( A25 : in  STD_LOGIC_VECTOR(4 downto 0);
           S25 : out  STD_LOGIC_VECTOR(4 downto 0));
end component;

signal  precomp, poscomp,neg: std_logic_Vector(3 downto 0);
signal sparc, A5b, B5b: std_logic_vector(4 downto 0);
signal sextobit: std_logic;

begin
	
	Sub0: Complementode2 port map(B,neg);
					  
	B5b <= '1' & neg;
	A5b <= '0' & A;
	
	Sub1: Somador5bits port map(A5b,B5b,'0',sparc,sextobit);
			  		  
	precomp <= sparc(3) & sparc(2) & sparc(1) & sparc(0);
	
	Sub2: Complementode2 port map(precomp,poscomp);
	
	process(precomp, poscomp, carry_out,S, sparc)
	begin
	
	if (sparc(4) = '1') then 
		carry_out <= TRUE;
	
	else 
		carry_out <= FALSE;
	end if;
	
	if (carry_out = TRUE) then S <= poscomp;

	else S <= precomp;
	
	end if;
	end process;
	
end Behavioral;

