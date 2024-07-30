view: employee_assessment_skill_concepts {
  sql_table_name: public.employee_assessment_skill_concepts ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: concept {
    type: string
    sql: ${TABLE}.concept ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: employee_assessment_skill_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.employee_assessment_skill_id ;;
  }
  dimension: max_score {
    type: string
    sql: ${TABLE}.max_score ;;
  }
  dimension: normalized_score {
    type: string
    sql: ${TABLE}.normalized_score ;;
  }
  dimension: obtained_score {
    type: string
    sql: ${TABLE}.obtained_score ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  measure: count {
    type: count
    drill_fields: [id, employee_assessment_skills.id]
  }
}
