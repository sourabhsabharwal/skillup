view: awsdms_apply_exceptions {
  sql_table_name: public.awsdms_apply_exceptions ;;

  dimension: error {
    type: string
    sql: ${TABLE}.error ;;
  }
  dimension_group: error {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.error_time ;;
  }
  dimension: statement {
    type: string
    sql: ${TABLE}.statement ;;
  }
  dimension: table_name {
    type: string
    sql: ${TABLE}.table_name ;;
  }
  dimension: table_owner {
    type: string
    sql: ${TABLE}.table_owner ;;
  }
  dimension: task_name {
    type: string
    sql: ${TABLE}.task_name ;;
  }
  measure: count {
    type: count
    drill_fields: [task_name, table_name]
  }
}
