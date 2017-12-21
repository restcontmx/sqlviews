SELECT	
    a.mod_date as mod_date,
    a.mod_empl as mod_empl,
    round( a.move_delivery_value, 2 ) as delivery_value,
    round( a.move_tip_value, 2 ) as tip_value,
    a.table_name as table_name,
    a.ticket_count as ticket_count,
    a.move_id as move_id,
    a.ticket_id as ticket_id,
    a.move_cashier as move_cashier,
    a.move_msg as move_msg,
    to_char( a.move_date,  'MM/DD/YYYY HH24:MI:SS' ) as date,
    round( a.grat_cc_tip, 2 ) as grat_cc_tip,
    b.move_deta_move_id as deta_id,
    d.user_login as employee,
    b.man_apprid as man_apprid,
    b.discount_code as discount_code,
    round( b.move_reg_price ) as move_reg_price,
    round( b.move_deta_k * b.move_deta_q ) as costo,
    round( b.move_reg_price - b.move_deta_price, 2) as discount,
    round( b.move_deta_q, 2 ) as qty,
    round( b.move_deta_price, 2 ) as price,
    round( b.move_deta_tax_value, 2 ) as tax1,
    round( b.move_deta_tax2_value, 2 ) as tax2,
    round( b.move_deta_tax3_value, 2 ) as tax3,
    c.item_description as description,
    c.item_id as item_id,
    l.id as location,
    l.location_name as location_name
FROM custom_auth_camaleonadmin ur
    INNER JOIN custom_auth_camaleonadmin_allowed_locations loc
        ON ( loc.camaleonadmin_id = ur.id )
    INNER JOIN custom_auth_location l
    	ON ( l.id = loc.location_id )
    INNER JOIN reports_it_tmove a
        ON ( a.location = loc.location_id )
    INNER JOIN reports_it_tdetamove b
        ON ( a.move_id = b.move_deta_move_id AND a.location = b.location )
    INNER JOIN reports_it_titem c
        ON ( b.move_deta_item_id = c.item_id AND b.location = c.location )
    INNER JOIN custom_auth_it_tuser d
        ON ( a.move_host = d.user_id AND d.location = a.location )
WHERE 	( ur.user_id = 17 )
    AND ( a.move_date BETWEEN '12/01/2017' AND '12/08/2017') 
    AND ( a.move_oper_id = 2 )
    AND ( b.subitem_of = 0 )
    AND ( b.move_reg_price <> 0 )
    AND ( b.discount_code <> '' )
    AND ( ( b.move_reg_price - b.move_deta_price ) > 0 )
LIMIT 3 OFFSET 0