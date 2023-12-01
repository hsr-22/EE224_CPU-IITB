transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Lenovo/OneDrive/Documents/EE214_Digital_Lab/Test/Signed_Extender/Signed_Extender.vhd}

vcom -93 -work work {C:/Users/Lenovo/OneDrive/Documents/EE214_Digital_Lab/Test/Signed_Extender/Testbench_6.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Testbench_6

add wave *
view structure
view signals
run -all
