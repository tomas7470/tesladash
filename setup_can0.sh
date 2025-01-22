#!/bin/bash

# Function to release the RFCOMM socket
release_rfcomm() {
    sudo rfcomm release 0
    exit $1
}

# Set up an exit handler to release the RFCOMM socket
trap 'release_rfcomm $?' EXIT

# Step 1: Attempt to bind the RFCOMM socket
echo "Binding rfcomm"
sudo rfcomm bind 0 00:04:3E:73:01:DD

# Check the exit code of the bind command
if [ $? -eq 0 ]; then
    echo "Bind successful"
else
    echo "Can't create device: Address already in use"
fi

# Step 2: Check if /dev/rfcomm0 exists
echo "Checking for rfcomm0"
if [ ! -e /dev/rfcomm0 ]; then
    echo "/dev/rfcomm0 does not exist. Exiting."
    exit 1
else
    echo "/dev/rfcomm- exist"
fi


# Step 3: Run ldattach in the background
echo "Starting ldattach"
sudo ldattach --debug --speed 38400 --eightbits --noparity --onestopbit --iflag -ICRNL,INLCR,-IXOFF 29 /dev/rfcomm0 &

# Capture the PID of ldattach
ldattach_pid=$!

# Capture the exit status of ldattach
ldattach_exit_status=$?

# Wait for 60 seconds
echo "Sleeping for 10 seconds"
sleep 10
echo "done, checking ldattach..."
# Check if ldattach is still running
if [ $ldattach_exit_status -eq 0 ]; then
    echo "ldattach has succeeded."

    # Check if the 'can0' interface exists
    if ip link show can0 > /dev/null 2>&1; then
        echo "The 'can0' interface already exists."
        sudo ip link set can0 type can bitrate 500000
        sudo ip link set can0 up
    else
        echo "The 'can0' interface does not exist."

        # Execute additional commands to create 'can0'
        sudo ip link set can0 down
        sudo ip link set can0 type can bitrate 500000
        sudo ip link set can0 up
    fi

    sleep 10
    # Check if 'can0' is up
    if ip link show can0 | grep -q 'UP,LOWER_UP'; then
        echo "'can0' is up."

        # Execute your Python script
        python3 -b /home/tomas7470/Downloads/Tesla/main.py
    else
        echo "'can0' is not up; exiting."
        exit 1
    fi
else
    sudo kill -9 $ldattach_pid
    echo "ldattach has failed with exit status $ldattach_exit_status."
    exit 1
fi
# else
#     if ps -p $ldattach_pid > /dev/null; then
#         echo "ldattach didn't complete within the timeout; forcefully terminating."
#         sudo kill -9 $ldattach_pid  # Terminate ldattach forcefully
#         exit 1
#     else
#         echo "Other Error, killing ldattach"
#         sudo kill -9 $ldattach_pid  # Terminate ldattach forcefully
#         exit 1
# fi

# # Step 2: ldattach (run in the background)
# sudo ldattach --debug --speed 38400 --eightbits --noparity --onestopbit --iflag -ICRNL,INLCR,-IXOFF 29 /dev/rfcomm0 &
# ldattach_pid=$!

# # Wait for 2 seconds
# sleep 10

# # Check if ldattach is still running
# if ps -p $ldattach_pid > /dev/null; then
#     echo "ldattach is still running."
# else
#     echo "ldattach has succeeded."
# fi

# # Wait for 2 seconds
# sleep 2

# # Step 3: Set can0 down (run in parallel)
# sudo ip link set can0 down &
# set_can0_down_pid=$!

# # Wait for Step 3 to complete
# wait $set_can0_down_pid

# # Wait for 2 seconds
# sleep 2

# # Step 4: Set can0 type can bitrate 500000 (run in parallel)
# sudo ip link set can0 type can bitrate 500000 &
# set_can0_bitrate_pid=$!

# wait $set_can0_bitrate_pid

# # Wait for 2 seconds
# sleep 2

# # Step 5: Set can0 up (run in parallel)
# sudo ip link set can0 up &
# set_can0_up_pid=$!

# wait $set_can0_up_pid

# # Step 6: Test if can0 is up and error-free
# sudo ip link show can0 | grep UP &> /dev/null
# if [ $? -eq 0 ]; then
#     echo "can0 is up and running without errors."
#     python3 -b main.py
# else
#     echo "Error: can0 is not up or there was an error."
#     exit 1
# fi

