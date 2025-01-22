import QtQuick 2.4
import QtGraphicalEffects 1.0

Canvas {
    id: canvas

    property int value : 0

    onValueChanged: {
        zeiger.rotation = canvas.value - 120
        canvas.currentValue = zeiger.rotation
    }
    width: parent.width; height: parent.height

    Rectangle {
        id: zeiger
        width: 4
        height: parent.width / 2.7
        transformOrigin: Item.Bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        rotation: -120

        smooth: true
        antialiasing: true
        color: "#E82127"
        onRotationChanged: {
            canvas.currentValue = zeiger.rotation;
            canvas.requestPaint()
        }
    }

    antialiasing: true

    property color secondaryColor: zeiger.color

    property real centerWidth: width / 2
    property real centerHeight: height / 2
    property real radius: Math.min(canvas.width, canvas.height) / 2

    property real minimumValue: -360
    property real maximumValue: 0
    property real currentValue: -360
}