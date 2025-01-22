import QtQuick 2.4
import QtGraphicalEffects 1.0


Rectangle {
    color: "transparent"
    signal speedoNeedleValueChanged(int value)

    SpeedNeedle {
        id: speedoNeedle
        property int speedoNeedleValue: 0

        anchors.verticalCenterOffset: 0
        anchors.centerIn: parent
        focus: true

        onSpeedoNeedleValueChanged: {
            speedoNeedle.value = speedoNeedleValue
            innerring.speed = speedoNeedleValue
        }
    }

    InnerRing {
        id: innerring
        speed: 0
    }
    Grid {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height - 150
        Rectangle {
            color: "transparent"; width: 25; height: 25
            Text {
                id: odometer
                text: "0"+" Km"
                font.family: "Eurostile"; font.pixelSize: 16
                color: "darkgray"
                anchors.centerIn: parent
            }
        }
    }

    Grid {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height - 100
        columns: 4
        Rectangle {
            color: "transparent"; width: 25; height: 25
            Text {
                id: letterP
                text: " P "
                font.family: "Eurostile"; font.pixelSize: 36
                color: "white"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            color: "transparent"; width: 25; height: 25
            Text {
                id: letterR
                text: " R "
                font.family: "Eurostile"; font.pixelSize: 18
                color: "darkgray"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            color: "transparent"; width: 25; height: 25
            Text {
                id: letterN
                text: " N "
                font.family: "Eurostile"; font.pixelSize: 18
                color: "darkgray"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            color: "transparent"; width: 25; height: 25
            Text {
                id: letterD
                text: " D "
                font.family: "Eurostile"; font.pixelSize: 18
                color: "darkgray"
                anchors.centerIn: parent
            }
        }
    }

    function park() {
        // Parking ON
        letterP.font.bold = true
        letterP.color = "white"
        letterP.font.pixelSize = 36
        // Reverse OFF
        letterR.font.bold = false
        letterR.color = "darkgray"
        letterR.font.pixelSize = 18
        // Neutral OFF
        letterN.font.bold = false
        letterN.color = "darkgray"
        letterN.font.pixelSize = 18
        // Drive OFF
        letterD.font.bold = false
        letterD.color = "darkgray"
        letterD.font.pixelSize = 18
    }

   function reverse() {
        // Parking OFF
        letterP.font.bold = false
        letterP.color = "darkgray"
        letterP.font.pixelSize = 18
        // Reverse ON
        letterR.font.bold = true
        letterR.color = "white"
        letterR.font.pixelSize = 36
        // Neutral OFF
        letterN.font.bold = false
        letterN.color = "darkgray"
        letterN.font.pixelSize = 18
        // Drive OFF
        letterD.font.bold = false
        letterD.color = "darkgray"
        letterD.font.pixelSize = 18
    }

    function neutral() {
        // Parking OFF
        letterP.font.bold = false
        letterP.color = "darkgray"
        letterP.font.pixelSize = 18
        // Reverse OFF
        letterR.font.bold = false
        letterR.color = "darkgray"
        letterR.font.pixelSize = 18
        // Neutral ON
        letterN.font.bold = true
        letterN.color = "white"
        letterN.font.pixelSize = 36
        // Drive OFF
        letterD.font.bold = false
        letterD.color = "darkgray"
        letterD.font.pixelSize = 18
    }

    function drive() {   
        // Parking OFF
        letterP.font.bold = false
        letterP.color = "darkgray"
        letterP.font.pixelSize = 18
        // Reverse OFF
        letterR.font.bold = false
        letterR.color = "darkgray"
        letterR.font.pixelSize = 18
        // Neutral OFF
        letterN.font.bold = false
        letterN.color = "darkgray"
        letterN.font.pixelSize = 18
        // Drive ON
        letterD.font.bold = true
        letterD.color = "white"
        letterD.font.pixelSize = 36
    }
    
    function updateSpeedoNeedleValue(value) {
        speedoNeedle.speedoNeedleValue = value
        speedoNeedleValueChanged(value)
    }

    function updateOdometerValue(value) {
        odometer.text = value
    }

    function leftSignalChange(leftSignal) {
        if (leftSignal === "LIGHT_ON") {
            innerring.leftSignalOn();
        } else if (leftSignal === "LIGHT_OFF") {
            innerring.leftSignalOff();
        }
    }

    function rightSignalChange(rightSignal) {
        if (rightSignal === "LIGHT_ON") {
            innerring.rightSignalOn();
        } else if (rightSignal === "LIGHT_OFF") {
            innerring.rightSignalOff();
        }
    }
}
