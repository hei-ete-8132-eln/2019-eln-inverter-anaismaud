onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {Reset and clock} /nonoverlap_tb/reset
add wave -noupdate -group {Reset and clock} /nonoverlap_tb/clock
add wave -noupdate -expand -group Controls /nonoverlap_tb/driveen
add wave -noupdate -expand -group PWM -format Analog-Step -height 30 -max 256.0 -radix unsigned /nonoverlap_tb/i_tb/pwmcount
add wave -noupdate -expand -group PWM /nonoverlap_tb/pwmin
add wave -noupdate -expand -group PWM /nonoverlap_tb/pwmout
add wave -noupdate -expand -group PWM /nonoverlap_tb/pwmout_n
add wave -noupdate -expand -group Verification /nonoverlap_tb/i_tb/deadtime
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 285
configure wave -valuecolwidth 42
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {630 us}
