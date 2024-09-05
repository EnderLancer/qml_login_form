import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.15

import "components"

ApplicationWindow {
    visible: true
    width: 425
    height: 310
    title: "Login Form"
    flags: Qt.FramelessWindowHint | Qt.Window

    Material.theme: Material.System
    Material.accent: Material.Green

    property variant locationsChoice: ["Choose database"]
    property QtObject backend

    Pane {
        ColumnLayout {
            Layout.fillWidth: true
            Layout.minimumWidth: 450
            spacing: 15
            
            Label {
                Layout.alignment: Qt.AlignHCenter
                color: "white"
                text: "Виконайте логін у програму"
            }

            Rectangle {
                height: 1
                color: "white"
                width: 400
            }

            RowLayout {
                Label {
                    id: database_label
                    width: 70
                    text: "Database:"
                    color: "white"
                }

                Rectangle {Layout.fillWidth: true}

                EnvSelectorRadioButton {
                    id: prodRadioButton

                    env: "prod"
                    text: "production"
                }

                EnvSelectorRadioButton {
                    env: "debug"
                    text: "debug_production"
                }
            }

            CustomTextField {
                id: usernameField
                placeholderText: "Логін"
            }

            CustomTextField {
                id: passwordField
                placeholderText: "Пароль"
                echoMode: TextInput.Password
            }

            RowLayout {
                // Layout.fillWidth: true
                Layout.minimumWidth: 400
                CustomComboBox {
                    id: locationComboBox
                    model: locationsChoice
                }

                CustomButton {
                    id: customButton
                    text: "Login"
                    Component.onCompleted: {
                        customButton.contentItem.color = "black";
                    }
                    onClicked: {
                        console.log("Логін: " + usernameField.text)
                        console.log("Пароль: " + passwordField.text)
                        console.log("БД: " + (prodRadioButton.checked ? "Prod" : "Debug"))
                        console.log("Локація: " + locationComboBox.currentText)
                    }
                }
            }
        }
    }
    Connections {
        target: backend

        function onLocationListUpdated(locations) {
            locationsChoice = locations
        }
    }
}