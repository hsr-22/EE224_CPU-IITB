transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Lenovo/OneDrive/Documents/EE214_Digital_Lab/Test/Registers/Register.vhd}
vcom -93 -work work {C:/Users/Lenovo/OneDrive/Documents/EE214_Digital_Lab/Test/Registers/Testbench.vhd}
vcom -93 -work work {C:/Users/Lenovo/OneDrive/Documents/EE214_Digital_Lab/Test/Registers/DUT.vhd}
vcom -93 -work work {C:/Users/Lenovo/OneDrive/Documents/EE214_Digital_Lab/Test/Registers/DUT_RF.vhd}
vcom -93 -work work {C:/Users/Lenovo/OneDrive/Documents/EE214_Digital_Lab/Test/Registers/Testbench_RF.vhd}
vcom -93 -work work {C:/Users/Lenovo/OneDrive/Documents/EE214_Digital_Lab/Test/Registers/Programmer_Register.vhd}

vcom -93 -work work {C:/Users/Lenovo/OneDrive/Documents/EE214_Digital_Lab/Test/Registers/Testbench_RF.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Testbench_RF

add wave *
view structure
view signals
run -all
