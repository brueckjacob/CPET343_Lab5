@echo off

REM 1. Add Quartus to PATH for this script only
set PATH=C:\altera_lite\25.1std\quartus\bin64;%PATH%

REM 2. Run the TCL compile script
quartus_sh -t "C:\Users\Jacob\Downloads\CPET343_Lab5-main\CPET343_Lab5-main\lab5\toPost\fsm_add_sub\hw\compile.tcl"
pause

REM 3. Move to the output_files directory where the SOF is generated
cd /d "C:\Users\Jacob\Downloads\CPET343_Lab5-main\lab5\toPost\fsm_add_sub\hw\output_files"

REM 4. Program the FPGA over JTAG
quartus_pgm --mode=JTAG -o P;add_sub_state_machine.sof@2
pause
