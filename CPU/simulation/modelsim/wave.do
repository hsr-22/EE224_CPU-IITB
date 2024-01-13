onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk /testbench/clk
add wave -noupdate -label { Current Instruction} -radix decimal /testbench/CPU_instance/path_of_data/rf/r_out(7)
add wave -noupdate -label state -radix unsigned /testbench/CPU_instance/path_of_data/state
add wave -noupdate -divider -height 30 {Stateful Parts}
add wave -noupdate -group Memory -label MEM_29 /testbench/CPU_instance/path_of_data/mem/mem_vals(29)
add wave -noupdate -group Memory -label {Write Enable} /testbench/CPU_instance/path_of_data/mem/m_wr
add wave -noupdate -group Memory -label {Read Enable} /testbench/CPU_instance/path_of_data/mem/m_rd
add wave -noupdate -group Memory -label Address -radix unsigned /testbench/CPU_instance/path_of_data/mem/mem_addr
add wave -noupdate -group Memory -label Mem_in /testbench/CPU_instance/path_of_data/mem/mem_in
add wave -noupdate -group Memory -label Mem_out /testbench/CPU_instance/path_of_data/mem/mem_out
add wave -noupdate -group {Register File} -label A1 -radix unsigned /testbench/CPU_instance/path_of_data/rf/A1
add wave -noupdate -group {Register File} -label A2 -radix unsigned /testbench/CPU_instance/path_of_data/rf/A2
add wave -noupdate -group {Register File} -label A3 -radix unsigned /testbench/CPU_instance/path_of_data/rf/A3
add wave -noupdate -group {Register File} -label D3 -radix decimal /testbench/CPU_instance/path_of_data/rf/D3
add wave -noupdate -group {Register File} -label RF_wenable /testbench/CPU_instance/path_of_data/rf/w_enable
add wave -noupdate -group {Register File} -label D1 -radix decimal /testbench/CPU_instance/path_of_data/rf/D1
add wave -noupdate -group {Register File} -label D2 -radix decimal /testbench/CPU_instance/path_of_data/rf/D2
add wave -noupdate -group {Register File} -label Outputs -radix decimal -childformat {{/testbench/CPU_instance/path_of_data/rf/r_out(7) -radix decimal} {/testbench/CPU_instance/path_of_data/rf/r_out(6) -radix decimal} {/testbench/CPU_instance/path_of_data/rf/r_out(5) -radix decimal} {/testbench/CPU_instance/path_of_data/rf/r_out(4) -radix decimal} {/testbench/CPU_instance/path_of_data/rf/r_out(3) -radix decimal} {/testbench/CPU_instance/path_of_data/rf/r_out(2) -radix decimal} {/testbench/CPU_instance/path_of_data/rf/r_out(1) -radix decimal} {/testbench/CPU_instance/path_of_data/rf/r_out(0) -radix decimal}} -expand -subitemconfig {/testbench/CPU_instance/path_of_data/rf/r_out(7) {-height 15 -radix decimal} /testbench/CPU_instance/path_of_data/rf/r_out(6) {-height 15 -radix decimal} /testbench/CPU_instance/path_of_data/rf/r_out(5) {-height 15 -radix decimal} /testbench/CPU_instance/path_of_data/rf/r_out(4) {-height 15 -radix decimal} /testbench/CPU_instance/path_of_data/rf/r_out(3) {-height 15 -radix decimal} /testbench/CPU_instance/path_of_data/rf/r_out(2) {-height 15 -radix decimal} /testbench/CPU_instance/path_of_data/rf/r_out(1) {-height 15 -radix decimal} /testbench/CPU_instance/path_of_data/rf/r_out(0) {-height 15 -radix decimal}} /testbench/CPU_instance/path_of_data/rf/r_out
add wave -noupdate -group {Register File} -label Enables /testbench/CPU_instance/path_of_data/rf/w_enable_int
add wave -noupdate -divider {Temp Registers}
add wave -noupdate -group T_rf -label T_rf_input -radix unsigned /testbench/CPU_instance/path_of_data/reg3/input
add wave -noupdate -group T_rf -label T_rf_wenable /testbench/CPU_instance/path_of_data/reg3/w_enable
add wave -noupdate -group T_rf -label T_rf_output -radix unsigned /testbench/CPU_instance/path_of_data/reg3/output
add wave -noupdate -expand -group T_pc -label input -radix unsigned /testbench/CPU_instance/path_of_data/reg16_pc/input
add wave -noupdate -expand -group T_pc -label wenable /testbench/CPU_instance/path_of_data/reg16_pc/w_enable
add wave -noupdate -expand -group T_pc -label output -radix unsigned /testbench/CPU_instance/path_of_data/reg16_pc/output
add wave -noupdate -expand -group T_c -label input -radix decimal /testbench/CPU_instance/path_of_data/reg16_c/input
add wave -noupdate -expand -group T_c -label wenable /testbench/CPU_instance/path_of_data/reg16_c/w_enable
add wave -noupdate -expand -group T_c -label output -radix decimal /testbench/CPU_instance/path_of_data/reg16_c/output
add wave -noupdate -divider Components
add wave -noupdate -group ALU -label A /testbench/CPU_instance/path_of_data/alucomp/A
add wave -noupdate -group ALU -label B /testbench/CPU_instance/path_of_data/alucomp/B
add wave -noupdate -group ALU -label opcode /testbench/CPU_instance/path_of_data/alucomp/opcode
add wave -noupdate -group ALU -label {z flag} /testbench/CPU_instance/path_of_data/alucomp/z_flag
add wave -noupdate -group ALU -label C /testbench/CPU_instance/path_of_data/alucomp/C
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {165474 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {884208 ps}
