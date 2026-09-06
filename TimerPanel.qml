import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Ui

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Ui

Item {
    id: root
    property string title: "Timer Counter"
    property int timerSeconds: 0
    property bool isRunning: false

    function open(payloadJson) {}
    function close() {}

    width: 400
    height: 500

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Text {
            text: root.title
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: timeInput
            placeholderText: "Enter seconds (e.g. 60)"
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "Create/Add"
                onClicked: {
                    let val = parseInt(timeInput.text);
                    if (!isNaN(val)) {
                        root.timerSeconds = val;
                        root.isRunning = false;
                    }
                }
            }

            Button {
                text: "Start"
                enabled: root.timerSeconds > 0 && !root.isRunning
                onClicked: root.isRunning = true
            }

            Button {
                text: "Stop"
                enabled: root.isRunning
                onClicked: root.isRunning = false
            }

            Button {
                text: "Reset"
                onClicked: {
                    root.isRunning = false;
                    root.timerSeconds = 0;
                }
            }
        }

        Text {
            text: "Time remaining: " + root.timerSeconds + "s"
            font.pixelSize: 32
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillHeight: true
        }
    }

    Timer {
        id: actualTimer
        interval: 1000
        running: root.isRunning
        repeat: true
        onTriggered: {
            if (root.timerSeconds > 0) {
                root.timerSeconds--;
            } else {
                root.isRunning = false;
            }
        }
    }
}
