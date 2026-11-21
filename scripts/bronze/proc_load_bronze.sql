/*
================================================================================================
Stored Procedure: Load Bronze Layer (Source ->Bronze)
================================================================================================
Script purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
		-truncates the bronze tables before loading data,
		-uses the 'BULK INSERT' command to load the data from csv files to 'bronze' layer tables.
Parameters: 
	None - this stored procedure does not accept any parameters and does not return any value.
Usage example:
	EXEC bronze.load_bronze;
=================================================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME2, @end_time DATETIME2, @start_procedure DATETIME2;
	BEGIN TRY
		SET @start_procedure = SYSDATETIME();
		PRINT '====================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================';

		PRINT '------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------';

		SET @start_time = SYSDATETIME();
		
		PRINT '>> Truncating Table bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data into bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\User\Downloads\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
		SET @end_time = SYSDATETIME();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + 'ms';
		PRINT '------'
		
		SET @start_time = SYSDATETIME();
		
		PRINT '>> Truncating Table bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data into bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\User\Downloads\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
		SET @end_time = SYSDATETIME();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + 'ms';
		PRINT '------'

		SET @start_time = SYSDATETIME();
		
		PRINT '>> Truncating Table bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data into bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\User\Downloads\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
		SET @end_time = SYSDATETIME();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + 'ms';
		PRINT '------'


		PRINT '------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------';
		
		SET @start_time = SYSDATETIME();
		
		PRINT '>> Truncating Table bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data into bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\User\Downloads\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
		SET @end_time = SYSDATETIME();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + 'ms';
		PRINT '------'

		SET @start_time = SYSDATETIME();
		
		PRINT '>> Truncating Table bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data into bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\User\Downloads\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
		SET @end_time = SYSDATETIME();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + 'ms';
		PRINT '------'


		SET @start_time = SYSDATETIME();

		PRINT '>> Truncating Table bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data into bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\User\Downloads\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
		SET @end_time = SYSDATETIME();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(millisecond, @start_time, @end_time) AS NVARCHAR) + 'ms';
		PRINT '------'
		SET @end_time = SYSDATETIME();
		PRINT '==================================';
		PRINT '>> LOADING BRONZE LAYER SUCCEDED; Procedure duration: ' + CAST(DATEDIFF(millisecond, @start_procedure, @end_time) AS NVARCHAR) + 'ms';
		PRINT '==================================';

	END TRY
	BEGIN CATCH
		PRINT '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
		PRINT 'ERROR OCURRED DURING LOADING LAYER'
		PRINT '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
		PRINT '=================================='
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT '=================================='
		PRINT 'ERROR NUMBER' + CAST( ERROR_NUMBER() AS NVARCHAR);
		PRINT '=================================='
		PRINT 'ERROR STATE' + CAST( ERROR_STATE() AS NVARCHAR);
		PRINT '=================================='
	END CATCH
END
