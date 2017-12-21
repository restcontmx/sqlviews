CREATE MATERIALIZED VIEW ticket_count_reports AS 
    SELECT cust.company_id,
        cust.company_name,
        a.note_credit,
        a.move_cash_value,
        a.move_credit_value,
        a.move_debit_value,
        a.move_check_value,
        a.move_stamp_value,
        a.move_onaccount_value,
        a.move_crnote_value,
        a.move_gift_value,
        a.move_tip_value,
        a.grat_cc_tip,
        a.move_refer,
        a.docu_type_id,
        a.move_fiscal_date,
        a.money_conv,
        a.move_wic_value,
        a.move_regi_name,
        a.ticket_count,
        b.move_deta_move_id,
        a.move_oper_id,
        a.move_date,
        cust.taxexemptno,
        cust.ss_no,
        cust.cust_name,
        cust.cust_last,
        a.move_delivery_value,
        b.move_deta_k,
        b.move_deta_price,
        b.move_deta_q,
        b.move_deta_tax_value,
        b.move_deta_tax2_value,
        b.move_deta_tax3_value,
        a.location,
        b.returned_id,
        c.item_id,
        c.item_description,
        d.cate_id,
        d.cate_name,
        a.notacr_code,
        cust.cust_id,
        a.move_id,
        c.item_unit_id
    FROM reports_it_tmove a
        INNER JOIN reports_it_tdetamove b ON b.move_deta_move_id = a.move_id AND b.location = a.location
        INNER JOIN reports_it_titem c ON b.move_deta_item_id::text = c.item_id::text AND b.location = c.location
        INNER JOIN reports_it_tcategory d ON c.item_cate_id = d.cate_id AND c.location = d.location
        INNER JOIN reports_it_taccount acc ON acc.acco_id = c.item_inco_account_id AND acc.location = c.location
        INNER JOIN reports_it_taccotype acc_t ON acc_t.acty_id = acc.acco_type_id AND acc_t.location = acc.location
        INNER JOIN reports_it_taccotypegeneral acc_t_g ON acc_t.acco_gen_id = acc_t_g.gen_account AND acc_t.location = acc_t_g.location
        LEFT JOIN facturacion_fl_tcustomer cust ON a.cust_id = cust.cust_id AND a.location = cust.location
    WHERE a.ticket_count IS NOT NULL AND a.ticket_count::text <> ''::text AND acc_t_g.gen_account = 2 AND b.modi = 0
    ORDER BY a.move_date DESC;
        
    CREATE INDEX idx_ticket_count_reports_location ON ticket_count_reports ( location );
    CREATE INDEX idx_ticket_count_reports_move_id ON ticket_count_reports ( move_id );
    CREATE INDEX idx_ticket_count_reports_cate_id ON ticket_count_reports ( cate_id );
    CREATE INDEX idx_ticket_count_reports_item_id ON ticket_count_reports ( item_id );
    CREATE INDEX idx_ticket_count_reports_move_date ON ticket_count_reports ( move_date );