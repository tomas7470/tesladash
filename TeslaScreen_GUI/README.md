# Tesla Speedometer Application

This project simulates a Tesla speedometer interface using PyQt5 and QML, interfacing with a CAN bus for real-time vehicle data. The application displays various metrics such as speed, gear, odometer, signals, and battery status.

## Features
- Real-time speedometer visualization.
- Odometer and battery status display.
- Left and right turn signal indicators.
- QML-based user interface.

## Prerequisites

1. **Python 3.x**
   - Install from [Python.org](https://www.python.org/).

2. **Required Python Libraries**:
   ```bash
   pip install pyqt5 cantools python-can
   ```

3. **CAN Bus Setup**
   - Ensure you have a CAN interface available (e.g., SocketCAN).
   - Configure the CAN interface as `can0` with a bitrate of `500000`.

4. **DBC File**
   - Place the DBC file (e.g., `Model3CAN.dbc`) in a known location.
   - Update the `can_db` path in `main.py` to the DBC file location.

5. **QML Files**
   - Ensure the QML files and assets (images, fonts) are in the correct directory structure.

## Usage

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Update file paths in `main.py`:
   - Update `engine.load` to point to the correct path for `main.qml`.
   - Update image sources in QML files to reflect your directory structure.

3. Run the application:
   ```bash
   python main.py
   ```

## File Overview

- `main.py`: Contains the application logic and CAN bus integration.
- `main.qml`: Main QML file defining the application layout and interactions.
- `MainForm.ui.qml`: Additional UI elements.

## Troubleshooting

1. **CAN Bus Issues**:
   - Verify that the `can0` interface is up and running:
     ```bash
     ip link set can0 up type can bitrate 500000
     ```

2. **QML Loading Errors**:
   - Ensure all file paths in the QML files are correct.

3. **Missing Assets**:
   - Place the required images (e.g., `Background.png`, `Tacho.png`) in the specified directories.

## License
This project is open-source under the [MIT License](LICENSE).

---

Contributions are welcome! If you find issues or have suggestions, please create an issue or pull request.

