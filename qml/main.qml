import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.15

ApplicationWindow {
    visible: true
    width: 600
    height: 400
    title: "Login Form"

    Material.theme: Material.Dark
    Material.accent: Material.Green

    property variant devicesChoice: ["Choose database"]
    property QtObject backend

    Pane {
        width: 400
        height: 300
        anchors.centerIn: parent

        ColumnLayout {
            Layout.fillWidth: true
            Layout.minimumWidth: 400
            spacing: 15
            Label {
                Layout.alignment: Qt.AlignVCenter
                color: "white"
                text: "Виконайте логін у програму"
            }

            Rectangle {
                height: 1
                color: "grey"
            }

            RowLayout {
                Layout.fillWidth: true
                Label {
                    id: database_label
                    width: 70
                    text: "Database:"
                    color: "white"
                }

                RadioButton {
                    id: prodRadioButton
                    text: "production"
                    font.pointSize: 12

                    onClicked: backend.deviceListSet("prod")
                }

                RadioButton {
                    id: debugRadioButton
                    text: "debug_production"
                    font.pointSize: 12

                    onClicked: backend.deviceListSet("debug")
                }
            }

            TextField {
                id: usernameField
                Layout.fillWidth: true
                width: 300
                placeholderText: "Логін"
            }

            TextField {
                id: passwordField
                Layout.fillWidth: true
                width: 300
                placeholderText: "Пароль"
                echoMode: TextInput.Password
            }

            RowLayout {
                Layout.fillWidth: true
                ComboBox {
                    id: deviceComboBox
                    Layout.minimumWidth: 40 + deviceComboBox.currentText.length * 8
                    Layout.alignment: Qt.AlignLeft
                    width: 150
                    model: devicesChoice
                    popup: Popup {
                        id: devicePopup

                        contentItem: ListView {
                            implicitHeight: contentHeight
                            implicitWidth: 200
                            model: deviceComboBox.popup.visible ? deviceComboBox.delegateModel : null
                            currentIndex: deviceComboBox.highlightedIndex
                        }
                    }

                    onCurrentIndexChanged: console.debug("Device changed to " + currentIndex)
                }
                Rectangle {Layout.fillWidth: true}
                Button {
                    text: "Login"
                    Layout.minimumWidth: 100
                    Layout.alignment: Qt.AlignRight
                    Material.background: Material.Green
                    onClicked: {
                        console.log("Логін: " + usernameField.text)
                        console.log("Пароль: " + passwordField.text)
                        console.log("БД: " + (prodRadioButton.checked ? "Prod" : "Debug"))
                        console.log("Пристрій: " + deviceComboBox.currentText)
                    }
                }
            }
        }
    }
    Connections {
        target: backend

        function onDeviceListUpdated(devices) {
            devicesChoice = devices
        }
    }
}