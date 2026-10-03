from sqlalchemy import create_engine
from models import Incident, Resource, Hospital, Road, ReliefCentre

DATABASE_URL = "postgresql+psycopg://postgres:DisasterDemo2026@localhost:5432/disaster_response"

engine = create_engine(DATABASE_URL)


def seed_database():
    with engine.begin() as connection:

        # Incidents
        connection.execute(
            Incident.__table__.insert(),
            [
                {
                    "title": "Andheri Building Collapse",
                    "incident_type": "Building Collapse",
                    "severity": 5,
                    "status": "active",
                    "latitude": 19.1197,
                    "longitude": 72.8468,
                },
                {
                    "title": "Kurla Flooding",
                    "incident_type": "Flood",
                    "severity": 4,
                    "status": "active",
                    "latitude": 19.0726,
                    "longitude": 72.8845,
                },
                {
                    "title": "Bandra Fire",
                    "incident_type": "Fire",
                    "severity": 3,
                    "status": "active",
                    "latitude": 19.0607,
                    "longitude": 72.8362,
                },
            ],
        )

        # Resources
        connection.execute(
            Resource.__table__.insert(),
            [
                {
                    "name": "Ambulance A01",
                    "resource_type": "ambulance",
                    "status": "available",
                    "quantity": 1,
                    "latitude": 19.1180,
                    "longitude": 72.8470,
                },
                {
                    "name": "Ambulance A02",
                    "resource_type": "ambulance",
                    "status": "available",
                    "quantity": 1,
                    "latitude": 19.0750,
                    "longitude": 72.8800,
                },
                {
                    "name": "Ambulance A03",
                    "resource_type": "ambulance",
                    "status": "available",
                    "quantity": 1,
                    "latitude": 19.0620,
                    "longitude": 72.8400,
                },
                {
                    "name": "Ambulance A04",
                    "resource_type": "ambulance",
                    "status": "available",
                    "quantity": 1,
                    "latitude": 19.0900,
                    "longitude": 72.8600,
                },
                {
                    "name": "Oxygen Unit O01",
                    "resource_type": "oxygen",
                    "status": "available",
                    "quantity": 50,
                    "latitude": 19.1100,
                    "longitude": 72.8500,
                },
            ],
        )

        # Hospitals
        connection.execute(
            Hospital.__table__.insert(),
            [
                {
                    "name": "City General Hospital",
                    "capacity": 200,
                    "occupied": 145,
                    "oxygen_stock": 80,
                    "latitude": 19.1176,
                    "longitude": 72.8467,
                },
                {
                    "name": "Mumbai Emergency Hospital",
                    "capacity": 150,
                    "occupied": 90,
                    "oxygen_stock": 120,
                    "latitude": 19.0728,
                    "longitude": 72.8826,
                },
                {
                    "name": "Harbour Medical Centre",
                    "capacity": 100,
                    "occupied": 45,
                    "oxygen_stock": 65,
                    "latitude": 19.0600,
                    "longitude": 72.8350,
                },
            ],
        )

        # Roads
        connection.execute(
            Road.__table__.insert(),
            [
                {
                    "road_code": "R17",
                    "name": "Andheri Link Road",
                    "status": "open",
                    "travel_time": 12,
                },
                {
                    "road_code": "R21",
                    "name": "Western Express Connector",
                    "status": "open",
                    "travel_time": 18,
                },
                {
                    "road_code": "R08",
                    "name": "Kurla Main Road",
                    "status": "open",
                    "travel_time": 15,
                },
                {
                    "road_code": "R31",
                    "name": "Bandra Connector",
                    "status": "open",
                    "travel_time": 10,
                },
                {
                    "road_code": "R44",
                    "name": "Harbour Link",
                    "status": "open",
                    "travel_time": 20,
                },
            ],
        )

        # Relief Centres
        connection.execute(
            ReliefCentre.__table__.insert(),
            [
                {
                    "name": "Andheri Relief Centre",
                    "capacity": 500,
                    "occupied": 180,
                    "latitude": 19.1200,
                    "longitude": 72.8500,
                },
                {
                    "name": "Kurla Relief Centre",
                    "capacity": 400,
                    "occupied": 250,
                    "latitude": 19.0750,
                    "longitude": 72.8880,
                },
                {
                    "name": "Bandra Relief Centre",
                    "capacity": 300,
                    "occupied": 120,
                    "latitude": 19.0580,
                    "longitude": 72.8380,
                },
                {
                    "name": "Central Relief Hub",
                    "capacity": 600,
                    "occupied": 200,
                    "latitude": 19.0900,
                    "longitude": 72.8650,
                },
                {
                    "name": "Harbour Relief Hub",
                    "capacity": 350,
                    "occupied": 100,
                    "latitude": 19.0550,
                    "longitude": 72.8300,
                },
            ],
        )


if __name__ == "__main__":
    seed_database()
    print("DEMO DATA INSERTED SUCCESSFULLY")