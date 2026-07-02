# SQL Database Projects (.sqlproj)

## What is a SQL Database Project?

A SQL Database Project stores the entire database schema as source code.

Instead of manually creating databases, tables, and views in SQL Server, all objects are defined in source-controlled SQL files.

## Benefits

- Database as Code
- Source Control
- Build Validation
- DACPAC Generation
- Repeatable Deployments
- CI/CD Ready

## Build vs Publish

Build
- Validates schema
- Produces a DACPAC
- Does not modify SQL Server

Publish
- Connects to SQL Server
- Creates or updates the target database
- Synchronizes schema