@echo off
echo Cargo Tracker - JMeter Load Testing
echo ================================
echo.

REM Create results directory if it doesn't exist
if not exist "jmeter_results" mkdir jmeter_results

REM Pull JMeter Docker image if not already available
echo Pulling JMeter Docker image...
docker pull justb4/jmeter:5.5
echo.

echo Choose the number of users to simulate:
echo 1. 100 Users (Quick test)
echo 2. 500 Users (Small scale test)
echo 3. 1000 Users (Medium scale test)
echo 4. 5000 Users (Large scale test)
echo 5. 10000 Users (Extreme scale test)
echo 6. Run all tests sequentially
echo 7. Clean all previous test results
echo.

set /p choice="Enter your choice (1-7): "
echo.

if "%choice%"=="1" (
    call :run_test 100 10
) else if "%choice%"=="2" (
    call :run_test 500 30
) else if "%choice%"=="3" (
    call :run_test 1000 60
) else if "%choice%"=="4" (
    call :run_test 5000 120
) else if "%choice%"=="5" (
    call :run_test 10000 300
) else if "%choice%"=="6" (
    echo Running all tests sequentially...
    echo This will take a long time. Press Ctrl+C to cancel.
    timeout /t 5
    
    call :run_test 100 10
    call :run_test 500 30
    call :run_test 1000 60
    call :run_test 5000 120
    call :run_test 10000 300
    
    echo All tests completed!
) else if "%choice%"=="7" (
    call :clean_results
) else (
    echo Invalid choice! Please try again.
    goto :eof
)

echo.
echo Testing completed! You can find the results in the jmeter_results folder.
echo To view the results, open jmeter_results/cargo_tracker_XXXXX_users_report/index.html in your browser.
echo.
pause
goto :eof

:clean_results
echo Cleaning all previous test results...
if exist "jmeter_results" (
    echo Removing jmeter_results directory...
    rmdir /s /q "jmeter_results"
    mkdir "jmeter_results"
    echo Directory cleaned and recreated.
) else (
    echo No previous results found.
)
echo.
goto :eof

:run_test
echo Running test with %1 users (ramp-up time: %2 seconds)...
echo.

set USER_COUNT=%1
set RAMP_UP=%2
set FILENAME=cargo_tracker_%1_users

echo Parameters:
echo - Number of users: %USER_COUNT%
echo - Ramp-up period: %RAMP_UP% seconds
echo - Results will be saved to: jmeter_results\%FILENAME%_results.jtl
echo - HTML report will be generated at: jmeter_results\%FILENAME%_report
echo.

REM Remove existing report folder and results file if exists to avoid "folder is not empty" error
if exist "jmeter_results\%FILENAME%_report" (
    echo Removing existing report folder...
    rmdir /s /q "jmeter_results\%FILENAME%_report"
)

if exist "jmeter_results\%FILENAME%_results.jtl" (
    echo Removing existing results file...
    del /f /q "jmeter_results\%FILENAME%_results.jtl"
)

REM Ensure we have proper permissions
echo Creating fresh test directories with proper permissions...
mkdir "jmeter_results\%FILENAME%_report" 2>nul
if exist "jmeter_results\%FILENAME%_report" rmdir /s /q "jmeter_results\%FILENAME%_report"

docker run --rm --network host -v "%cd%:/jmeter" -v "%cd%/jmeter_results:/results" justb4/jmeter:5.5 ^
    -n -t /jmeter/cargotracker_test_plan.jmx ^
    -l /results/%FILENAME%_results.jtl ^
    -e -o /results/%FILENAME%_report ^
    -Jhost=localhost ^
    -JnumThreads=%USER_COUNT% ^
    -JrampUpPeriods=%RAMP_UP%

echo.
echo Test with %USER_COUNT% users completed!
echo.

goto :eof
