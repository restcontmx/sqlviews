CREATE MATERIALIZED VIEW fam_reports AS 
	SELECT
    	d.fam_id as id,
        d.fam_id as fam_id,
        d.fam_name as fam_name,
        a.location as location,
        a.move_date as move_date,
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
    INNER JOIN reports_it_tfamily d
        ON ( d.fam_id = c.item_fam_id AND d.location = c.location )
    WHERE b.move_deta_q > 0
    ORDER BY ( b.move_deta_price * b.move_deta_q ) DESC;
    
    CREATE INDEX idx_fam_reports_location ON fam_reports ( location );
    CREATE INDEX idx_fam_reports_move_date ON fam_reports ( move_date )

REFRESH MATERIALIZED VIEW fam_reports;