import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Basic

Button {
    id: button
    width: parent.width/4
    height: parent.height*0.15

    contentItem: Text {
        text: button.text
        font {
            pixelSize: 40
            family: "Futura"
        }
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}

