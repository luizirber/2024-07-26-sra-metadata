LOAD parquet; 

CREATE TABLE sra_metadata AS
  SELECT
   *,
   lat_lon.v as lat_lon
  FROM
   read_parquet('inputs/*')
  CROSS JOIN UNNEST(attributes) AS t(lat_lon)
  WHERE lat_lon.k = 'lat_lon_sam_s_dpl34';
