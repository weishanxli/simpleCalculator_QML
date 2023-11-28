import QtQuick 2.15
import QtQuick.Controls

Label {
    width: parent.width*.05
    height: parent.height*0.05
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    font {
        family: "futura"
        pixelSize: parent.height * 0.04
    }
    color: "white"

    background: Rectangle {
        color: "#496580"
    }
}
