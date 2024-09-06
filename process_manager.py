import subprocess
import time
import signal
import os

# Paths to your scripts
API_SCRIPT = 'api.py'
MAINSETUP_SCRIPT = 'mainsetup.py'

# Global variables to store process handles
api_process = None
mainsetup_process = None

def start_processes():
    global api_process, mainsetup_process

    if api_process is None or mainsetup_process is None:
        print("Starting API...")
        api_process = subprocess.Popen(['python3', API_SCRIPT], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        
        print("Waiting for API to start...")
        time.sleep(5)  # Wait for a few seconds for the API to start

        print("Starting mainsetup.py...")
        mainsetup_process = subprocess.Popen(['python3', MAINSETUP_SCRIPT], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        print("Both processes started.")

def stop_processes():
    global api_process, mainsetup_process

    if api_process is not None:
        print("Stopping API...")
        api_process.send_signal(signal.SIGTERM)
        api_process.wait()
        api_process = None

    if mainsetup_process is not None:
        print("Stopping mainsetup.py...")
        mainsetup_process.send_signal(signal.SIGTERM)
        mainsetup_process.wait()
        mainsetup_process = None

    print("Both processes stopped.")

def restart_processes():
    print("Restarting processes...")
    stop_processes()
    time.sleep(2)  # Give some time for processes to shut down
    start_processes()

def main():
    import argparse

    parser = argparse.ArgumentParser(description='Manage API and mainsetup processes.')
    parser.add_argument('command', choices=['start', 'stop', 'restart'], help='Command to run')
    
    args = parser.parse_args()
    
    if args.command == 'start':
        start_processes()
    elif args.command == 'stop':
        stop_processes()
    elif args.command == 'restart':
        restart_processes()

if __name__ == '__main__':
    main()
