CREATE MATERIALIZED VIEW discounts_reports AS 
	SELECT
        a.location as location,
        a.move_date as move_date,
        a.move_oper_id as move_oper_id,
        b.move_deta_q as move_deta_q,
        b.discount_code as discount_code,
        b.move_reg_price as move_reg_price,
        b.move_deta_price as move_deta_price,
        b.subitem_of as subitem_of
    FROM
		reports_it_tmove a
    INNER JOIN reports_it_tdetamove b
        ON ( a.move_id = b.move_deta_move_id AND a.location = b.location ) 
    ORDER BY a.move_date DESC;
    
    CREATE INDEX idx_discounts_reports_location ON discounts_reports ( location );
    CREATE INDEX idx_discounts_reports_move_date ON discounts_reports ( move_date )