import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {
    anchors.fill: parent
    width: parent.width
    height: parent.height
    color: "#0d1117"

    Connections {
        target: sddm
    }

    ColumnLayout {
        spacing: 10
        anchors {
             horizontalCenter: parent.horizontalCenter
             top: parent.top
             topMargin: 150
        }

        Rectangle {
            id: cover
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: 150
            Layout.preferredHeight: 150
            radius: 20
            clip: true
            color: "#0d1117"


            Image {
                id: avatar
                anchors.fill: parent
                source: "assets/avatar.png"
            }
        }

        TextField {
            placeholderText: qsTr("Password")
        }

        Button {
            text: "Login"
            onClicked: {
                console.log('Success')
            }
        }
    }
}
