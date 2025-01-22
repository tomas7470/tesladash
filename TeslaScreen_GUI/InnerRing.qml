import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {

    property int speed: 0

    height: 250 //TODO: Groesse skalierbar machen
    width: height
    x: (parent.width / 2) - (width / 2)
    y: (parent.height / 2) - (height / 2)

    Image {
        id: innerRingRect
        height: parent.height
        width: parent.width
        source: "/home/tomas7470/Downloads/Tesla/pics/Tacho_Mitte3_1.png"


        Text {
            id: speeddigit
            text: speed
            //text: '155'
            font.pixelSize: 50
            font.bold: true
            font.family: "Eurostile"
            y: 15
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        DropShadow {
            anchors.fill: speeddigit
            horizontalOffset: 0
            verticalOffset: 8
            radius: 4.0
            samples: 16
            color: "black"
            source: speeddigit
        }

        Text {
            text: "km/h"
            font.pixelSize: 16
            font.bold: true
            font.family: "Eurostile"
            y: 80
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image {
            id: turnLeftOffOn
            source: ""
            y: 35
            x: 30
         }

        Image {
            id: turnRightOffOn
            source: ""
            y: 35
            x: 190
         }
    }

    function leftSignalOn() {
        turnLeftOffOn.source = "/home/tomas7470/Downloads/Tesla/pics/turnLeftOn.png"
    }

    function leftSignalOff() {
        turnLeftOffOn.source = ""
    }

    function rightSignalOn() {
        turnRightOffOn.source = "/home/tomas7470/Downloads/Tesla/pics/turnRightOn.png"
    }

    function rightSignalOff() {
        turnRightOffOn.source = ""
    }
}