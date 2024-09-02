import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Login Form"

    Pane {
        Material.theme: Material.Dark
        Material.primary: Material.Dark
        Material.foreground: Material.Green
        Material.accent: Material.Green
        width: parent.width
        height: parent.height

        Column {
            // anchors.centerIn: parent
            spacing: 15
            Label {
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Виконайте логін у програму"
            }

            Rectangle {
                height: 1
                color: "grey"
                anchors { left: parent.left; right: parent.right }
            }

            // Database Radio Buttons
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: database_label
                    width: 70
                    text: "Database:"
                    anchors.verticalCenter: parent.verticalCenter
                    color: "white"
                }

                RadioButton {
                    id: prodRadioButton
                    text: "production"
                    checked: true
                    font.pointSize: 12
                }

                RadioButton {
                    id: debugRadioButton
                    text: "debug_production"
                    font.pointSize: 12
                }
            }

            // Username Input Field
            TextField {
                id: usernameField
                width: 300
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: "Логін"
            }

            // Password Input Field
            TextField {
                id: passwordField
                width: 300
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: "Пароль"
                echoMode: TextInput.Password
            }

            Row {
                // Device Dropdown
                ComboBox {
                    id: accessComboBox
                    width: 150
                    model: ListModel {
                        id: devices
                        ListElement { name: "BRSP009" }
                        ListElement { name: "BRSP007" }
                        ListElement { name: "BRSP001" }
                    }

                    delegate: ItemDelegate {
                        width: accessComboBox.width
                        Material.theme: Material.Dark
                        Material.primary: Material.Dark
                        Material.foreground: Material.Green
                        Material.accent: Material.Green
                    }
                    onCurrentIndexChanged: console.debug("Device changed to " + devices.get(currentIndex).name)
                }

                spacing: 30

                // Login Button
                Button {
                    text: "Login"
                    width: 200
                    onClicked: {
                        console.log("Логін: " + usernameField.text)
                        console.log("Пароль: " + passwordField.text)
                        console.log("БД: " + (prodRadioButton.checked ? "Prod" : "Debug"))
                        console.log("Пристрій: " + accessComboBox.currentText)
                    }
                }
            }
        }

    }
}