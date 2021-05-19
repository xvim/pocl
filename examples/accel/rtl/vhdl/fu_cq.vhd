-- Module generated by TTA Codesign Environment
-- 
-- Generated on Mon May 17 18:47:56 2021
-- 
-- Function Unit: cq
-- 
-- Operations:
--  ld16  : 0
--  ld32  : 1
--  ld8   : 2
--  ldu16 : 3
--  ldu8  : 4
--  st16  : 5
--  st32  : 6
--  st8   : 7
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity fu_cq is
  port (
    clk : in std_logic;
    rstx : in std_logic;
    glock_in : in std_logic;
    glockreq_out : out std_logic;
    operation_in : in std_logic_vector(3-1 downto 0);
    data_in1t_in : in std_logic_vector(32-1 downto 0);
    load_in1t_in : in std_logic;
    data_out1_out : out std_logic_vector(32-1 downto 0);
    data_in2_in : in std_logic_vector(32-1 downto 0);
    load_in2_in : in std_logic;
    avalid_out : out std_logic_vector(1-1 downto 0);
    aready_in : in std_logic_vector(1-1 downto 0);
    aaddr_out : out std_logic_vector(10-2-1 downto 0);
    awren_out : out std_logic_vector(1-1 downto 0);
    astrb_out : out std_logic_vector(4-1 downto 0);
    rvalid_in : in std_logic_vector(1-1 downto 0);
    rready_out : out std_logic_vector(1-1 downto 0);
    rdata_in : in std_logic_vector(32-1 downto 0);
    adata_out : out std_logic_vector(32-1 downto 0));
end entity fu_cq;

