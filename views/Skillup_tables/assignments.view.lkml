view: assignments {
  sql_table_name: public.assignments ;;
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
  dimension: assigned_by {
    type: number
    sql: ${TABLE}.assigned_by ;;
  }
  dimension_group: assigned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.assigned_on ;;
  }
  dimension: assigned_to {
    type: number
    sql: ${TABLE}.assigned_to ;;
  }
  dimension_group: completed {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.completed_on ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: due {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.due_date ;;
  }
  dimension: entity_id {
    type: string
    sql: ${TABLE}.entity_id ;;
  }
  dimension: entity_type {
    type: string
    sql: ${TABLE}.entity_type ;;
  }
  dimension: metadata {
    type: string
    sql: ${TABLE}.metadata ;;
  }
  dimension: proficiency {
    type: string
    sql: ${TABLE}.proficiency ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
