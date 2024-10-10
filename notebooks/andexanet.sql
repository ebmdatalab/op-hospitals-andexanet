SELECT 
    scmd_table.year_month,
    scmd_table.vmp_code,
    scmd_table.vmp_name,
    scmd_table.SCMD_quantity,
    scmd_table.SCMD_quantity_basis,
    scmd_table.dose_quantity,
    scmd_table.dose_unit,
    CASE
        WHEN ods.successor_ods_code IS NOT NULL AND ods.successor_ods_code != 'None'
        THEN ods.successor_ods_code
        ELSE ods.ods_code
    END AS ods_code,
    CASE
        WHEN ods.successor_ods_code IS NOT NULL AND ods.successor_ods_code != 'None'
        THEN successor_org.ods_name
        ELSE ods.ods_name
    END AS ods_name,
    ods.region AS region
FROM 
    scmd.dose AS scmd_table
LEFT JOIN 
    scmd.ods_mapped AS ods
ON 
    scmd_table.ods_code = ods.ods_code
LEFT JOIN
    scmd.ods_mapped AS successor_org
ON
    ods.successor_ods_code = successor_org.ods_code
WHERE
    scmd_table.vmp_code in (37454211000001101)
    AND scmd_table.year_month >= '2021-05-01'