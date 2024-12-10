def model(dbt, session):
    dbt.config(materialized='table', schema='salesmart')
    df = dbt.ref("trf_customers")
    return df