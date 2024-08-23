SELECT 
    scmd_table.year_month,
    scmd_table.vmp_code,
    scmd_table.vmp_name,
    scmd_table.SCMD_quantity,
    scmd_table.SCMD_quantity_basis,
    scmd_table.dose_quantity,
    scmd_table.dose_unit,
    ods.ods_code AS ods_code, 
    ods.ods_name AS ods_name,
    ods.region AS region,
FROM 
    scmd.dose AS scmd_table
LEFT JOIN 
    scmd.ods_mapped AS ods
ON 
    scmd_table.ods_code = ods.ods_code
WHERE
    scmd_table.vmp_code in (37454211000001101)