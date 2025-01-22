import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    title: qsTr("Tesla Model y Speedometer")
    width: 800
    height: 480
    visible: true
    visibility: ApplicationWindow.FullScreen
    color: "black"
    property int needleValue: 0

    QtObject {
        property var locale: Qt.locale()
        property date currentDate: new Date()
        property string dateString
        property string timeString

        Component.onCompleted: {
            dateString = currentDate.toLocaleDateString();
            timeString = currentDate.toLocaleTimeString();
        }
    }

    Image {
        width: parent.width
        height: parent.height
        source: "/home/tomas7470/Downloads/Tesla/pics/Background.png"
    }

    // Tacho
    Image {
        height: parent.height
        width: height
        x: (parent.width / 2) - (width / 2)
        scale: 1.14
        source: "/home/tomas7470/Downloads/Tesla/pics/Tacho2.png"
        fillMode: Image.PreserveAspectFit
    }

    Speedometer {
        id: speedometer
        height: 525
        width: height
        x: (parent.width / 2) - (width / 2)
        y: (parent.height / 2) - (height / 2)
    }

    RightElement {
        id: rightelement
        height: 125
        width: height
        x: 700
        y: 70
    }

    Connections {
        target: speedValue

        function onSpeedNeedleValue(speed) {
            needleValue = speed
            speedometer.updateSpeedoNeedleValue(needleValue)
        }
    }

    Connections {
        target: gearValue
        
        function onGearChanged(gear) {
            if (gear === "DI_GEAR_P") {
                speedometer.park();
            } else if (gear === "DI_GEAR_D") {
                speedometer.drive();
            } else if (gear === "DI_GEAR_R") {
                speedometer.reverse();
            } else if (gear === "DI_GEAR_N") {
                speedometer.neutral();
            }
        }
    }

    Connections {
        target: odometerValue
        
        function onOdoChanged(odometer) {
            speedometer.updateOdometerValue(odometer)
        }
    }
    Connections {
        target: leftSignalValue
        
        function onLeftSignalChanged(leftSignal) {
            speedometer.leftSignalChange(leftSignal)
        }
    }

    Connections {
        target: rightSignalValue
        
        function onRightSignalChanged(rightSignal) {
            speedometer.rightSignalChange(rightSignal)
        }
    }

    Connections {
        target: speedLimitValue
        
        function onSpeedLimitChanged(speedLimit) {
            rightelement.updateSpeedLimitValue(speedLimit)
        }
    }

    Connections {
        target: batteryValue
        
        function onBatteryChanged(battery) {
            rightelement.updateBatteryValue(battery)
        }
    }
    
   // Rectangle {
       // id: photoPopup
      //  width: parent.width
       // height: parent.height
       // color: "transparent"
        //visible: false // Initially hidden

       // Image {
          //  anchors.centerIn: parent
           // width: 300
          //  height: 200
         //   source: "/home/tomas7470/Downloads/Tesla/pics/Hacked.png" // Replace with the path to your image
       // }
   // }

    // Add a Timer to control the pop-up behavior
    Timer {
        interval: 1000 // 1 second
        repeat: true
        running: true

        onTriggered: {
            photoPopup.visible = !photoPopup.visible; // Toggle visibility
        }
    }
}

