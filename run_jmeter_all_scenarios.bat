@echo off
echo Running JMeter Load Test (Headless Mode) for Cargo Tracker Application
echo.

set JMETER_HOME=jmeter\apache-jmeter-5.6.2
set TEST_FILE=cargotracker_test_plan.jmx
set RESULTS_FOLDER=jmeter_results

if not exist %RESULTS_FOLDER% mkdir %RESULTS_FOLDER%

REM Run tests for each load scenario sequentially
echo Running test with 100 users...
%JMETER_HOME%\bin\jmeter -n -t %TEST_FILE% ^
  -Jthreadgroup.100\ Users.enabled=true ^
  -Jthreadgroup.500\ Users.enabled=false ^
  -Jthreadgroup.1000\ Users.enabled=false ^
  -Jthreadgroup.5000\ Users.enabled=false ^
  -Jthreadgroup.10000\ Users.enabled=false ^
  -l %RESULTS_FOLDER%\cargo_tracker_100_users_results.jtl ^
  -e -o %RESULTS_FOLDER%\cargo_tracker_100_users_report

echo.
echo Running test with 500 users...
%JMETER_HOME%\bin\jmeter -n -t %TEST_FILE% ^
  -Jthreadgroup.100\ Users.enabled=false ^
  -Jthreadgroup.500\ Users.enabled=true ^
  -Jthreadgroup.1000\ Users.enabled=false ^
  -Jthreadgroup.5000\ Users.enabled=false ^
  -Jthreadgroup.10000\ Users.enabled=false ^
  -l %RESULTS_FOLDER%\cargo_tracker_500_users_results.jtl ^
  -e -o %RESULTS_FOLDER%\cargo_tracker_500_users_report

echo.
echo Running test with 1000 users...
%JMETER_HOME%\bin\jmeter -n -t %TEST_FILE% ^
  -Jthreadgroup.100\ Users.enabled=false ^
  -Jthreadgroup.500\ Users.enabled=false ^
  -Jthreadgroup.1000\ Users.enabled=true ^
  -Jthreadgroup.5000\ Users.enabled=false ^
  -Jthreadgroup.10000\ Users.enabled=false ^
  -l %RESULTS_FOLDER%\cargo_tracker_1000_users_results.jtl ^
  -e -o %RESULTS_FOLDER%\cargo_tracker_1000_users_report

echo.
echo Running test with 5000 users...
%JMETER_HOME%\bin\jmeter -n -t %TEST_FILE% ^
  -Jthreadgroup.100\ Users.enabled=false ^
  -Jthreadgroup.500\ Users.enabled=false ^
  -Jthreadgroup.1000\ Users.enabled=false ^
  -Jthreadgroup.5000\ Users.enabled=true ^
  -Jthreadgroup.10000\ Users.enabled=false ^
  -l %RESULTS_FOLDER%\cargo_tracker_5000_users_results.jtl ^
  -e -o %RESULTS_FOLDER%\cargo_tracker_5000_users_report

echo.
echo Running test with 10000 users...
%JMETER_HOME%\bin\jmeter -n -t %TEST_FILE% ^
  -Jthreadgroup.100\ Users.enabled=false ^
  -Jthreadgroup.500\ Users.enabled=false ^
  -Jthreadgroup.1000\ Users.enabled=false ^
  -Jthreadgroup.5000\ Users.enabled=false ^
  -Jthreadgroup.10000\ Users.enabled=true ^
  -l %RESULTS_FOLDER%\cargo_tracker_10000_users_results.jtl ^
  -e -o %RESULTS_FOLDER%\cargo_tracker_10000_users_report

echo.
echo All tests completed. Results saved to %RESULTS_FOLDER% folder.
echo.

pause
