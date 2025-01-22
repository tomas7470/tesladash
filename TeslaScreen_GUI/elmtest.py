import serial
import can
import sys
import time

# Serial device address
device_address = "/dev/rfcomm0"

# ELM327 commands
cmd_set_echo_off = "ATE0\r"
cmd_reset_obd = "ATZ\r"
cmd_set_headers_on = "ATH1\r"
cmd_listen_all = "ATMA\r"

# Function to send commands to ELM327 and print response
def send_command(ser, command):
    ser.write(command.encode())
    time.sleep(0.1)
    response = ser.read(ser.in_waiting).decode().strip()
    response = response.replace(">", "").strip()  # Remove ">" character
    print("Command:", command.strip())
    print("Response:", response)
    print()

# Connect to serial device
try:
    ser = serial.Serial(device_address, baudrate=115200, timeout=1)
    print("Connected to serial device on", device_address)
except serial.SerialException as e:
    print("Failed to connect to serial device:", str(e))
    sys.exit(1)

# Configure ELM327 settings
send_command(ser, cmd_reset_obd)
send_command(ser, cmd_set_headers_on)

# Send ATMA command to start listening
send_command(ser, cmd_listen_all)

# Initialize the CAN bus and notifier
bus = can.Bus(bustype="serial", channel="/dev/rfcomm0", bitrate=115200)
notifier = can.Notifier(bus, [])

print("Listening to CAN messages (press Ctrl+C to stop)...")
# Listen for CAN messages until interrupted by user
try:
    while True:
        message = bus.recv()
        can_id = message.arbitration_id
        can_data = message.data.hex()
        print("CAN ID:", hex(can_id), "Data:", can_data)
except KeyboardInterrupt:
    print("\nProgram stopped by user.")
finally:
    # Stop the notifier and close the serial connection
    notifier.stop()
    ser.close()
    bus.shutdown()
