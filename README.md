# Tesla Model Y and Model 3 Dashboard (work in progress)

## Overview

This project is a DIY dashboard solution for Tesla Model Y and Model 3 owners. It provides real-time data and controls for your vehicle, leveraging a Raspberry Pi 4, a 7-inch Raspberry Pi screen, and an OBDLink MX+ adapter. The software is built using QT, PyQt, and SocketCAN, with communication facilitated by an ELM327 to SocketCAN driver. Additionally, this project utilizes the Model 3 DBC (Database for CAN Bus) file for improved compatibility.

![](Photo_1.jpg|width=100)

## Features

- Real-time vehicle data monitoring.
- Customizable dashboard layout.
- Compatibility with both Tesla Model Y and Model 3.
- ELM327 to SocketCAN driver for efficient CAN communication.
- Integration of the Model 3 DBC file for accurate data interpretation.

## Hardware Requirements

- Raspberry Pi 4 (guess you know how to get one..)
- [7-inch Raspberry Pi screen](https://www.kiwi-electronics.com/en/raspberry-pi-7quot-800x480-dsi-touchscreen-display-1948?country=&gclid=CjwKCAjw4P6oBhBsEiwAKYVkq2pTRaThqb8cQ_RFveYJ5aUiZsfU_ZONKI_r4ttuA75f9ohQleqJDBoCGJQQAvD_BwE) (Can be found in Amazon or ebay)
- [OBDLink MX+ adapter](https://www.obdlink.com/products/obdlink-mxp/) (Can be found in Amazon or ebay)
- 3D printed Custom-designed mount/holder [Check out 3D models or STLs](STLs/)

## Software Requirements

- Raspbian OS or Raspberry Pi OS
- PyQt for the graphical user interface
- SocketCAN for CAN bus communication
- [ELM327 to SocketCAN driver](https://github.com/norly/elmcan/tree/master)
- [Tesla Model 3 DBC file](https://github.com/joshwardell/model3dbc)

## Installation

1. **Raspberry Pi Setup**: Make sure your Raspberry Pi is set up with the required operating system and is properly connected to the 7-inch screen.

2. **Clone the Repository**:

    ```bash
    git clone https://github.com/your-username/tesla-dashboard.git
    cd tesla-dashboard
    ```

3. **Install Dependencies**: Install the necessary Python packages and libraries.

    ```bash
    pip install -r requirements.txt
    ```

4. **Compile and Run**: Compile and run the project using the following command.

    ```bash
    python main.py
    ```

5. **Configuration**: Configure your OBDLink MX+ adapter and ensure the Model 3 DBC file is correctly set up for accurate data interpretation.

6. **Mounting**: Use the provided mount/holder design (STEP or STL format) to securely attach the Raspberry Pi and screen to your vehicle.

## Usage

1. Launch the application on your Raspberry Pi.

2. Connect the OBDLink MX+ adapter to your Tesla Model Y or Model 3.

3. The dashboard will display real-time data and control options for your vehicle.

4. Customize the dashboard layout and widgets to suit your preferences.

## Contributing

Contributions are welcome! If you'd like to improve this project, feel free to fork the repository and submit a pull request with your changes. Please follow the [Contributing Guidelines](CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](LICENSE.md).

## Acknowledgments

- Special thanks to the Tesla community for their support and contributions.
- Credit to the creators of PyQt, SocketCAN, and the Model 3 DBC file for enabling this project.

## Contact

For questions, feedback, or issues, please contact [Tom](mailto:tomas7470@gmail.com).

Happy driving!
