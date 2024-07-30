view: email_templates {
  sql_table_name: public.email_templates ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: email_body {
    type: string
    sql: ${TABLE}.email_body ;;
  }
  dimension: email_footer {
    type: string
    sql: ${TABLE}.email_footer ;;
  }
  dimension: email_header {
    type: string
    sql: ${TABLE}.email_header ;;
  }
  dimension: employee_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.employee_id ;;
  }
  dimension: full_email_template {
    type: string
    sql: ${TABLE}.full_email_template ;;
  }
  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  measure: count {
    type: count
    drill_fields: [id, employees.id, employees.first_name, employees.last_name, employees.job_role_name]
  }
}
