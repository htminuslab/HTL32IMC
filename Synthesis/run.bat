@echo off
cls

rmdir /S/Q outflow
rmdir /S/Q work_pnr
rmdir /S/Q work_syn
rmdir /S/Q work_pt
rmdir /S/Q ip
del /Q  rv32sys.peri.xml


python generate_xml.py
call efx_run.bat generated_project.xml --flow compile
python results.py outflow/rv32sys.place.rpt "Resource Summary (begin)" "Resource Summary (end)"
python results.py outflow/rv32sys.timing.rpt "Frequency Summary (begin)" "Frequency Summary (end)"
@echo on