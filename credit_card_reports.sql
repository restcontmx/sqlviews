CREATE MATERIALIZED VIEW credit_card_reports as
    SELECT 
        s.movment as "movement", 
        ticket_count as ticket_count, 
        location as location
    FROM	reports_it_tmove t, 
            unnest(string_to_array(t.move_refer, '.')) s(movment)
    WHERE 	move_refer <> ''