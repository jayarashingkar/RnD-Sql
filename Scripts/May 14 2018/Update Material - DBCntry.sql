﻿USE RDB 
GO

SELECT * FROM RNDMaterial

UPDATE RNDMaterial 
SET DBCntry = 'NO' WHERE MillLotNo > 999990 