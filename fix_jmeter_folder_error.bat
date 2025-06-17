@echo off
echo JMeter "Folder is not empty" Error Fix
echo ==================================
echo.

if not exist "jmeter_results" (
    echo No jmeter_results folder found. Creating it...
    mkdir "jmeter_results"
    echo Done!
    goto :end
)

echo This utility will help fix the "Cannot write as folder is not empty" error
echo by cleaning specific test result folders.
echo.

echo Which test result folder do you want to clean?
echo 1. 100 Users test results
echo 2. 500 Users test results
echo 3. 1000 Users test results
echo 4. 5000 Users test results
echo 5. 10000 Users test results
echo 6. ALL test results (complete cleanup)
echo.

set /p choice="Enter your choice (1-6): "
echo.

if "%choice%"=="1" (
    call :clean_folder cargo_tracker_100_users
) else if "%choice%"=="2" (
    call :clean_folder cargo_tracker_500_users
) else if "%choice%"=="3" (
    call :clean_folder cargo_tracker_1000_users
) else if "%choice%"=="4" (
    call :clean_folder cargo_tracker_5000_users
) else if "%choice%"=="5" (
    call :clean_folder cargo_tracker_10000_users
) else if "%choice%"=="6" (
    echo Cleaning ALL test results...
    rmdir /s /q "jmeter_results"
    mkdir "jmeter_results"
    echo All test results have been removed and the folder recreated.
) else (
    echo Invalid choice! Please try again.
    goto :eof
)

goto :end

:clean_folder
echo Cleaning %1 test results...

if exist "jmeter_results\%1_report" (
    echo Removing %1_report folder...
    rmdir /s /q "jmeter_results\%1_report"
)

if exist "jmeter_results\%1_results.jtl" (
    echo Removing %1_results.jtl file...
    del /f /q "jmeter_results\%1_results.jtl"
)

echo Done cleaning %1 test results!
goto :eof

:end
echo.
echo Cleanup completed! You should now be able to run the tests without the
echo "Cannot write as folder is not empty" error.
echo.
pause
