import sys
from can import Bus, Notifier
import cantools

from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

SPEED_CAN_ID = 0x257
GEAR_CAN_ID = 0x118
ODO_CAN_ID = 0x3B6
LEFTSIG_CAN_ID = 0x3E2
RIGHTSIG_CAN_ID = 0x3E3
SPPEDLIMIT_CAN_ID = 0x238
BATTERY_CAN_ID = 0x33A

can_db = cantools.database.load_file("../Model3CAN.dbc")

class Speed(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.speed = 0
        self.max_speed = 240
        self.bus = Bus(interface='socketcan', channel='can0', bitrate=500000)
        self.message_id = SPEED_CAN_ID
        self.notifier = Notifier(self.bus, [self.receive_can_message])
    
    speedNeedleValue = pyqtSignal(int, arguments=['speed'])

    @pyqtSlot()
    def receive_can_message(self, message):
        if message.arbitration_id == self.message_id:
            decoded_message = can_db.decode_message(message.arbitration_id, message.data)
            if decoded_message is not None and 'DI_vehicleSpeed' in decoded_message:
                vehicle_speed_kph = decoded_message['DI_vehicleSpeed']
                self.speed = int(vehicle_speed_kph)
                self.speedNeedleValue.emit(self.speed)

class Gear(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.gear = "DI_GEAR_P"
        self.message_id = GEAR_CAN_ID
        self.bus = Bus(interface='socketcan', channel='can0', bitrate=500000)
        self.notifier = Notifier(self.bus, [self.receive_can_message])
    
    gearChanged = pyqtSignal(str, arguments=['gear'])

    @pyqtSlot()
    def receive_can_message(self, message):
        if message.arbitration_id == self.message_id:
            decoded_message = can_db.decode_message(message.arbitration_id, message.data)
            if decoded_message is not None and 'DI_gear' in decoded_message:
                gear = decoded_message['DI_gear']
                self.gear = str(gear)
                self.gearChanged.emit(self.gear)

class Odo(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.odometer = "0 km"
        self.bus = Bus(interface='socketcan', channel='can0', bitrate=500000)
        self.message_id = ODO_CAN_ID
        self.notifier = Notifier(self.bus, [self.receive_can_message])
    
    odoChanged = pyqtSignal(str, arguments=['odometer'])

    @pyqtSlot()
    def receive_can_message(self, message):
        if message.arbitration_id == self.message_id:
            decoded_message = can_db.decode_message(message.arbitration_id, message.data)
            if decoded_message is not None and 'Odometer3B6' in decoded_message:
                odometer = decoded_message['Odometer3B6']
                self.odometer = str('{0:,}'.format(int(odometer)))+" km"
                self.odoChanged.emit(self.odometer)

class LeftSignal(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.leftSignal = "LIGHT_OFF"
        self.bus = Bus(interface='socketcan', channel='can0', bitrate=500000)
        self.message_id = LEFTSIG_CAN_ID
        self.notifier = Notifier(self.bus, [self.receive_can_message])
    
    leftSignalChanged = pyqtSignal(str, arguments=['leftSignal'])

    @pyqtSlot()
    def receive_can_message(self, message):
        if message.arbitration_id == self.message_id:
            decoded_message = can_db.decode_message(message.arbitration_id, message.data)
            if decoded_message is not None and 'VCLEFT_turnSignalStatus' in decoded_message:
                leftSignal = decoded_message['VCLEFT_turnSignalStatus']
                self.leftSignal = str(leftSignal)
                # print("LEFT_"+str(leftSignal))
                self.leftSignalChanged.emit(self.leftSignal)

class RightSignal(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.rightSignal = "LIGHT_OFF"
        self.bus = Bus(interface='socketcan', channel='can0', bitrate=500000)
        self.message_id = RIGHTSIG_CAN_ID
        self.notifier = Notifier(self.bus, [self.receive_can_message])
    
    rightSignalChanged = pyqtSignal(str, arguments=['rightSignal'])

    @pyqtSlot()
    def receive_can_message(self, message):
        if message.arbitration_id == self.message_id:
            decoded_message = can_db.decode_message(message.arbitration_id, message.data)
            if decoded_message is not None and 'VCRIGHT_turnSignalStatus' in decoded_message:
                rightSignal = decoded_message['VCRIGHT_turnSignalStatus']
                self.rightSignal = str(rightSignal)
                # print("RIGHT_"+str(rightSignal))
                self.rightSignalChanged.emit(self.rightSignal)

class SpeedLimit(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.speedLimit = ""
        self.bus = Bus(interface='socketcan', channel='can0', bitrate=500000)
        self.message_id = SPPEDLIMIT_CAN_ID
        self.notifier = Notifier(self.bus, [self.receive_can_message])
    
    speedLimitChanged = pyqtSignal(str, arguments=['speedLimit'])

    @pyqtSlot()
    def receive_can_message(self, message):
        if message.arbitration_id == self.message_id:
            decoded_message = can_db.decode_message(message.arbitration_id, message.data)
            if decoded_message is not None and 'UI_mapSpeedLimit' in decoded_message:
                speedLimit = decoded_message['UI_mapSpeedLimit']
                self.speedLimit = str(speedLimit)
                self.speedLimitChanged.emit(self.speedLimit)

class Battery(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.battery = ""
        self.bus = Bus(interface='socketcan', channel='can0', bitrate=500000)
        self.message_id = BATTERY_CAN_ID
        self.notifier = Notifier(self.bus, [self.receive_can_message])
    
    batteryChanged = pyqtSignal(str, arguments=['battery'])

    @pyqtSlot()
    def receive_can_message(self, message):
        if message.arbitration_id == self.message_id:
            decoded_message = can_db.decode_message(message.arbitration_id, message.data)
            if decoded_message is not None and 'UI_SOC' in decoded_message:
                battery = decoded_message['UI_SOC']
                self.battery = str(battery)
                self.batteryChanged.emit(self.battery)

def main():
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    speed = Speed()
    gear = Gear()
    odometer = Odo()
    leftSignal = LeftSignal()
    rightSignal = RightSignal()
    speedLimit = SpeedLimit()
    battery = Battery()
    engine.rootContext().setContextProperty('speedValue', speed)
    engine.rootContext().setContextProperty('gearValue', gear)
    engine.rootContext().setContextProperty('odometerValue', odometer)
    engine.rootContext().setContextProperty('leftSignalValue', leftSignal)
    engine.rootContext().setContextProperty('rightSignalValue', rightSignal)
    engine.rootContext().setContextProperty('speedLimitValue', speedLimit)
    engine.rootContext().setContextProperty('batteryValue', battery)
    engine.load('/home/tomas7470/Downloads/Tesla/main.qml')
    engine.quit.connect(app.quit)

    def on_exit():
        speed.notifier.stop()
        gear.notifier.stop()

    app.aboutToQuit.connect(on_exit)

    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
