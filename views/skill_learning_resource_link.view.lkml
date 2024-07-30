view: skill_learning_resource_link {
  sql_table_name: public.skill_learning_resource_link ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }
  dimension: link {
    type: string
    sql: ${TABLE}.link ;;
  }
  dimension: skill_learning_module_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.skill_learning_module_id ;;
  }
  dimension: skill_learning_resource_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.skill_learning_resource_id ;;
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
    drill_fields: [id, skill_learning_resource.id, skill_learning_module.id]
  }
}