architecture rtl of fu_cq is

  constant addrw_c : integer := 10;
  constant op_ld16_c : std_logic_vector(2 downto 0) := "000";
  constant op_ld32_c : std_logic_vector(2 downto 0) := "001";
  constant op_ld8_c : std_logic_vector(2 downto 0) := "010";
  constant op_ldu16_c : std_logic_vector(2 downto 0) := "011";
  constant op_ldu8_c : std_logic_vector(2 downto 0) := "100";
  constant op_st16_c : std_logic_vector(2 downto 0) := "101";
  constant op_st32_c : std_logic_vector(2 downto 0) := "110";
  constant op_st8_c : std_logic_vector(2 downto 0) := "111";

  signal ld16_op1 : std_logic_vector(63 downto 0);
  signal ld16_op2 : std_logic_vector(31 downto 0);
  signal ld32_op1 : std_logic_vector(63 downto 0);
  signal ld32_op2 : std_logic_vector(31 downto 0);
  signal ld8_op1 : std_logic_vector(63 downto 0);
  signal ld8_op2 : std_logic_vector(31 downto 0);
  signal ldu16_op1 : std_logic_vector(63 downto 0);
  signal ldu16_op2 : std_logic_vector(31 downto 0);
  signal ldu8_op1 : std_logic_vector(63 downto 0);
  signal ldu8_op2 : std_logic_vector(31 downto 0);
  signal st16_op1 : std_logic_vector(31 downto 0);
  signal st16_op2 : std_logic_vector(15 downto 0);
  signal st32_op1 : std_logic_vector(63 downto 0);
  signal st32_op2 : std_logic_vector(31 downto 0);
  signal st8_op1 : std_logic_vector(31 downto 0);
  signal st8_op2 : std_logic_vector(7 downto 0);
  signal lsu_registers_32_1_clk : std_logic;
  signal lsu_registers_32_1_rstx : std_logic;
  signal lsu_registers_32_1_glock_in : std_logic;
  signal lsu_registers_32_1_glockreq_out : std_logic;
  signal lsu_registers_32_1_avalid_in : std_logic;
  signal lsu_registers_32_1_awren_in : std_logic;
  signal lsu_registers_32_1_aaddr_in : std_logic_vector(addrw_c-1+1-1 downto 0);
  signal lsu_registers_32_1_astrb_in : std_logic_vector(4-1+1-1 downto 0);
  signal lsu_registers_32_1_adata_in : std_logic_vector(32-1+1-1 downto 0);
  signal lsu_registers_32_1_avalid_out : std_logic;
  signal lsu_registers_32_1_aready_in : std_logic;
  signal lsu_registers_32_1_aaddr_out : std_logic_vector(addrw_c-2-1+1-1 downto 0);
  signal lsu_registers_32_1_awren_out : std_logic;
  signal lsu_registers_32_1_astrb_out : std_logic_vector(4-1+1-1 downto 0);
  signal lsu_registers_32_1_adata_out : std_logic_vector(32-1+1-1 downto 0);
  signal lsu_registers_32_1_rvalid_in : std_logic;
  signal lsu_registers_32_1_rready_out : std_logic;
  signal lsu_registers_32_1_rdata_in : std_logic_vector(32-1+1-1 downto 0);
  signal lsu_registers_32_1_rdata_out : std_logic_vector(32-1+1-1 downto 0);
  signal lsu_registers_32_1_addr_low_out : std_logic_vector(2-1+1-1 downto 0);
  signal data_in1t : std_logic_vector(31 downto 0);
  signal data_in2 : std_logic_vector(31 downto 0);
  signal strobe_32b : std_logic_vector(3 downto 0);
  signal write_data_32b : std_logic_vector(31 downto 0);
  signal load_data_32b : std_logic_vector(31 downto 0);
  signal data_out1 : std_logic_vector(31 downto 0);
  signal glockreq : std_logic;

  signal shadow_in2_r : std_logic_vector(31 downto 0);
  signal operation_1_r : std_logic_vector(2 downto 0);
  signal optrig_1_r : std_logic;
  signal operation_2_r : std_logic_vector(2 downto 0);
  signal optrig_2_r : std_logic;
  signal operation_3_r : std_logic_vector(2 downto 0);
  signal optrig_3_r : std_logic;
  signal data_out1_1_r : std_logic_vector(31 downto 0);
  signal data_out1_1_valid_r : std_logic;
  signal data_out1_r : std_logic_vector(31 downto 0);

  component lsu_registers is
    generic (
      dataw_g : integer;
      low_bits_g : integer;
      addrw_g : integer);
    port (
      clk : in std_logic;
      rstx : in std_logic;
      glock_in : in std_logic;
      glockreq_out : out std_logic;
      avalid_in : in std_logic;
      awren_in : in std_logic;
      aaddr_in : in std_logic_vector(addrw_c-1+1-1 downto 0);
      astrb_in : in std_logic_vector(4-1+1-1 downto 0);
      adata_in : in std_logic_vector(32-1+1-1 downto 0);
      avalid_out : out std_logic;
      aready_in : in std_logic;
      aaddr_out : out std_logic_vector(addrw_c-2-1+1-1 downto 0);
      awren_out : out std_logic;
      astrb_out : out std_logic_vector(4-1+1-1 downto 0);
      adata_out : out std_logic_vector(32-1+1-1 downto 0);
      rvalid_in : in std_logic;
      rready_out : out std_logic;
      rdata_in : in std_logic_vector(32-1+1-1 downto 0);
      rdata_out : out std_logic_vector(32-1+1-1 downto 0);
      addr_low_out : out std_logic_vector(2-1+1-1 downto 0));
  end component lsu_registers;

