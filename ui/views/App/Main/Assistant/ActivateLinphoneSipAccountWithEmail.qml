import QtQuick 2.7

import Common 1.0
import Linphone 1.0
import LinphoneUtils 1.0
import App.Styles 1.0

// =============================================================================

AssistantAbstractView {
  property var assistantModel
  property var codecInfo: VideoCodecsModel.getDownloadableCodecInfo("H264")

  backEnabled: false

  title: qsTr('activateLinphoneSipAccount')

  mainAction: requestBlock.execute
  mainActionEnabled: !requestBlock.loading
  mainActionLabel: qsTr('confirmAction')

  Column {
    anchors.centerIn: parent
    spacing: ActivateLinphoneSipAccountWithEmailStyle.spacing
    width: parent.width

    Text {
      color: ActivateLinphoneSipAccountWithEmailStyle.activationSteps.color
      font.pointSize: ActivateLinphoneSipAccountWithEmailStyle.activationSteps.pointSize
      horizontalAlignment: Text.AlignHCenter
      text: qsTr('activationSteps').replace('%1', assistantModel.email)
      width: parent.width
      wrapMode: Text.WordWrap
    }

    RequestBlock {
      id: requestBlock

      action: assistantModel.activate
      width: parent.width
    }
  }

  // ---------------------------------------------------------------------------
  // Assistant.
  // ---------------------------------------------------------------------------

  Connections {
    target: assistantModel

    onActivateStatusChanged: {
      requestBlock.stop(error)
      if (!error.length && codecInfo.downloadUrl) {
         LinphoneUtils.openCodecOnlineInstallerDialog(window, codecInfo, function cb(window) {
           window.unlockView()
           window.setView('Home')	
         })
      }
      else {
           window.unlockView()
           window.setView('Home')
      }
    }
  }
}
