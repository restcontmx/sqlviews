CREATE MATERIALIZED VIEW item_reports AS
	SELECT
    	c.item_id,	c.item_description, 
        c.location,
        d.cate_id, 	d.cate_name, 
        e.class_id, e.class_name,
        f.fam_id, 	f.fam_name,
        g.depa_id,	g.depa_name,
    	a.move_oper_id,
        c.item_inco_account_id,
        c.item_account_id,
        a.move_date,
        b.move_deta_tax_value,
        b.move_deta_tax2_value,
        b.move_deta_tax3_value,
        b.move_deta_q,
        b.move_deta_price
    FROM	reports_it_tmove a
        INNER JOIN reports_it_tdetamove b
            ON ( a.move_id = b.move_deta_move_id AND a.location = b.location ) 
        INNER JOIN reports_it_titem c
            ON ( b.move_deta_item_id = c.item_id AND b.location = c.location )
        INNER JOIN reports_it_tcategory d
            ON ( c.item_cate_id = d.cate_id AND c.location = d.location )
        INNER JOIN reports_it_titemclass e
            ON ( c.item_class_id = e.class_id AND c.location = e.location )
        LEFT JOIN reports_it_tfamily f
            ON ( c.item_fam_id = f.fam_id AND c.location = f.location )
        LEFT JOIN reports_it_tdepartment g
            ON ( c.item_depa_id = g.depa_id AND c.location = g.location )
    WHERE b.move_deta_q > 0::numeric
  	ORDER BY a.move_date DESC;
    
    CREATE INDEX idx_item_reports_move_date ON item_reports ( move_date );
    CREATE INDEX idx_item_reports_location ON item_reports ( location );