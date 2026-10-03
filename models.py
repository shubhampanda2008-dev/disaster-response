from sqlalchemy import Column, Integer, String, Float, Boolean, ForeignKey
from sqlalchemy.orm import declarative_base, relationship

Base = declarative_base()


class Incident(Base):
    __tablename__ = "incidents"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    incident_type = Column(String, nullable=False)
    severity = Column(Integer, nullable=False)
    status = Column(String, default="active")
    latitude = Column(Float)
    longitude = Column(Float)

    resources = relationship("Resource", back_populates="incident")


class Resource(Base):
    __tablename__ = "resources"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    resource_type = Column(String, nullable=False)
    status = Column(String, default="available")
    quantity = Column(Integer, default=1)
    latitude = Column(Float)
    longitude = Column(Float)

    incident_id = Column(Integer, ForeignKey("incidents.id"), nullable=True)
    incident = relationship("Incident", back_populates="resources")


class Hospital(Base):
    __tablename__ = "hospitals"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    capacity = Column(Integer, nullable=False)
    occupied = Column(Integer, default=0)
    oxygen_stock = Column(Integer, default=100)
    latitude = Column(Float)
    longitude = Column(Float)


class Road(Base):
    __tablename__ = "roads"

    id = Column(Integer, primary_key=True, index=True)
    road_code = Column(String, nullable=False, unique=True)
    name = Column(String, nullable=False)
    status = Column(String, default="open")
    travel_time = Column(Integer, default=10)


class ReliefCentre(Base):
    __tablename__ = "relief_centres"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    capacity = Column(Integer, nullable=False)
    occupied = Column(Integer, default=0)
    latitude = Column(Float)
    longitude = Column(Float)