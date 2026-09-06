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

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Ui

Item {
    id: root
    width: 32
    height: 32

    TapHandler {
        onTapped: {
            // The bar widget receives 'shell' as an injected property in Omarchy.
            // If it's undefined, we fall back to a shell command if possible, 
            // but let's ensure the summon works.
            if (typeof shell !== "undefined") {
                shell.summon("community.timer-counter", "{}")
            }
        }
    }

    Text {
        anchors.centerIn: parent
        text: "⏱"
        font.pixelSize: 18
        color: Color.foreground
    }
}

    Text {
        anchors.centerIn: parent
        text: "⏱" // Timer emoji
        font.pixelSize: 18
        color: Color.foreground
    }
}
