# Database as Code

## Definition

Database as Code means the database schema is stored in source control instead of existing only inside SQL Server.

## Source of Truth

The SQL Database Project (.sqlproj) is the source of truth.

The deployed SQL Server database is a generated artifact.

## Workflow

Developer
    ↓
Modify SQL Project
    ↓
Build
    ↓
Publish
    ↓
SQL Server