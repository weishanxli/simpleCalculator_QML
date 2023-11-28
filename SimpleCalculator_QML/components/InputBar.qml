import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Basic

Label {
    width: parent.width
    height: parent.height*0.2
    horizontalAlignment: Text.AlignRight
    font {
        pixelSize: parent.height * 0.15
        family: "futura"
    }

    color: "white"
    background: Rectangle {
        color: "#496580"
    }
}
