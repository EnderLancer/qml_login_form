import QtQuick.Controls 2.15

RadioButton {
    property string env: "debug"

    text: "debug_production"
    font.pointSize: 12

    onClicked: backend.requestLocationList(env)
}