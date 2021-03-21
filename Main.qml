/*
* Copyright (c) 2021 Romullo @hiukky.
*
* This file is part of FlateOS
* (see https://github.com/flateos).
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle {
    id: container
    anchors.fill: parent
    width: parent.width
    height: parent.height
    color: "#0d1117"

    LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sessionIndex: session.index

    Connections {
        target: sddm

        onLoginSucceeded: {
            errorMessage.color = "#23d18c"
            errorMessage.text = qsTr("Login succeeded")
        }

        onLoginFailed: {
            password.text = ""
            errorMessage.color = "#e84855"
            errorMessage.text = qsTr("Login failed")
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: rectangle
            anchors.centerIn: parent
            width: Math.max(320, mainColumn.implicitWidth + 50)
            height: Math.max(320, mainColumn.implicitHeight + 50)
            color: "transparent"
            border.color: "#15EDD3"
            border.width: 3
            radius: 20

            Column {
                id: mainColumn
                anchors.centerIn: parent
                spacing: 12

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    height: 150
                    width: 150
                    horizontalAlignment: Text.AlignHCenter
                    source: "assets/images/logo.svg"
                }

                Column {
                    width: parent.width
                    spacing : 4

                    ComboBox {
                        id: session
                        width: parent.width
                        height: 40
                        textRole: "name"
                        displayText: currentIndex === -1 ? qsTr("Session") : currentText
                        model: sessionModel
                        background: Rectangle { color: "#14181E"; radius: 7 }
                        contentItem: Text {
                          color: session.currentIndex === -1 ? "#8C8D8E" : "#ffffff"
                          text: session.displayText
                          font.pixelSize: 13;
                          padding: 10
                          verticalAlignment: Text.AlignVCenter;
                          horizontalAlignment: Text.AlignLeft;
                        }
                    }
                }

                Column {
                    width: parent.width
                    spacing: 4

                    TextField  {
                        id: name
                        width: parent.width; height: 40
                        text: userModel.lastUser
                        font.pixelSize: 13
                        palette.text: "white"
                        placeholderText: qsTr("Username")
                        background: Rectangle { color: "#14181E"; radius: 7 }
                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex)
                                event.accepted = true
                            }
                        }
                    }
                }

                Column {
                    width: parent.width
                    spacing : 4

                    TextField {
                        id: password
                        width: parent.width; height: 40
                        font.pixelSize: 13
                        KeyNavigation.backtab: name; KeyNavigation.tab: session
                        echoMode: TextInput.Password
                        palette.text: "white"
                        placeholderText: qsTr("Password")
                        background: Rectangle { color: "#14181E"; radius: 7 }
                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex)
                                event.accepted = true
                            }
                        }
                    }
                }

                Column {
                    width: parent.width

                    Text {
                        color: "white"
                        id: errorMessage
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Enter your username and password")
                        font.pixelSize: 10
                    }
                }

                Row {
                    spacing: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    property int btnWidth: Math.max(loginButton.implicitWidth,
                                                    shutdownButton.implicitWidth,
                                                    rebootButton.implicitWidth, 80) + 8

                    Button {
                        id: loginButton
                        text: qsTr("Login")
                        width: parent.btnWidth
                        KeyNavigation.backtab: layoutBox; KeyNavigation.tab: shutdownButton
                        palette.buttonText: "#23d18c"
                        background: Rectangle { color: "transparent" }
                        icon.source: "assets/icons/login-circle-fill.svg"

                        MouseArea {
                            hoverEnabled: true
                            anchors.fill: parent
                            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                            onClicked: sddm.login(name.text, password.text, sessionIndex)
                        }

                    }

                    Button {
                        id: shutdownButton
                        text: qsTr("Shutdown")
                        width: parent.btnWidth
                        KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
                        palette.buttonText: "#FFE066"
                        background: Rectangle { color: "transparent" }
                        icon.source: "assets/icons/restart-fill.svg"

                        MouseArea {
                            hoverEnabled: true
                            anchors.fill: parent
                            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                            onClicked: sddm.powerOff()
                        }
                    }

                    Button {
                        id: rebootButton
                        text: qsTr("Reboot")
                        width: parent.btnWidth
                        KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
                        palette.buttonText: "#E84855"
                        background: Rectangle { color: "transparent" }
                        icon.source: "assets/icons/shut-down-fill.svg"

                        MouseArea {
                            hoverEnabled: true
                            anchors.fill: parent
                            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                            onClicked: sddm.reboot()
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (name.text === "")
            name.focus = true
        else
            password.focus = true
    }
}
