@echo off
echo Cargo Tracker JMeter Load Testing Guide
echo =====================================
echo.
echo This guide will help you use JMeter to run load tests on the Cargo Tracker application.
echo.

:menu
echo What would you like to do?
echo 1. Run load tests
echo 2. View test reports
echo 3. Clean previous test results
echo 4. Fix "folder is not empty" error
echo 5. Show help
echo 6. Exit
echo.

set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" (
    call run_load_tests.bat
) else if "%choice%"=="2" (
    call view_test_report.bat
) else if "%choice%"=="3" (
    if exist "jmeter_results" (
        echo Removing jmeter_results directory...
        rmdir /s /q "jmeter_results"
        mkdir "jmeter_results"
        echo Directory cleaned and recreated.
    ) else (
        echo No previous results found.
    )
    echo.
    timeout /t 2 >nul
    goto menu
) else if "%choice%"=="4" (
    call fix_jmeter_folder_error.bat
    goto menu
) else if "%choice%"=="5" (
    cls
    echo Cargo Tracker JMeter Load Testing Guide
    echo =====================================
    echo.
    echo This tool helps you run load tests on Cargo Tracker application using JMeter.
    echo.
    echo Available Load Testing Scenarios:
    echo - 100 Users: Quick test to verify application functionality under light load
    echo - 500 Users: Small scale test to identify initial performance bottlenecks
    echo - 1000 Users: Medium scale test to simulate moderate production load
    echo - 5000 Users: Large scale test to simulate heavy production load
    echo - 10000 Users: Extreme test to identify system breaking points
    echo.
    echo Prerequisites:
    echo 1. Docker must be installed and running
    echo 2. Cargo Tracker application must be running (use docker compose up -d)
    echo.
    echo How to read test results:
    echo 1. Each test generates reports in jmeter_results folder
    echo 2. Use "View test reports" option to open HTML reports
    echo 3. Key metrics to look for:
    echo    - Response Time: Lower is better (shows application responsiveness)
    echo    - Throughput: Higher is better (shows how many requests system can handle)
    echo    - Error Rate: Lower is better (shows system stability)
    echo.
    pause
    cls
    goto menu
) else if "%choice%"=="6" (
    exit /b
) else (
    echo Invalid choice!
    echo.
    goto menu
)

cls
goto menu
