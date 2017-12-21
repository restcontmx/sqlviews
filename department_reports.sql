CREATE MATERIALIZED VIEW depa_reports AS 
	SELECT
    	d.depa_id as id,
        d.depa_id as depa_id,
        d.depa_name as depa_name,
        a.location as location,
        a.move_date as move_date,
        a.move_oper_id as move_oper_id,
        b.move_deta_q as move_deta_q,
        b.move_deta_price as move_deta_price,
        b.move_deta_tax_value as move_deta_tax_value,
        b.move_deta_tax2_value as move_deta_tax2_value,
        b.move_deta_tax3_value as move_deta_tax3_value
    FROM
		reports_it_tmove a
    INNER JOIN reports_it_tdetamove b
        ON ( a.move_id = b.move_deta_move_id AND a.location = b.location ) 
    INNER JOIN reports_it_titem c
        ON ( b.move_deta_item_id = c.item_id AND b.location = c.location )
    INNER JOIN reports_it_tdepartment d
        ON ( d.depa_id = c.item_depa_id AND d.location = c.location )
    WHERE ( b.move_deta_price * b.move_deta_q ) > 0
    ORDER BY ( b.move_deta_price * b.move_deta_q ) DESC;
    
    CREATE INDEX idx_depa_reports_location ON depa_reports ( location );
    CREATE INDEX idx_depa_reports_move_date ON depa_reports ( move_date )
