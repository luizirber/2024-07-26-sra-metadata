LOAD parquet;

SET
    memory_limit = '48GB';

EXPLAIN ANALYZE
CREATE TABLE sra_metadata AS
SELECT
    *,
    (
        SELECT
            lat_lon.v
        FROM
            UNNEST(attributes) AS t(lat_lon)
        WHERE
            lat_lon.k = 'lat_lon_sam_s_dpl34'
    ) AS lat_lon
FROM
    read_parquet('inputs/*')
