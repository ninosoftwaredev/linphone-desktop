import QtQuick 2.7
import QtQuick.Controls 2.1

import Common 1.0
import Common.Styles 1.0

// =============================================================================

TextField {
  id: numericField

  property int maxValue: 9999
  property int minValue: 0
  property int step: 1

  // ---------------------------------------------------------------------------

  function _decrease () {
    var value = +numericField.text

    if (value - step >= minValue) {
      numericField.text = value - step
    }
  }

  function _increase () {
    var value = +numericField.text

    if (value + step <= maxValue) {
      numericField.text = value + step
    }
  }

  // ---------------------------------------------------------------------------

  tools: Rectangle {
    border {
      color: TextFieldStyle.background.border.color
      width: TextFieldStyle.background.border.width
    }
    color: 'transparent' // Not a style.

    height: parent.height
    width: NumericFieldStyle.tools.width

    Column {
      id: container

      anchors {
        fill: parent
        margins: TextFieldStyle.background.border.width
      }

      // -----------------------------------------------------------------------

      Component {
        id: button

        Button {
          id: buttonInstance

          autoRepeat: true

          background: Rectangle {
            color: buttonInstance.down && !numericField.readOnly
              ? NumericFieldStyle.tools.button.color.pressed
              : NumericFieldStyle.tools.button.color.normal
          }

          contentItem: Text {
            color: NumericFieldStyle.tools.button.text.color
            text: buttonInstance.text
            font.pointSize: NumericFieldStyle.tools.button.text.fontSize

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }

          text: parent.text

          height: container.height / 2
          width: container.width

          onClicked: !numericField.readOnly && handler()
        }
      }

      // -----------------------------------------------------------------------

      Loader {
        property string text: '+'
        property var handler: _increase

        sourceComponent: button
      }

      Loader {
        property string text: '-'
        property var handler: _decrease

        sourceComponent: button
      }
    }
  }

  validator: IntValidator {
    bottom: numericField.minValue
    top: numericField.maxValue
  }
}
