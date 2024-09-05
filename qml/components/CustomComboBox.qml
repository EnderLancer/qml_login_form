import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

ComboBox {
    Layout.minimumWidth: 150
    Layout.alignment: Qt.AlignLeft
    contentItem: Label {
        leftPadding: 10
        verticalAlignment: Text.AlignVCenter
        color: "lightgreen"
        text: parent.currentText
    }
}