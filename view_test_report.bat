@echo off
setlocal enabledelayedexpansion
echo Cargo Tracker JMeter Load Test Results
echo ====================================
echo.

if not exist "jmeter_results" (
    echo No test results found. Please run load tests first.
    echo.
    pause
    exit /b
)

echo Available test reports:
echo.

set counter=0
for /d %%i in (jmeter_results\*_report) do (
    set /a counter+=1
    echo !counter!. %%~ni
)

if %counter% equ 0 (
    echo No test reports found. Please run load tests first.
    echo.
    pause
    exit /b
)

echo.
set /p choice="Enter the number of the report you want to view (1-%counter%): "

set selected=0
set target=

for /d %%i in (jmeter_results\*_report) do (
    set /a selected+=1
    if !selected! equ %choice% (
        set target=%%i
    )
)

if "%target%"=="" (
    echo Invalid selection.
    pause
    exit /b
)

echo Opening report in your default browser...
start "" "%target%\index.html"
echo.
pause