begin

  lsu_registers_32_1 : lsu_registers
    generic map (
      dataw_g => 32,
      low_bits_g => 2,
      addrw_g => addrw_c)
    port map (
      clk => clk,
      rstx => rstx,
      glock_in => glock_in,
      glockreq_out => lsu_registers_32_1_glockreq_out,
      avalid_in => lsu_registers_32_1_avalid_in,
      awren_in => lsu_registers_32_1_awren_in,
      aaddr_in => lsu_registers_32_1_aaddr_in,
      astrb_in => lsu_registers_32_1_astrb_in,
      adata_in => lsu_registers_32_1_adata_in,
      avalid_out => lsu_registers_32_1_avalid_out,
      aready_in => lsu_registers_32_1_aready_in,
      aaddr_out => lsu_registers_32_1_aaddr_out,
      awren_out => lsu_registers_32_1_awren_out,
      astrb_out => lsu_registers_32_1_astrb_out,
      adata_out => lsu_registers_32_1_adata_out,
      rvalid_in => lsu_registers_32_1_rvalid_in,
      rready_out => lsu_registers_32_1_rready_out,
      rdata_in => lsu_registers_32_1_rdata_in,
      rdata_out => lsu_registers_32_1_rdata_out,
      addr_low_out => lsu_registers_32_1_addr_low_out);

  data_in1t <= data_in1t_in;

  shadow_in2_sp : process(clk, rstx)
  begin
    if rstx = '0' then
      shadow_in2_r <= (others => '0');
    elsif clk = '1' and clk'event then
      if ((glock_in = '0') and (load_in2_in = '1')) then
        shadow_in2_r <= data_in2_in;
      end if;
    end if;
  end process shadow_in2_sp;

  shadow_in2_cp : process(shadow_in2_r, data_in2_in, load_in1t_in, load_in2_in)
  begin
    if ((load_in1t_in = '1') and (load_in2_in = '1')) then
      data_in2 <= data_in2_in;
    else
      data_in2 <= shadow_in2_r;
    end if;
  end process shadow_in2_cp;

  input_pipeline_sp : process(clk, rstx)
  begin
    if rstx = '0' then
      operation_1_r <= (others => '0');
      optrig_3_r <= '0';
      operation_3_r <= (others => '0');
      optrig_2_r <= '0';
      optrig_1_r <= '0';
      operation_2_r <= (others => '0');
    elsif clk = '1' and clk'event then
      if (glock_in = '0') then
        optrig_1_r <= load_in1t_in;
        operation_2_r <= operation_1_r;
        optrig_2_r <= optrig_1_r;
        operation_3_r <= operation_2_r;
        optrig_3_r <= optrig_2_r;
        if (load_in1t_in = '1') then
          operation_1_r <= operation_in;
        end if;
      end if;
    end if;
  end process input_pipeline_sp;

  operations_actual_cp : process(optrig_2_r, operation_2_r, operation_in, load_in1t_in, strobe_32b, ldu16_op1, ldu8_op1, ld16_op1, data_in2, ld32_op1, st16_op2, lsu_registers_32_1_adata_out, lsu_registers_32_1_aaddr_out, lsu_registers_32_1_awren_out, rvalid_in, lsu_registers_32_1_glockreq_out, ld8_op1, lsu_registers_32_1_avalid_out, load_data_32b, lsu_registers_32_1_rready_out, st8_op1, lsu_registers_32_1_rdata_out, data_in1t, st32_op1, rdata_in, write_data_32b, st32_op2, lsu_registers_32_1_astrb_out, aready_in, st16_op1, lsu_registers_32_1_addr_low_out, st8_op2)
  begin
    aaddr_out <= (others => '0');
    adata_out <= (others => '0');
    astrb_out <= (others => '0');
    avalid_out <= (others => '0');
    awren_out <= (others => '0');
    rready_out <= (others => '0');
    lsu_registers_32_1_clk <= '-';
    lsu_registers_32_1_rstx <= '-';
    lsu_registers_32_1_glock_in <= '-';
    lsu_registers_32_1_avalid_in <= '-';
    lsu_registers_32_1_awren_in <= '-';
    lsu_registers_32_1_aaddr_in <= (others => '-');
    lsu_registers_32_1_astrb_in <= (others => '-');
    lsu_registers_32_1_adata_in <= (others => '-');
    lsu_registers_32_1_aready_in <= '-';
    lsu_registers_32_1_rvalid_in <= '-';
    lsu_registers_32_1_rdata_in <= (others => '-');
    strobe_32b <= (others => '-');
    write_data_32b <= (others => '-');
    load_data_32b <= (others => '-');
    st8_op1 <= data_in1t;
    st8_op2 <= data_in2(7 downto 0);
    st32_op1 <= ((64-1 downto 32 => '0') & data_in1t);
    st32_op2 <= data_in2;
    ld32_op2 <= (others => '-');
    ld32_op1 <= ((64-1 downto 32 => '0') & data_in1t);
    ld16_op2 <= (others => '-');
    ld16_op1 <= ((64-1 downto 32 => '0') & data_in1t);
    ld8_op2 <= (others => '-');
    ld8_op1 <= ((64-1 downto 32 => '0') & data_in1t);
    st16_op1 <= data_in1t;
    st16_op2 <= data_in2(15 downto 0);
    ldu8_op2 <= (others => '-');
    ldu8_op1 <= ((64-1 downto 32 => '0') & data_in1t);
    ldu16_op2 <= (others => '-');
    ldu16_op1 <= ((64-1 downto 32 => '0') & data_in1t);
    glockreq <= '0';
    lsu_registers_32_1_avalid_in <= '0';
    lsu_registers_32_1_awren_in <= '0';
    lsu_registers_32_1_aaddr_in <= (others => '0');
    lsu_registers_32_1_astrb_in <= (others => '0');
    lsu_registers_32_1_adata_in <= (others => '0');
    
    avalid_out(0) <= lsu_registers_32_1_avalid_out;
    lsu_registers_32_1_aready_in <= aready_in(0);
    aaddr_out <= lsu_registers_32_1_aaddr_out;
    awren_out(0) <= lsu_registers_32_1_awren_out;
    astrb_out <= lsu_registers_32_1_astrb_out;
    adata_out <= lsu_registers_32_1_adata_out;
    
    lsu_registers_32_1_rvalid_in <= rvalid_in(0);
    rready_out(0) <= lsu_registers_32_1_rready_out;
    lsu_registers_32_1_rdata_in <= rdata_in;
    
    glockreq <= lsu_registers_32_1_glockreq_out;
    if (load_in1t_in = '1') then
      case operation_in is
        when op_ld16_c =>
          lsu_registers_32_1_avalid_in <= '1';
          lsu_registers_32_1_aaddr_in <= ld16_op1(addrw_c-1 downto 0);
          lsu_registers_32_1_awren_in <= '0';
        when op_ld32_c =>
          lsu_registers_32_1_avalid_in <= '1';
          lsu_registers_32_1_aaddr_in <= ld32_op1(addrw_c-1 downto 0);
          lsu_registers_32_1_awren_in <= '0';
        when op_ld8_c =>
          lsu_registers_32_1_avalid_in <= '1';
          lsu_registers_32_1_aaddr_in <= ld8_op1(addrw_c-1 downto 0);
          lsu_registers_32_1_awren_in <= '0';
        when op_ldu16_c =>
          lsu_registers_32_1_avalid_in <= '1';
          lsu_registers_32_1_aaddr_in <= ldu16_op1(addrw_c-1 downto 0);
          lsu_registers_32_1_awren_in <= '0';
        when op_ldu8_c =>
          lsu_registers_32_1_avalid_in <= '1';
          lsu_registers_32_1_aaddr_in <= ldu8_op1(addrw_c-1 downto 0);
          lsu_registers_32_1_awren_in <= '0';
        when op_st16_c =>
          lsu_registers_32_1_avalid_in <= '1';
          lsu_registers_32_1_awren_in <= '1';
          lsu_registers_32_1_aaddr_in <= st16_op1(addrw_c-1 downto 0);
          strobe_32b <= "0000";
          write_data_32b <= "00000000000000000000000000000000";
          case st16_op1(1 downto 1) is
            when "0" => 
              strobe_32b(1 downto 0) <= "11";
              write_data_32b(15 downto 0) <= st16_op2;
            when others => 
              strobe_32b(3 downto 2) <= "11";
              write_data_32b(31 downto 16) <= st16_op2;
          end case;
          lsu_registers_32_1_adata_in <= write_data_32b;
          lsu_registers_32_1_astrb_in <= strobe_32b;
        when op_st32_c =>
          lsu_registers_32_1_avalid_in <= '1';
          lsu_registers_32_1_awren_in <= '1';
          lsu_registers_32_1_aaddr_in <= st32_op1(addrw_c-1 downto 0);
          lsu_registers_32_1_adata_in <= st32_op2;
          lsu_registers_32_1_astrb_in <= "1111";
        when op_st8_c =>
          lsu_registers_32_1_avalid_in <= '1';
          lsu_registers_32_1_awren_in <= '1';
          lsu_registers_32_1_aaddr_in <= st8_op1(addrw_c-1 downto 0);
          strobe_32b <= "0000";
          write_data_32b <= "00000000000000000000000000000000";
          case st8_op1(1 downto 0) is
            when "00" => 
              strobe_32b(0 downto 0) <= "1";
              write_data_32b(7 downto 0) <= st8_op2;
            when "01" => 
              strobe_32b(1 downto 1) <= "1";
              write_data_32b(15 downto 8) <= st8_op2;
            when "10" => 
              strobe_32b(2 downto 2) <= "1";
              write_data_32b(23 downto 16) <= st8_op2;
            when others => 
              strobe_32b(3 downto 3) <= "1";
              write_data_32b(31 downto 24) <= st8_op2;
          end case;
          lsu_registers_32_1_adata_in <= write_data_32b;
          lsu_registers_32_1_astrb_in <= strobe_32b;
        when others =>
      end case;
    end if;
    if (optrig_2_r = '1') then
      case operation_2_r is
        when op_ld16_c =>
          load_data_32b <= lsu_registers_32_1_rdata_out;
          case lsu_registers_32_1_addr_low_out(1 downto 1) is
            when "0" => ld16_op2 <= (16-1 downto 0 => load_data_32b(15)) & load_data_32b(15 downto 0);
            when others => ld16_op2 <= (16-1 downto 0 => load_data_32b(31)) & load_data_32b(31 downto 16);
          end case;
        when op_ld32_c =>
          load_data_32b <= lsu_registers_32_1_rdata_out;
          ld32_op2 <= load_data_32b;
        when op_ld8_c =>
          load_data_32b <= lsu_registers_32_1_rdata_out;
          case lsu_registers_32_1_addr_low_out(1 downto 0) is
            when "00" => ld8_op2 <= (24-1 downto 0 => load_data_32b(7)) & load_data_32b(7 downto 0);
            when "01" => ld8_op2 <= (24-1 downto 0 => load_data_32b(15)) & load_data_32b(15 downto 8);
            when "10" => ld8_op2 <= (24-1 downto 0 => load_data_32b(23)) & load_data_32b(23 downto 16);
            when others => ld8_op2 <= (24-1 downto 0 => load_data_32b(31)) & load_data_32b(31 downto 24);
          end case;
        when op_ldu16_c =>
          load_data_32b <= lsu_registers_32_1_rdata_out;
          case lsu_registers_32_1_addr_low_out(1 downto 1) is
            when "0" => ldu16_op2 <= "0000000000000000" & load_data_32b(15 downto 0);
            when others => ldu16_op2 <= "0000000000000000" & load_data_32b(31 downto 16);
          end case;
        when op_ldu8_c =>
          load_data_32b <= lsu_registers_32_1_rdata_out;
          case lsu_registers_32_1_addr_low_out(1 downto 0) is
            when "00" => ldu8_op2 <= "000000000000000000000000" & load_data_32b(7 downto 0);
            when "01" => ldu8_op2 <= "000000000000000000000000" & load_data_32b(15 downto 8);
            when "10" => ldu8_op2 <= "000000000000000000000000" & load_data_32b(23 downto 16);
            when others => ldu8_op2 <= "000000000000000000000000" & load_data_32b(31 downto 24);
          end case;
        when others =>
      end case;
    end if;
  end process operations_actual_cp;

  output_pipeline_sp : process(clk, rstx)
  begin
    if rstx = '0' then
      data_out1_r <= (others => '0');
      data_out1_1_valid_r <= '0';
      data_out1_1_r <= (others => '0');
    elsif clk = '1' and clk'event then
      if (glock_in = '0') then
        data_out1_1_valid_r <= '1';
        if ((operation_2_r = op_ldu8_c) and (optrig_2_r = '1')) then
          data_out1_1_r <= ldu8_op2;
        elsif ((operation_2_r = op_ldu16_c) and (optrig_2_r = '1')) then
          data_out1_1_r <= ldu16_op2;
        elsif ((operation_2_r = op_ld8_c) and (optrig_2_r = '1')) then
          data_out1_1_r <= ld8_op2;
        elsif ((operation_2_r = op_ld32_c) and (optrig_2_r = '1')) then
          data_out1_1_r <= ld32_op2;
        elsif ((operation_2_r = op_ld16_c) and (optrig_2_r = '1')) then
          data_out1_1_r <= ld16_op2;
        else
          data_out1_1_valid_r <= '0';
        end if;
        data_out1_r <= data_out1;
      end if;
    end if;
  end process output_pipeline_sp;

  output_pipeline_cp : process(data_out1, data_out1_1_r)
  begin
    data_out1 <= data_out1_1_r;
    data_out1_out <= data_out1;
  end process output_pipeline_cp;
  glockreq_out <= glockreq;

end architecture rtl;

