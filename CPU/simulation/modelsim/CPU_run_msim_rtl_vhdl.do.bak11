transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Signed_Extender.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Register.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Memory.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Left_Shifter.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Generic_Mux.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/FSM.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Decoder_3_To_8.vhdl}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Decoder_2_To_4.vhdl}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Decoder_1_To_2.vhdl}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/datapath.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/ALU.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/CPU.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Testbench.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Left_Shifter_2Mul.vhd}
vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Programmer_Register.vhd}

vcom -93 -work work {C:/Users/PRANAV PRAKASH/Projects/EE224_CPU-IITB/CPU/Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
