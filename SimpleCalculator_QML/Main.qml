import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import SimpleCalculator_QML
import "components"

Window {
    width: 480
    height: 640
    minimumWidth: 480
    minimumHeight: 640
    maximumWidth: 1920
    maximumHeight: 1080

    visible: true
    title: qsTr("Simple Calculator")
    color: "gray"

    Rectangle {
        width: parent.width
        height: parent.height
        anchors {
            centerIn: parent
        }
        focus: true

        // Create Calculator element from Q_OBJECT C++ Class
        Calculator {
            id: calculatorEngine

            // Set up slots (signals emitted from Calculator class)
            onResultCalculated: (num) => {
                                    historyBar.text = num
                                }
            onInputSetAsPercent: (percent) => {
                                     inputBar.text = percent
                                 }
            onInputSignToggled: (toggledNum) => {
                                    inputBar.text = toggledNum
                                }
        }
        // History bar to store previous calculated result / first operand
        HistoryBar {
            id: historyBar
            anchors {
                top: parent.top
                left: parent.left
            }
        }
        // Operation bar to store the current operation
        OperationBar {
            id: operationBar
            anchors {
                top: parent.top
                left: historyBar.right
            }
        }
        // Input bar to store the user input
        InputBar {
            id: inputBar
            anchors {
                top: historyBar.bottom
            }
        }

        // Component for numbers and decimal buttons (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
        component Digit: CalculatorButton {
            id: digitButton
            background: Rectangle {
                color: digitButton.down ? "darkgray" : "gray"
                opacity: enabled ? 1 : 0.3
                border {
                    color: "#404040"
                    width: 0.5
                }
            }

            onClicked: {
                // Add the digit to the input
                if (inputBar.text === "" && digitButton.text === "0") {
                    // Do nothing, don't add leading zeroes
                }
                else {
                    inputBar.text = inputBar.text + digitButton.text
                }

                // Clear history if starting a new calculation
                if (operationBar.text === "=") {
                    historyBar.text = ""
                    operationBar.text = ""
                }
            }
        }
        // Component for functinal operation buttons (+, -, x, /, =)
        component Operation: CalculatorButton {
            id: operationButton
            background: Rectangle {
                color: operationButton.down ? "#64939c" : "skyblue"
                opacity: enabled ? 1 : 0.3
                border {
                    color: "#404040"
                    width: 0.5
                }
            }

            onClicked: {
                if (historyBar.text === "")
                {
                    // Only have one operand
                    calculatorEngine.setFirstOperand(inputBar.text)
                    historyBar.text = inputBar.text
                }
                else if (inputBar.text === "")/*&& operationButton.text !== "="*/
                {
                    // Do nothing if there is nothing in current input
                }
                else
                {
                    // Evaluate the equation (previous operand saved in calculator engine)
                    calculatorEngine.evaluate(inputBar.text, operationBar.text)
                }
                // Update the displayed operator and clear input
                operationBar.text = operationButton.text
                inputBar.text = ""
            }
        }
        // Component for input modifier buttons (AC/C, +/-, %)
        component Modifier: CalculatorButton {
            id: modifierButton
            background: Rectangle {
                color: modifierButton.down ? "gray" : "darkgray"
                opacity: enabled ? 1 : 0.3
                border {
                    color: "#404040"
                    width: 0.5
                }
            }
        }

        // Setup modifier buttons
        Modifier {
            // Clear button
            id: clear
            text: qsTr("AC")
            anchors {
                top: inputBar.bottom
                left: parent.left
            }

            onClicked: {
                if (text === "AC") {
                    // Clear everything
                    historyBar.text = ""
                    operationBar.text = ""
                }
                else {
                    // Clear only input bar text; next press will clear everything
                    text = "AC"
                }
                inputBar.text = ""
            }
        }
        Modifier {
            // Positive/Negative toggle button
            id: pos_neg
            text: qsTr("+/-")
            anchors {
                top: inputBar.bottom
                left: clear.right
            }

            onClicked: {
                calculatorEngine.toggleSign(inputBar.text)
            }
        }
        Modifier {
            // Percent button
            id: percent
            text: qsTr("%")
            anchors {
                top: inputBar.bottom
                left: pos_neg.right
            }

            onClicked: {
                calculatorEngine.setInputAsPercent(inputBar.text)
            }
        }

        // Setup operation buttons
        Operation {
            // Divide operation button
            id: divide
            text: qsTr("÷")
            anchors {
                top: inputBar.bottom
                left: percent.right
            }
        }
        Operation {
            // Multiply operation button
            id: multiply
            text: qsTr("x")
            anchors {
                top: divide.bottom
                left: nine.right
            }
        }
        Operation {
            // Subtract operation button
            id: subtract
            text: qsTr("-")
            anchors {
                top: multiply.bottom
                left: six.right
            }
        }
        Operation {
            // Add operation button
            id: add
            text: qsTr("+")
            anchors {
                top: subtract.bottom
                left: three.right
            }
        }
        Operation {
            // Equals operation button
            id: equals
            text: qsTr("=")
            anchors {
                top: add.bottom
                left: decimal.right
            }
        }

        // Setup digit buttons
        Digit {
            id: zero
            text: qsTr("0")
            width: parent.width/2
            anchors {
                top: one.bottom
                left: parent.left
            }
        }
        Digit {
            id: one
            text: qsTr("1")
            anchors {
                top: four.bottom
                left: parent.left
            }
        }
        Digit {
            id: two
            text: qsTr("2")
            anchors {
                top: five.bottom
                left: one.right
            }
        }
        Digit {
            id: three
            text: qsTr("3")
            anchors {
                top: six.bottom
                left: two.right
            }
        }
        Digit {
            id: four
            text: qsTr("4")
            anchors {
                top: seven.bottom
                left: parent.left
            }
        }
        Digit {
            id: five
            text: qsTr("5")
            anchors {
                top: eight.bottom
                left: four.right
            }
        }
        Digit {
            id: six
            text: qsTr("6")
            anchors {
                top: nine.bottom
                left: five.right
            }
        }
        Digit {
            id: seven
            text: qsTr("7")
            anchors {
                top: clear.bottom
                left: parent.left
            }
        }
        Digit {
            id: eight
            text: qsTr("8")
            anchors {
                top: pos_neg.bottom
                left: seven.right
            }
        }
        Digit {
            id: nine
            text: qsTr("9")
            anchors {
                top: percent.bottom
                left: eight.right
            }
        }
        Digit {
            id: decimal
            text: qsTr(".")
            anchors {
                top: three.bottom
                left: zero.right
            }
        }

        // Key Press handler
        Keys.onPressed: (event) => {
            switch (event.key) {
            case Qt.Key_0:
                zero.clicked()
                break
            case Qt.Key_1:
                one.clicked()
                break
            case Qt.Key_2:
                two.clicked()
                break
            case Qt.Key_3:
                three.clicked()
                break
            case Qt.Key_4:
                four.clicked()
                break
            case Qt.Key_5:
                five.clicked()
                break
            case Qt.Key_6:
                six.clicked()
                break
            case Qt.Key_7:
                seven.clicked()
                break
            case Qt.Key_8:
                eight.clicked()
                break
            case Qt.Key_9:
                nine.clicked()
                break
            case Qt.Key_Period:
                decimal.clicked()
                break
            case Qt.Key_Return:
            case Qt.Key_Equal:
                equals.clicked()
                break
            case Qt.Key_Plus:
                add.clicked()
                break
            case Qt.Key_Minus:
                subtract.clicked()
                break
            case Qt.Key_Asterisk:
                multiply.clicked()
                break
            case Qt.Key_Slash:
                divide.clicked()
                break
            case Qt.Key_Escape:
                clear.clicked()
                break
            case Qt.Key_Percent:
                percent.clicked()
                break
            default:
                break
            }

            // Update clear button text
            if (inputBar.text === "") {
                clear.text = "AC"
            }
            else {
                clear.text = "C"
            }
        }
    }
}
