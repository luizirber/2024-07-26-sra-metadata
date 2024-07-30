LOAD parquet;

SET
    memory_limit = '48GB';

COPY (
    SELECT
        acc,
        geo_loc_name_country_calc,
        geo_loc_name_country_continent_calc,
        organism,
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
) TO 'subset.parquet' (FORMAT 'parquet', CODEC 'zstd');
