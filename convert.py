from pathlib import Path

import duckdb

conn = duckdb.connect(database=':memory:')

for datafile in Path("inputs/").glob("*"):
    output = Path("output/") / datafile.name
    query = f"""
      COPY (
        SELECT
          acc,
          geo_loc_name_country_calc,
          geo_loc_name_country_continent_calc,
          organism,
          lat_lon.v as lat_lon
        FROM
          read_parquet('{datafile}')
        CROSS JOIN UNNEST(attributes) AS t(lat_lon)
        WHERE lat_lon.k = 'lat_lon_sam_s_dpl34'
      ) TO '{output}' (FORMAT 'parquet', CODEC 'zstd');
    """
    conn.execute(query)

merge_query = """
COPY (
  SELECT
    *
  FROM
    read_parquet('output/*'))
  TO 'subset.parquet' (FORMAT 'parquet', CODEC 'zstd');
"""

conn.execute(merge_query)
