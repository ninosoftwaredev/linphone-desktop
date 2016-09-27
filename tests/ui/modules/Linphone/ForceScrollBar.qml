import QtQuick 2.7
import QtQuick.Controls 2.0

import Linphone.Styles 1.0

// ===================================================================

ScrollBar {
  id: scrollBar

  background: ForceScrollBarStyle.background
  contentItem: Rectangle {
    color: scrollBar.pressed
      ? ForceScrollBarStyle.color.pressed
      : (scrollBar.hovered
         ? ForceScrollBarStyle.color.hovered
         : ForceScrollBarStyle.color.normal
        )
    implicitHeight: ForceScrollBarStyle.contentItem.implicitHeight
    implicitWidth: ForceScrollBarStyle.contentItem.implicitWidth
    radius: ForceScrollBarStyle.contentItem.radius
  }
  hoverEnabled: true
}
