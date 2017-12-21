CREATE MATERIALIZED VIEW sales_reports AS 
	SELECT
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
    ORDER BY a.move_date DESC;
    
    CREATE INDEX idx_sales_reports_location ON sales_reports ( location );
    CREATE INDEX idx_sales_reports_move_date ON sales_reports ( move_date )