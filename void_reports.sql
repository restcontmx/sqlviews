DROP MATERIALIZED VIEW void_reports
CREATE MATERIALIZED VIEW void_reports as 
	SELECT
        a.location as location,
        a.move_date as move_date,
        a.move_oper_id as move_oper_id,
        b.move_deta_q as move_deta_q,
        b.move_deta_price as move_deta_price,
        b.move_deta_tax_value as move_deta_tax_value,
        b.move_deta_tax2_value as move_deta_tax2_value,
        b.move_deta_tax3_value as move_deta_tax3_value,
        b.move_deta_ori_q as move_deta_ori_q
    FROM
		reports_it_tmove a
    INNER JOIN reports_it_tdetamove b
        ON ( a.move_id = b.move_deta_move_id AND a.location = b.location )
    WHERE a.move_oper_id = 4
    ORDER BY a.move_date DESC;
    
    CREATE INDEX idx_void_reports_location ON void_reports ( location );
    CREATE INDEX idx_void_reports_move_date ON void_reports ( move_date )