
-- ============================================
-- ABM_Geodata SQL Query Collection
-- Note: This dataset is fully synthetic and was generated for learning and demonstration purposes only.
-- It does not reflect any real-world proprietary information from ABM Engineering.
-- ============================================

-- ===========================
-- Basic SELECT Queries
-- ===========================

-- Average well depth over the past 3 years, grouped by region
SELECT l.region_name, 
       COUNT(w.well_id) AS well_count,
       ROUND(AVG(w.depth_meters), 2) AS avg_depth
FROM Wells w
JOIN Locations l ON w.location_id = l.location_id
WHERE w.drilling_date >= DATEADD(YEAR, -3, GETDATE())
GROUP BY l.region_name;

-- Number of active wells per region
SELECT l.region_name, 
       COUNT(w.well_id) AS active_wells
FROM Wells w
JOIN Locations l ON w.location_id = l.location_id
WHERE w.status = 'Active'
GROUP BY l.region_name;

-- Average porosity and permeability for each well
SELECT w.well_name,
       ROUND(AVG(m.porosity), 2) AS avg_porosity,
       ROUND(AVG(m.permeability), 2) AS avg_permeability
FROM Measurements m
JOIN Wells w ON m.well_id = w.well_id
GROUP BY w.well_name;

-- Wells with porosity greater than 14%
SELECT DISTINCT w.well_name, m.porosity
FROM Measurements m
JOIN Wells w ON m.well_id = w.well_id
WHERE m.porosity > 14.0;

-- All wells with their GPS coordinates
SELECT w.well_name, l.region_name, l.gps_latitude, l.gps_longitude
FROM Wells w
JOIN Locations l ON w.location_id = l.location_id;

-- GPS coordinates of active wells
SELECT w.well_name, l.region_name, l.gps_latitude, l.gps_longitude
FROM Wells w
JOIN Locations l ON w.location_id = l.location_id
WHERE w.status = 'Active';

-- Average cost per well (KPI) by region
SELECT l.region_name, 
       ROUND(AVG(k.kpi_value), 0) AS avg_cost
FROM KPI_Data k
JOIN Locations l ON k.location_id = l.location_id
WHERE k.kpi_name = 'cost_per_well'
GROUP BY l.region_name;

-- Regions with efficiency index greater than 80
SELECT l.region_name, k.kpi_value AS efficiency_index
FROM KPI_Data k
JOIN Locations l ON k.location_id = l.location_id
WHERE k.kpi_name = 'efficiency_index' AND k.kpi_value > 80;


-- ===========================
-- Advanced SQL Queries
-- ===========================

-- Calculate the difference between each well's depth and the average depth in its region
SELECT 
    w.well_name,
    l.region_name,
    w.depth_meters,
    ROUND(AVG(w.depth_meters) OVER (PARTITION BY l.region_name), 2) AS region_avg_depth,
    w.depth_meters - AVG(w.depth_meters) OVER (PARTITION BY l.region_name) AS depth_diff_from_avg
FROM Wells w
JOIN Locations l ON w.location_id = l.location_id;

-- List wells drilled after 2021 with row numbers (CTE example)
WITH RecentWells AS (
    SELECT 
        well_id,
        well_name,
        drilling_date,
        depth_meters,
        ROW_NUMBER() OVER (ORDER BY drilling_date DESC) AS row_num
    FROM Wells
    WHERE drilling_date >= '2021-01-01'
)
SELECT * FROM RecentWells;

-- Wells whose average porosity exceeds 13%
SELECT 
    w.well_name,
    m.measurement_date,
    m.porosity
FROM Measurements m
JOIN Wells w ON m.well_id = w.well_id
WHERE w.well_id IN (
    SELECT well_id
    FROM Measurements
    GROUP BY well_id
    HAVING AVG(porosity) > 13.0
);

-- Compare each region's 'cost_per_well' KPI to the global average
SELECT 
    l.region_name,
    k.kpi_value AS cost_per_well,
    ROUND(AVG(k.kpi_value) OVER (), 0) AS global_avg_cost,
    k.kpi_value - AVG(k.kpi_value) OVER () AS difference_from_global
FROM KPI_Data k
JOIN Locations l ON k.location_id = l.location_id
WHERE k.kpi_name = 'cost_per_well';

-- Top 3 deepest wells with region info using CTE + RANK()
WITH WellDepths AS (
    SELECT 
        w.well_id,
        w.well_name,
        w.depth_meters,
        l.region_name,
        RANK() OVER (ORDER BY w.depth_meters DESC) AS depth_rank
    FROM Wells w
    JOIN Locations l ON w.location_id = l.location_id
)
SELECT well_name, region_name, depth_meters
FROM WellDepths
WHERE depth_rank <= 3;
