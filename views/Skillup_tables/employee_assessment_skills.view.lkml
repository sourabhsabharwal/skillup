view: employee_assessment_skills {
  sql_table_name: public.employee_assessment_skills ;;
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
  dimension: employee_assessment_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.employee_assessment_id ;;
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
    drill_fields: [id, employee_assessments.id, skills.id, skills.name, employee_assessment_skill_concepts.count]
  }
}
