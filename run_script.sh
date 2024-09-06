#!/bin/bash

# Ensure the API is always running
if ! pgrep -f "api.py" > /dev/null
then
    echo "Starting API..."
    nohup python3 api.py > api.log 2>&1 &
else
    echo "API is already running."
fi

# Function to start a process
start_process() {
    local process_name=$1
    if ! pgrep -f "$process_name" > /dev/null
    then
        echo "Starting $process_name..."
        nohup python3 "$process_name" > "$process_name.log" 2>&1 &
    else
        echo "$process_name is already running."
    fi
}

# Function to stop a process
stop_process() {
    local process_name=$1
    pkill -f "$process_name"
    echo "$process_name stopped."
}

# Function to restart a process
restart_process() {
    local process_name=$1
    stop_process "$process_name"
    start_process "$process_name"
}

case "$1" in
    start)
        start_process "mainsetup.py"
        start_process "mainsetup2.py"
        start_process "mainsetup3.py"
        start_process "mainsetup4.py"
        start_process "mainsetup5.py"
        start_process "mainsetup6.py"
        start_process "mainsetup7.py"
        start_process "mainsetup8.py"
        start_process "mainsetup9.py"
        ;;
    stop)
        stop_process "mainsetup.py"
        stop_process "mainsetup2.py"
        stop_process "mainsetup3.py"
        stop_process "mainsetup4.py"
        stop_process "mainsetup5.py"
        stop_process "mainsetup6.py"
        stop_process "mainsetup7.py"
        stop_process "mainsetup8.py"
        stop_process "mainsetup9.py"
        ;;
    restart)
        restart_process "mainsetup.py"
        restart_process "mainsetup2.py"
        restart_process "mainsetup3.py"
        restart_process "mainsetup4.py"
        restart_process "mainsetup5.py"
        restart_process "mainsetup6.py"
        restart_process "mainsetup7.py"
        restart_process "mainsetup8.py"
        restart_process "mainsetup9.py"
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
