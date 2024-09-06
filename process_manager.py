import subprocess
import time
import requests
import signal
import os

# Define global variables for the process
process = None

def start_mainsetup():
    global process
    if process is not None:
        print("Mainsetup is already running.")
        return

    process = subprocess.Popen(['python3', 'mainsetup.py'])
    print("Mainsetup started.")

def stop_mainsetup():
    global process
    if process is None:
        print("Mainsetup is not running.")
        return

    process.terminate()
    process.wait()
    process = None
    print("Mainsetup stopped.")

def restart_mainsetup():
    stop_mainsetup()
    time.sleep(1)  # Give it a moment to ensure it has stopped
    start_mainsetup()
    print("Mainsetup restarted.")

def check_api_status(api_url):
    try:
        response = requests.get(f"{api_url}/status")
        return response.json().get('status') == 'online'
    except requests.RequestException as e:
        print(f"API request failed: {e}")
        return False

def main(api_url):
    global process

    if not check_api_status(api_url):
        print("API is not available. Exiting.")
        return

    while True:
        try:
            response = requests.get(f"{api_url}/get_command")
            command = response.json().get('command')

            if command == 'start':
                start_mainsetup()
            elif command == 'stop':
                stop_mainsetup()
            elif command == 'restart':
                restart_mainsetup()
            
            time.sleep(5)  # Wait before checking for new commands

        except requests.RequestException as e:
            print(f"Failed to fetch command from API: {e}")
            time.sleep(10)  # Wait before retrying

if __name__ == '__main__':
    API_URL = 'http://127.0.0.1:5001'  # Change this to your actual API URL if necessary
    main(API_URL)
