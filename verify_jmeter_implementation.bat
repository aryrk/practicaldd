@echo off
echo Verifying Docker JMeter implementation...

REM Create results directory if it doesn't exist
if not exist "jmeter_results" mkdir jmeter_results

REM Pull JMeter Docker image if not already available
docker pull justb4/jmeter:5.5

REM Run JMeter test with 100 users and host.docker.internal as the target host
echo Running JMeter test with 100 users...
docker run --rm -v "%cd%:/jmeter" -v "%cd%/jmeter_results:/results" justb4/jmeter:5.5 -n -t /jmeter/cargotracker_test_plan.jmx -l /results/cargo_tracker_100_users_results.jtl -e -o /results/cargo_tracker_100_users_report -Jhost=127.0.0.1 -JnumThreads=100 -JrampUpPeriods=10

echo Test completed! Results are available in the jmeter_results folder.
pause
