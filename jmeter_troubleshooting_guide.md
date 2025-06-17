# JMeter Load Testing for Cargo Tracker - Troubleshooting Guide

This document contains common issues that may occur during load testing and how to fix them.

## Common Issues

### 1. "Cannot write to '/results/cargo_tracker_XXX_users_report' as folder is not empty"

**Problem:** JMeter cannot overwrite an existing results directory.

**Solution:**
- Use the `fix_jmeter_folder_error.bat` script to clean specific test result folders
- Select the specific user count folder that's causing the error
- Try running the test again

### 2. Docker Container Networking Issues

**Problem:** JMeter container cannot connect to the application.

**Solution:**
- Ensure all Cargo Tracker services are running using `docker compose ps`
- Verify that the application is accessible via browser at `http://localhost:8080`
- Check if the `--network host` parameter is being used in the Docker run command
- Try restarting Docker Desktop if on Windows/Mac

### 3. JMeter Runs But Shows High Error Rate

**Problem:** Load test runs but many requests fail.

**Solution:**
- Check if application services are running properly
- Verify that all application endpoints are valid and responding in browser
- Lower the number of users for initial testing
- Increase the ramp-up period to avoid overwhelming the system

### 4. Out of Memory Errors

**Problem:** JMeter runs out of memory during large tests (especially for 5000+ users).

**Solution:**
- Add the `-JVM_ARGS="-Xmx1g"` parameter to the Docker run command to increase memory
- Try splitting large tests into smaller batches
- On Windows, ensure Docker Desktop has sufficient resources allocated

### 5. Missing or Incomplete Test Reports

**Problem:** Test completes but the HTML report is missing or incomplete.

**Solution:**
- Check if the test was terminated early (Ctrl+C)
- Ensure the output directory is properly mapped in the Docker volume
- Try running the test with fewer users
- Use the `clean previous test results` option before running new tests

## General Tips

- Always check that all Cargo Tracker services are healthy before running tests
- For extremely large tests (5000+ users), expect longer run times and prepare sufficient system resources
- Monitor system resources during test execution
- Use the HTML reports to identify bottlenecks in specific endpoints

If you encounter issues not covered in this guide, please check the JMeter documentation or Docker logs for more detailed information.
