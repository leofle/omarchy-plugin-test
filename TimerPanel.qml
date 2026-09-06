import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Ui

Item {
    id: root
    property string title: "Timer Counter"

    // Placeholder for timer logic
    property int timerSeconds: 0
    property bool isRunning: false
    property Timer countdownTimer

    width: 400
    height: 500

    // This is a skeletal structure for the plugin.
    // In a real implementation, you would use actual timer logic and UI components.

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
                    // Reset logic would be more complex in a real app
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

    // Real timer implementation would go here
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
