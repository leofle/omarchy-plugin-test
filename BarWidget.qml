import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Ui

Item {
    id: root
    width: 32
    height: 32

    // Bar widget lifecycle
    // The shell injects 'shell', 'manifest', etc.

    TapHandler {
        onTapped: {
            // Summon the panel when the icon is clicked
            shell.call("community.timer-counter", "summon", JSON.stringify({}))
            // Or using the shell command via IPC if preferred:
            // shell.summon("community.timer-counter", "{}")
        }
    }

    Text {
        anchors.centerIn: parent
        text: "⏱" // Timer emoji
        font.pixelSize: 18
        color: Color.foreground
    }
}
