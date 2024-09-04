import sys
from dotenv import load_dotenv, find_dotenv

import requests

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QStringListModel, QObject, pyqtSignal


def get_countries():
    url = "http://country.io/names.json"
    response = requests.get(url)
    data = response.json()
    
    #Format and sort the data
    data_list = list(data.values())
    return sorted(data_list)


class Backend(QObject):
    deviceListSet = pyqtSignal(str)
    deviceListUpdated = pyqtSignal(list, arguments=["devices"])

    def __init__(self):
        super().__init__()
        self.deviceListSet.connect(self.update_devices_list)
        self.deviceListUpdated.emit(get_countries())

    def update_devices_list(self, env):
        devicesListModel = get_countries()  # TODO: replace with get_devices()
        devicesListModel.append(env)
        self.deviceListUpdated.emit(devicesListModel)


def main():
    load_dotenv(find_dotenv())
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.load('qml/main.qml')
    backend = Backend()
    engine.rootObjects()[0].setProperty('backend', backend)

    sys.exit(app.exec())


if __name__ == "__main__":
    main()
