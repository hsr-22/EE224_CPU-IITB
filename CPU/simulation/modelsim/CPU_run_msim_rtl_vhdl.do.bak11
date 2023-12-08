transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Signed_Extender.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Register.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Memory.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Left_Shifter.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Generic_Mux.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/FSM.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Decoder_3_To_8.vhdl}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Decoder_2_To_4.vhdl}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Decoder_1_To_2.vhdl}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/datapath.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/ALU.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/CPU.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Testbench.vhd}
vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Programmer_Register.vhd}

vcom -93 -work work {C:/Users/harsh/GitHub Desktop/EE224_CPU-IITB/CPU/CPU/Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
