view: employee_assessments {
  sql_table_name: public.employee_assessments ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: assessment_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.assessment_id ;;
  }
  dimension_group: completed {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.completed_at ;;
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
  dimension: recruit_attempt_id {
    type: number
    sql: ${TABLE}.recruit_attempt_id ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: assessment_name {
    type: string
    sql: ${assessments.name} ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: assessments_count {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [id,employee_id,assessment_id,assessment_name]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  assessments.id,
  assessments.name,
  employees.id,
  employees.first_name,
  employees.last_name,
  employees.job_role_name,
  employee_assessment_skills.count,
  employee_badges.count,
  employee_certifications.count,
  employee_skill_rating_change_logs.count
  ]
  }

}
