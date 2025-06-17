import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: appWin
    visible: true
    width: 300
    height: 400
    title: "QML 계산기"

    property string expression: ""
    property string result: ""

    Column {
        anchors.fill: parent
        spacing: 10
        padding: 10

        // 결과 표시 영역
        Rectangle {
            height: parent.height * 0.2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            color: "#eeeeee"
            radius: 8
            border.color: "#cccccc"

            Text {
                text: appWin.result === "" ? appWin.expression : appWin.result
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 24
                horizontalAlignment: Text.AlignRight
                width: parent.width - 20
                wrapMode: Text.NoWrap
            }
        }

        // 버튼 그리드
        Rectangle {
            width: parent.width
            height: parent.height * 0.7
            color: "#f5f5f5"
            radius: 8
            anchors.horizontalCenter: parent.horizontalCenter

            GridLayout {
                id: buttonGrid
                anchors.fill: parent
                anchors.margins: 10
                columns: 4
                rowSpacing: 8
                columnSpacing: 8

                function append(val) {
                    if (appWin.result !== "") {
                        appWin.expression = ""
                        appWin.result = ""
                    }
                    appWin.expression += val
                }

                function clearAll() {
                    appWin.expression = ""
                    appWin.result = ""
                }

                function calculate() {
                    try {
                        result = eval(expression)
                    } catch (e) {
                        appWin.result = "Error"
                    }
                }

                Repeater {
                    model: [
                        "7", "8", "9", "/",
                        "4", "5", "6", "*",
                        "1", "2", "3", "-",
                        "0", "C", "=", "+"
                    ]

                    Button {
                        text: modelData
                        onClicked: {
                            if (text === "C") {
                                buttonGrid.clearAll()
                            } else if (text === "=") {
                                buttonGrid.calculate()
                            } else {
                                buttonGrid.append(text)
                            }
                        }
                        font.pixelSize: 18
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}