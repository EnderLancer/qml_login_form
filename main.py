import sys
from dotenv import load_dotenv, find_dotenv

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal

from  src.api_connector import ApiConnector


class Backend(QObject):
    requestLocationList = pyqtSignal(str, arguments=["env"])
    locationListUpdated = pyqtSignal(list, arguments=["locations"])

    def __init__(self):
        super().__init__()
        self.locations_by_env = dict()
        self.requestLocationList.connect(self.update_locations_list)

    def update_locations_list(self, env):
        locations = []
        if env in self.locations_by_env:
            locations = self.locations_by_env[env]
        else:
            locations = ApiConnector(env).get_prod_locations()
            if not locations:
                locations = ["No available location"]

        self.locations_by_env[env] = locations

        self.locationListUpdated.emit(locations)


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
