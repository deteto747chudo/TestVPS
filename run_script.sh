#!/bin/bash

# Function to start the API and mainsetup.py
start() {
    echo "Starting API..."
    nohup python3 api.py > api.log 2>&1 &
    API_PID=$!
    export API_PID

    echo "Starting mainsetup.py..."
    nohup python3 mainsetup.py > mainsetup.log 2>&1 &
    MAINSETUP_PID=$!
    export MAINSETUP_PID
}

# Function to stop the API and mainsetup.py
stop() {
    echo "Stopping API..."
    if [ -n "$API_PID" ]; then
        kill "$API_PID"
        unset API_PID
    else
        echo "API is not running."
    fi

    echo "Stopping mainsetup.py..."
    if [ -n "$MAINSETUP_PID" ]; then
        kill "$MAINSETUP_PID"
        unset MAINSETUP_PID
    else
        echo "mainsetup.py is not running."
    fi
}

# Function to restart the API and mainsetup.py
restart() {
    stop
    sleep 2
    start
}

# Check the command argument
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
