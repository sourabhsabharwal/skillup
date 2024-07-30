view: skill_proficiency_counts {
  sql_table_name: public.skill_proficiency_counts ;;
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
  dimension: count_skill_proficiency_counts {
    type: string
    sql: ${TABLE}.count ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: entity_id {
    type: number
    sql: ${TABLE}.entity_id ;;
  }
  dimension: entity_type {
    type: string
    sql: ${TABLE}.entity_type ;;
  }
  dimension_group: on {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.on_date ;;
  }
  dimension: skill_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.skill_id ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  measure: count {
    type: count
    drill_fields: [id, skills.id, skills.name]
  }
}
