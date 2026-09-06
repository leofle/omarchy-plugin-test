import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Ui

Panel {
  id: root
  moduleName: "community.timer-counter"
  ipcTarget: "community.timer-counter"
  manageIpc: false

  property Item anchorItem: null
  property var hostWidget: null
  property int timerSeconds: 0
  property int initialSeconds: 0
  property bool running: false

  readonly property string formattedTime: {
    var minutes = Math.floor(timerSeconds / 60)
    var seconds = timerSeconds % 60
    return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
  }

  function setTimer() {
    var value = parseInt(timeInput.text, 10)
    if (isNaN(value) || value < 1) return
    initialSeconds = value
    timerSeconds = value
    running = false
    timeInput.text = ""
  }

  function resetTimer() {
    running = false
    timerSeconds = initialSeconds
  }

  function open() {
    controller.show()
    Qt.callLater(function() { timeInput.forceActiveFocus() })
  }

  function close() { controller.hide() }

  Timer {
    interval: 1000
    running: root.running
    repeat: true
    onTriggered: {
      if (root.timerSeconds > 1) root.timerSeconds--
      else {
        root.timerSeconds = 0
        root.running = false
      }
    }
  }

  KeyboardPanel {
    id: panel
    anchorItem: root.anchorItem
    owner: root.hostWidget || root
    bar: root.bar
    open: root.opened
    focusTarget: keyCatcher
    contentWidth: panel.fittedContentWidth(Style.space(360))
    contentHeight: panel.fittedContentHeight(column.implicitHeight, Style.space(420))

    PanelKeyCatcher {
      id: keyCatcher
      anchors.fill: parent
      onCloseRequested: root.close()
      onTabRequested: function(direction) { root.switchPanel(direction) }

      ColumnLayout {
        id: column
        width: parent.width
        spacing: Style.space(12)

        PanelHero {
          Layout.fillWidth: true
          title: "Timer Counter"
          meta: root.timerSeconds > 0 ? (root.running ? "Running" : "Paused") : "Enter a duration in seconds"
        }

        Text {
          Layout.alignment: Qt.AlignHCenter
          text: root.formattedTime
          color: Color.foreground
          font.family: Style.font.family
          font.pixelSize: Style.font.title
          font.bold: true
        }

        TextField {
          id: timeInput
          Layout.fillWidth: true
          placeholderText: "Seconds (for example, 60)"
          inputMethodHints: Qt.ImhDigitsOnly
          validator: IntValidator { bottom: 1; top: 86400 }
          onAccepted: root.setTimer()
        }

        RowLayout {
          Layout.fillWidth: true
          spacing: Style.space(8)

          Button {
            Layout.fillWidth: true
            text: "Set"
            focusable: true
            onClicked: root.setTimer()
          }
          Button {
            Layout.fillWidth: true
            text: root.running ? "Pause" : "Start"
            focusable: true
            enabled: root.timerSeconds > 0
            onClicked: root.running = !root.running
          }
          Button {
            Layout.fillWidth: true
            text: "Reset"
            focusable: true
            enabled: root.initialSeconds > 0
            onClicked: root.resetTimer()
          }
        }
      }
    }
  }
}
