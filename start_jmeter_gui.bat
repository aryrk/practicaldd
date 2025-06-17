@echo off
echo Starting JMeter GUI with Cargo Tracker Test Plan
echo.

set JMETER_HOME=jmeter\apache-jmeter-5.6.2
set TEST_FILE=cargotracker_test_plan.jmx

echo Starting JMeter GUI...
echo.

%JMETER_HOME%\bin\jmeter.bat -t %TEST_FILE%

echo.
echo JMeter GUI closed.
echo.

pause
