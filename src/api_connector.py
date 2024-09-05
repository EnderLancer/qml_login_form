from enum import Enum

import requests

class ApiConnector:
    """
    
    """
    class Databases(Enum):
        prod = "https://m11g.prod.ajax.systems/core-db/api/v1/"
        debug = "https://m11g-x.stage.ajax.systems/core-db/api/v1/"

    def __init__(self, env) -> None:
        self.base_url = ApiConnector.Databases[env].value

    def get_prod_locations(self):
        url = f"{self.base_url}general/prod_location/"
        response = requests.get(url)
        data = response.json()

        data_list = [loc["location"] for loc in data]
        return sorted(data_list)
