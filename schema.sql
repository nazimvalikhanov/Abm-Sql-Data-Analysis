
-- ========================================
-- DATABASE: ABM_Geodata (Synthetic Dataset)
-- PURPOSE: Demonstration for SQL Data Analysis Skills
-- NOTE: This dataset is fully synthetic and was generated for learning and demonstration purposes only.
-- It does not reflect any real-world proprietary information from ABM Engineering.
-- ========================================

-- Create Database
CREATE DATABASE ABM_Geodata;
GO

-- Use the new database
USE ABM_Geodata;
GO

-- Table: Locations
CREATE TABLE Locations (
    location_id INT PRIMARY KEY IDENTITY(1,1),
    region_name VARCHAR(100) NOT NULL,
    gps_latitude FLOAT,
    gps_longitude FLOAT
);

-- Table: Wells
CREATE TABLE Wells (
    well_id INT PRIMARY KEY IDENTITY(1,1),
    well_name VARCHAR(100) NOT NULL,
    location_id INT NOT NULL,
    drilling_date DATE,
    depth_meters FLOAT,
    status VARCHAR(50),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Table: Measurements
CREATE TABLE Measurements (
    measurement_id INT PRIMARY KEY IDENTITY(1,1),
    well_id INT NOT NULL,
    measurement_date DATE,
    layer_depth FLOAT,
    porosity FLOAT,
    permeability FLOAT,
    pressure FLOAT,
    FOREIGN KEY (well_id) REFERENCES Wells(well_id)
);

-- Table: KPI_Data
CREATE TABLE KPI_Data (
    kpi_id INT PRIMARY KEY IDENTITY(1,1),
    location_id INT NOT NULL,
    kpi_name VARCHAR(100) NOT NULL,
    kpi_value FLOAT,
    record_date DATE,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Sample Data: Locations
INSERT INTO Locations (region_name, gps_latitude, gps_longitude) VALUES
('North Field', 40.3725, 49.8530),
('South Ridge', 39.9208, 32.8541),
('East Basin', 41.0082, 28.9784),
('West Hills', 38.4237, 27.1428),
('Central Zone', 40.4093, 49.8671);

-- Sample Data: Wells
INSERT INTO Wells (well_name, location_id, drilling_date, depth_meters, status) VALUES
('Well-001', 1, '2021-03-15', 3500, 'Active'),
('Well-002', 1, '2022-07-19', 4200, 'Completed'),
('Well-003', 2, '2023-01-22', 3100, 'Active'),
('Well-004', 3, '2020-10-30', 2750, 'Inactive'),
('Well-005', 4, '2021-06-11', 3900, 'Completed'),
('Well-006', 5, '2022-04-04', 3600, 'Active');

-- Sample Data: Measurements
INSERT INTO Measurements (well_id, measurement_date, layer_depth, porosity, permeability, pressure) VALUES
(1, '2021-03-16', 1200, 12.5, 150, 2500),
(1, '2021-03-17', 1800, 14.1, 180, 2450),
(2, '2022-07-20', 1300, 11.2, 130, 2600),
(3, '2023-01-23', 1400, 13.0, 160, 2400),
(4, '2020-10-31', 1100, 10.8, 120, 2350),
(5, '2021-06-12', 1700, 15.0, 190, 2550),
(6, '2022-04-05', 1250, 13.5, 175, 2480);

-- Sample Data: KPI_Data
INSERT INTO KPI_Data (location_id, kpi_name, kpi_value, record_date) VALUES
(1, 'cost_per_well', 500000, '2023-01-01'),
(1, 'efficiency_index', 82.5, '2023-01-01'),
(2, 'cost_per_well', 470000, '2023-01-01'),
(2, 'efficiency_index', 79.2, '2023-01-01'),
(3, 'cost_per_well', 520000, '2023-01-01'),
(3, 'efficiency_index', 75.0, '2023-01-01'),
(4, 'cost_per_well', 490000, '2023-01-01'),
(5, 'efficiency_index', 84.1, '2023-01-01');
