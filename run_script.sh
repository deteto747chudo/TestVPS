#!/bin/bash

PIDS_FILE="pids.txt"

start() {
    # Start the API
    if [ ! -f "$PIDS_FILE" ]; then
        echo "Starting API..."
        python3 api.py &
        echo $! > "$PIDS_FILE"
    else
        echo "API is already running."
    fi
    
    # Start the mainsetup.py
    echo "Starting mainsetup.py..."
    python3 mainsetup.py &
    echo $! >> "$PIDS_FILE"
    echo "All scripts have been executed."
}

stop() {
    if [ -f "$PIDS_FILE" ]; then
        while IFS= read -r PID; do
            if [ -n "$PID" ]; then
                echo "Stopping process with PID $PID..."
                kill "$PID"
            fi
        done < "$PIDS_FILE"
        rm "$PIDS_FILE"
        echo "All processes have been stopped."
    else
        echo "No processes are running."
    fi
}

restart() {
    stop
    sleep 2
    start
}

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
