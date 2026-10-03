from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import create_engine, text

app = FastAPI(title="Disaster Response Intelligence")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

DATABASE_URL = "postgresql+psycopg://postgres:Shubhamog%40@localhost:5432/disaster_response"

engine = create_engine(DATABASE_URL)


@app.get("/")
def root():
    return {
        "message": "Disaster Response Intelligence API is running"
    }


@app.get("/health")
def health():
    try:
        with engine.connect() as connection:
            connection.execute(text("SELECT 1"))

        return {
            "status": "healthy",
            "database": "connected"
        }

    except Exception as e:
        return {
            "status": "unhealthy",
            "database": "disconnected",
            "error": str(e)
        }


@app.get("/incidents")
def get_incidents():
    with engine.connect() as connection:
        result = connection.execute(
            text("""
                SELECT id, title, incident_type, severity, status,
                       latitude, longitude
                FROM incidents
                ORDER BY severity DESC
            """)
        )

        incidents = [dict(row._mapping) for row in result]

    return {
        "count": len(incidents),
        "incidents": incidents
    }


@app.get("/hospitals")
def get_hospitals():
    with engine.connect() as connection:
        result = connection.execute(
            text("""
                SELECT id, name, capacity, occupied,
                       oxygen_stock, latitude, longitude
                FROM hospitals
            """)
        )

        hospitals = [dict(row._mapping) for row in result]

    return {
        "count": len(hospitals),
        "hospitals": hospitals
    }


@app.get("/resources")
def get_resources():
    with engine.connect() as connection:
        result = connection.execute(
            text("""
                SELECT id, name, resource_type, status,
                       quantity, latitude, longitude
                FROM resources
            """)
        )

        resources = [dict(row._mapping) for row in result]

    return {
        "count": len(resources),
        "resources": resources
    }


@app.get("/roads")
def get_roads():
    with engine.connect() as connection:
        result = connection.execute(
            text("""
                SELECT id, road_code, name, status, travel_time
                FROM roads
            """)
        )

        roads = [dict(row._mapping) for row in result]

    return {
        "count": len(roads),
        "roads": roads
    }


@app.get("/relief-centres")
def get_relief_centres():
    with engine.connect() as connection:
        result = connection.execute(
            text("""
                SELECT id, name, capacity, occupied,
                       latitude, longitude
                FROM relief_centres
            """)
        )

        centres = [dict(row._mapping) for row in result]

    return {
        "count": len(centres),
        "relief_centres": centres
    }