SELECT 
    a.cate_id as id,
    a.cate_id as cate_id,
    a.cate_name as cate_name,
    a.location as location,
    l.location_name as location_name,
    SUM( a.move_deta_q ) as qty,
    round( SUM( a.move_deta_q * a.move_deta_price ), 2 ) as total,
    round( SUM( ( a.move_deta_q * a.move_deta_price ) - a.move_deta_tax_value - a.move_deta_tax2_value - a.move_deta_tax3_value ), 2 ) as vta_neta,
    round( SUM( a.move_deta_tax_value ), 2 ) as tax1,
    round( SUM( a.move_deta_tax2_value ), 2 ) as tax2,
    round( SUM( a.move_deta_tax3_value ), 2 ) as tax3
FROM  custom_auth_camaleonadmin ur
    INNER JOIN custom_auth_camaleonadmin_allowed_locations loc
        ON ( loc.camaleonadmin_id = ur.id )
    INNER JOIN custom_auth_location l
        ON ( l.id = loc.location_id )
    INNER JOIN cate_reports a
        ON ( a.location = l.id )
WHERE   ( ur.user_id = 17 )
    AND ( a.move_oper_id = 2 )
    AND ( a.move_date BETWEEN '12/01/2017' AND '12/21/2017')
    AND ( a.item_inco_account_id = 1 )
GROUP BY a.cate_id, a.location, a.cate_name, l.location_name