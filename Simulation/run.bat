@ECHO OFF
@REM Following line makes set commands take effect immiately inside an IF
@REM setlocal EnableDelayedExpansion

IF "%~1"=="" (
	call :usage
	exit /b
)

IF %1==compile (
    call :compile
) ELSE IF %1==hello (
    call :hello
) ELSE IF %1==coremark (
    call :coremark
) ELSE IF %1==timer (
    call :timer	
) ELSE (
    call :usage
)

exit /b


:compile
IF EXIST RISCV RMDIR /S /Q RISCV
@CALL compile.bat
exit /b
	
:hello
vcom -2008 -quiet -work RISCV ../tests/helloworld/bootloader.vhd 
goto sim

:coremark
@ECHO **** Note results are not correct ****
vcom -2008 -quiet -work RISCV ../tests/coremark/bootloader.vhd 
goto sim

:timer
vcom -2008 -quiet -work RISCV ../tests/timer_irq/bootloader.vhd 
goto sim


:sim
vopt -quiet -work RISCV rv32sys_tb -o rv32sys_tb_vopt
vsim -quiet -batch -qbase_tune RISCV.rv32sys_tb_vopt -t ps -do "set StdArithNoWarnings 1; set NumericStdNoWarnings 1; nolog -r /*; run -all; quit -f"	
exit /b


:usage

@ECHO ### Compile ........................ run compile
@ECHO ### Run Hello World example ........ run hello
@ECHO ### Run CoreMark example ........... run coremark
@ECHO ### Run Timer Interrupt example .... run timer

:end	
