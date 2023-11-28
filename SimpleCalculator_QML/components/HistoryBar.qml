import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Basic

Label {
    width: parent.width*0.95
    height: parent.height*0.05
    horizontalAlignment: Text.AlignRight
    verticalAlignment: Text.AlignVCenter

    font {
        family: "futura"
        pixelSize: parent.height * 0.05
    }
    color: "white"

    background: Rectangle {
        color: "#496580"
    }
}

