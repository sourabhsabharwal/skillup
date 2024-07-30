view: bookmarks {
  sql_table_name: public.bookmarks ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: active {
    type: string
    sql: ${TABLE}.active ;;
  }
  dimension_group: added {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.added_on ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: employee_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.employee_id ;;
  }
  dimension: entity_id {
    type: string
    sql: ${TABLE}.entity_id ;;
  }
  dimension: entity_type {
    type: string
    sql: ${TABLE}.entity_type ;;
  }
  dimension_group: removed {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.removed_on ;;
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
