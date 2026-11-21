/*
===========================
CREATE DATABASE AND SCHEMAS
===========================
Script purpose:
	This script creates a new database called 'DataWarehouse' after checking whether it already exists.
	If it does, it is dropped and recreated. Additionally, the script sets up three schemas within the database: 
	'bronze', 
	'silver,
	'gold'.

WARNING: 
	Running this script will drop the entire 'DataWarehouse' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution 
	and ensure you have proper backups before running this script.
*/

USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO


---Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO 

USE DataWarehouse;
GO

---Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
