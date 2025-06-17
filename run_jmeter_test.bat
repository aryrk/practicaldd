@echo off
echo Running JMeter Test Plan for Cargo Tracker Application
echo.

set JMETER_HOME=jmeter\apache-jmeter-5.6.2
set TEST_FILE=cargotracker_test_plan.jmx
set RESULTS_FOLDER=jmeter_results

if not exist %RESULTS_FOLDER% mkdir %RESULTS_FOLDER%

echo Select the number of users to test:
echo 1. 100 Users
echo 2. 500 Users
echo 3. 1000 Users
echo 4. 5000 Users
echo 5. 10000 Users
echo.

set /p choice="Enter your choice (1-5): "

set USER_COUNT=100
set FILENAME=cargo_tracker_100_users

if "%choice%"=="1" (
    set USER_COUNT=100
    set FILENAME=cargo_tracker_100_users
) else if "%choice%"=="2" (
    set USER_COUNT=500
    set FILENAME=cargo_tracker_500_users
) else if "%choice%"=="3" (
    set USER_COUNT=1000
    set FILENAME=cargo_tracker_1000_users
) else if "%choice%"=="4" (
    set USER_COUNT=5000
    set FILENAME=cargo_tracker_5000_users
) else if "%choice%"=="5" (
    set USER_COUNT=10000
    set FILENAME=cargo_tracker_10000_users
) else (
    echo Invalid choice. Using default: 100 Users
)

echo.
echo Running test with %USER_COUNT% users...
echo.

REM Enable the correct thread group based on user count choice
%JMETER_HOME%\bin\jmeter -n -t %TEST_FILE% -l %RESULTS_FOLDER%\%FILENAME%_results.jtl -j %RESULTS_FOLDER%\%FILENAME%_log.log -e -o %RESULTS_FOLDER%\%FILENAME%_report ^
  -Jthreadgroup.100\ Users.enabled=%choice%==1 ^
  -Jthreadgroup.500\ Users.enabled=%choice%==2 ^
  -Jthreadgroup.1000\ Users.enabled=%choice%==3 ^
  -Jthreadgroup.5000\ Users.enabled=%choice%==4 ^
  -Jthreadgroup.10000\ Users.enabled=%choice%==5

echo.
echo Test completed. Results saved to %RESULTS_FOLDER%\%FILENAME%_results.jtl
echo HTML report generated at %RESULTS_FOLDER%\%FILENAME%_report
echo.

pause
