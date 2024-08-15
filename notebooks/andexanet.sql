SELECT 
    scmd_table.year_month,
    scmd_table.vmp_snomed_code,
    scmd_table.vmp_product_name,
    scmd_table.total_quanity_in_vmp_unit,
    scmd_table.unit_of_measure_name,
    ods.ods_code AS ods_code, 
    ods.ods_name AS ods_name,
    ods.region AS region,
FROM 
    scmd.scmd AS scmd_table
LEFT JOIN 
    scmd.ods AS ods
ON 
    scmd_table.ods_code = ods.ods_code
WHERE
    scmd_table.vmp_snomed_code in (37454211000001101)