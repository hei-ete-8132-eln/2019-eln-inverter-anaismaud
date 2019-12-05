onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {Reset and clock} /invertercontrol_tb/reset
add wave -noupdate -group {Reset and clock} /invertercontrol_tb/clock
add wave -noupdate -expand -group Controls /invertercontrol_tb/threeLevel
add wave -noupdate -expand -group Controls /invertercontrol_tb/switchEvenOdd
add wave -noupdate -expand -group Controls /invertercontrol_tb/doubleFrequency
add wave -noupdate -expand -group {Sine wave} /invertercontrol_tb/sampleEn
add wave -noupdate -expand -group {Sine wave} -format Analog-Step -height 50 -max 16000000.0 -radix unsigned -childformat {{/invertercontrol_tb/I_DUT/phase(23) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(22) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(21) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(20) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(19) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(18) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(17) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(16) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(15) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(14) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(13) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(12) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(11) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(10) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(9) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(8) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(7) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(6) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(5) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(4) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(3) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(2) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(1) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(0) -radix unsigned}} -radixshowbase 0 -subitemconfig {/invertercontrol_tb/I_DUT/phase(23) {-height 16 -radix unsigned -radixshowbase 0} /invertercontrol_tb/I_DUT/phase(22) {-height 16 -radix unsigned -radixshowbase 0} /invertercontrol_tb/I_DUT/phase(21) {-height 16 -radix unsigned -radixshowbase 0} /invertercontrol_tb/I_DUT/phase(20) {-height 16 -radix unsigned -radixshowbase 0} /invertercontrol_tb/I_DUT/phase(19) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(18) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(17) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(16) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(15) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(14) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(13) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(12) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(11) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(10) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(9) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(8) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(7) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(6) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(5) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(4) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(3) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(2) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(1) {-height 16 -radix unsigned} /invertercontrol_tb/I_DUT/phase(0) {-height 16 -radix unsigned}} /invertercontrol_tb/I_DUT/phase
add wave -noupdate -expand -group {Sine wave} /invertercontrol_tb/trigger
add wave -noupdate -expand -group {Sine wave} -format Analog-Step -height 50 -max 500.0 -min -500.0 -radix decimal -radixshowbase 0 /invertercontrol_tb/I_DUT/sine
add wave -noupdate -expand -group PWM /invertercontrol_tb/pwmCountEn
add wave -noupdate -expand -group PWM -format Analog-Step -height 30 -max 500.0 -min -500.0 -radix decimal -radixshowbase 0 /invertercontrol_tb/I_DUT/I_PWM/sawtooth
add wave -noupdate -expand -group PWM /invertercontrol_tb/I_DUT/I_PWM/even_odd
add wave -noupdate -expand -group PWM /invertercontrol_tb/I_DUT/pwm1
add wave -noupdate -expand -group PWM /invertercontrol_tb/I_DUT/pwm2
add wave -noupdate -expand -group PWM -format Analog-Step -height 30 -max 1.0 -min -1.0 -radix decimal -radixshowbase 0 /invertercontrol_tb/I_tester/pwm
add wave -noupdate -group {Non-overlapping controls} /invertercontrol_tb/pwm1High
add wave -noupdate -group {Non-overlapping controls} /invertercontrol_tb/pwm1Low_n
add wave -noupdate -group {Non-overlapping controls} /invertercontrol_tb/pwm2High
add wave -noupdate -group {Non-overlapping controls} /invertercontrol_tb/pwm2Low_n
add wave -noupdate -expand -group {Filtered outputs} -format Analog-Step -height 50 -max 1.0 -min -1.0 /invertercontrol_tb/I_tester/lowpassOutput1
add wave -noupdate -expand -group {Filtered outputs} -format Analog-Step -height 50 -max 1.0 -min -1.0 /invertercontrol_tb/I_tester/lowpassOutput2
add wave -noupdate -expand -group {Filtered outputs} -format Analog-Step -height 100 -max 2.0 -min -2.0 /invertercontrol_tb/I_tester/pwmFiltered
add wave -noupdate -expand -group Measurements /invertercontrol_tb/I_tester/measuredFrequency
add wave -noupdate -expand -group Measurements -radix unsigned -radixshowbase 0 /invertercontrol_tb/I_tester/measuredDeadTimeNs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 331
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {16800 us}
