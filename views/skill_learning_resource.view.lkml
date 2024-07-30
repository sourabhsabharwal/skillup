view: skill_learning_resource {
  sql_table_name: public.skill_learning_resource ;;
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
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }
  dimension: skill_learning_module_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.skill_learning_module_id ;;
  }
  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  measure: count {
    type: count
    drill_fields: [id, skill_learning_module.id, employee_skill_learning_playlist_activity.count, skill_learning_resource_link.count]
  }
}
