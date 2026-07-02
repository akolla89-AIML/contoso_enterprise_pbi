# Enterprise Warehouse Architecture

## Why multiple schemas?

Instead of placing every table in dbo, enterprise data warehouses organize objects into business domains.

Schemas improve:

- Security
- Organization
- Maintainability
- Deployment
- Code reviews

## Schemas

staging
Raw data from source systems.

dimension
Business entities.

fact
Business events and measurements.

audit
ETL execution logs.

metadata
ETL configuration and control tables.