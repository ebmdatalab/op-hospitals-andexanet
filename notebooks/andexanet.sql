SELECT 
    scmd_norm.year_month,
    scmd_norm.indicative_cost,
    scmd_norm.quantity,
    scmd_norm.uom,
    ods.ods_code AS ods_code, 
    ods.ods_name AS ods_name,
    ods.region AS region,
    vmp_full.id AS vmp_code,
    vmp_full.vtm,
    vtm.nm AS vtm_name,
    vmp_full.df_ind,
    vmp_full.udfs,
    vmp_full.udfs_uom,
    vmp_full.unit_dose_uom,
    vmp_full.dform_form,
    vmp_full.nm AS vmp_name,
    vpi.ing,
    vpi.strnt_nmrtr_val,
    vpi.strnt_dnmtr_val,
    nmrtr_uom.descr AS strnt_nmrtr_uom_name,
    dnmtr_uom.descr AS strnt_dnmtr_uom_name,
    ing.nm AS ing_nm,
    droute_descr.descr AS droute_description
FROM 
    (SELECT
      scmd.year_month,
      scmd.ods_code,
      coalesce(vmp.id, scmd.vmp_snomed_code) as vmp_code,
      scmd.vmp_product_name as vmp_name,
      scmd.unit_of_measure_name as uom,
      scmd.total_quanity_in_vmp_unit as quantity,
      scmd.indicative_cost
    FROM scmd.scmd
    LEFT JOIN dmd.vmp
      ON scmd.vmp_snomed_code = vmp.vpidprev) AS scmd_norm
LEFT JOIN 
    scmd.ods AS ods
ON 
    scmd_norm.ods_code = ods.ods_code
LEFT JOIN 
    dmd.vmp_full AS vmp_full
ON 
    scmd_norm.vmp_code = vmp_full.id
LEFT JOIN
    dmd.vtm AS vtm
ON
    vmp_full.vtm = vtm.id
LEFT JOIN 
    dmd.vpi AS vpi 
ON 
    scmd_norm.vmp_code = vpi.vmp
LEFT JOIN 
    dmd.unitofmeasure AS nmrtr_uom
ON 
    vpi.strnt_nmrtr_uom = nmrtr_uom.cd
LEFT JOIN 
    dmd.unitofmeasure AS dnmtr_uom
ON 
    vpi.strnt_dnmtr_uom = dnmtr_uom.cd
LEFT JOIN
    dmd.ing as ing
ON 
    vpi.ing = ing.id
LEFT JOIN
    dmd.droute AS droute
ON 
    vmp_full.id = droute.vmp
LEFT JOIN
    dmd.route AS droute_descr
ON 
    droute.route = droute_descr.cd
WHERE
    vtm.id IN (783692006)