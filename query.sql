  COPY (
    SELECT
     acc,
     geo_loc_name_country_calc,
     geo_loc_name_country_continent_calc,
     organism,
     lat_lon.v as lat_lon
    FROM
     read_parquet('inputs/*')
    CROSS JOIN UNNEST(attributes) AS t(lat_lon)
    WHERE lat_lon.k = 'lat_lon_sam_s_dpl34'
  ) TO 'subset.parquet' (FORMAT 'parquet', CODEC 'zstd');
