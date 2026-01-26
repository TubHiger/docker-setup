--Question 3. For the trips in November 2025, how many trips had a trip_distance of less than or equal to 1 mile? (1 point)

SELECT COUNT(*)
FROM green_taxi_trips
WHERE trip_distance <= 1 
	AND lpep_pickup_datetime >= '2025-11-01 00:00:00' 
	AND lpep_dropoff_datetime < '2025-12-01 00:00:00'



-- Question 4. Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles. (1 point)
select lpep_pickup_datetime from public.green_taxi_trips
WHERE trip_distance < 100
ORDER BY trip_distance DESC
LIMIT 1

-- Question 5. Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025? (1 point)
SELECT 
    zpu."Zone" as pickup_zone,
    SUM(total_amount) as total_amount_sum
FROM 
    green_taxi_trips t
    JOIN zones zpu ON t."PULocationID" = zpu."LocationID"
WHERE 
    lpep_pickup_datetime >= '2025-11-18 00:00:00' 
    AND lpep_pickup_datetime < '2025-11-19 00:00:00'
GROUP BY 
    zpu."Zone"
ORDER BY 
    total_amount_sum DESC
LIMIT 1;

-- Question 6. For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip? (1 point)

SELECT 
    zdo."Zone" as dropoff_zone,
    MAX(tip_amount) as largest_tip,
    COUNT(*) as trip_count
FROM 
    green_taxi_trips t
    JOIN zones zpu ON t."PULocationID" = zpu."LocationID"
    JOIN zones zdo ON t."DOLocationID" = zdo."LocationID"
WHERE 
    zpu."Zone" = 'East Harlem North'
    AND lpep_pickup_datetime >= '2025-11-01 00:00:00' 
    AND lpep_pickup_datetime < '2025-12-01 00:00:00'
GROUP BY 
    zdo."Zone"
ORDER BY 
    largest_tip DESC
LIMIT 1;