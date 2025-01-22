import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: container
    width: parent.width
    height: parent.height
    color: "transparent"

    property int seconds
    property int tenseconds
    property int minutes

    // Image {
    //     anchors.verticalCenter: parent.verticalCenter
    //     x: (parent.width - 250) - width/2
    //     fillMode: Image.PreserveAspectFit
    //     scale: 1.4
    //     source: "/home/tomas7470/Downloads/Tesla/pics/call.png"

    //     Text {
    //         id:callTime
    //         y: 165; x: 128
    //         font.family: "Eurostile"; color: "white"; font.pixelSize: 11
    //         text: minutes + ":" + tenseconds + seconds
    //     }
    // }

    Image {
        id: speedLimit
        y: 40
        scale: 0.6
        source: ""
    }

    Image {
        id: batteryimg
        y: 10
        x: 5
        scale: 0.5
        source: "/home/tomas7470/Downloads/Tesla/pics/Battery.png"
    }

    Text {
        id: battery
        y: 22
        // x: -55
        font.family: "Eurostile"; color: "white"; font.pixelSize: 14; font.bold: true
        text: ""
    }

    function updateSpeedLimitValue(value) {
        speedLimit.source = "/home/tomas7470/Downloads/Tesla/pics/"+value+".png"
    }

    function updateBatteryValue(value) {
        if (value === 100) {
            battery.text = value+"%"
            battery.x = -20
        } else {
            battery.text = value+"%"
            battery.x = -15
        }
    }

    // Timer {
    //     //update Calltime, calculate 60 seconds into 1 minute etc.
    //        interval: 1000; running: true; repeat: true
    //        onTriggered: {seconds++;

    //        if(seconds == 10){
    //            tenseconds += 1
    //            seconds = 0
    //        }
    //        if(seconds == 0 && tenseconds==6){
    //            minutes += 1
    //            seconds = 0
    //            tenseconds = 0
    //        }
    //        }
    //    }
}

