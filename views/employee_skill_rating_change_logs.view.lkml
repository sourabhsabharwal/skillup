view: employee_skill_rating_change_logs {
  sql_table_name: public.employee_skill_rating_change_logs ;;
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
  dimension_group: assessment_completed {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.assessment_completed_at ;;
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
  dimension: employee_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.employee_id ;;
  }
  dimension: employee_skill_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.employee_skill_id ;;
  }
  dimension: new_proficiency {
    type: string
    sql: ${TABLE}.new_proficiency ;;
  }
  dimension: new_rating {
    type: string
    sql: ${TABLE}.new_rating ;;
  }
  dimension: old_proficiency {
    type: string
    sql: ${TABLE}.old_proficiency ;;
  }
  dimension: old_rating {
    type: string
    sql: ${TABLE}.old_rating ;;
  }
  dimension: platform_company_id {
    type: number
    sql: ${TABLE}.platform_company_id ;;
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
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
	id,
	employee_skills.id,
	employees.id,
	employees.first_name,
	employees.last_name,
	employees.job_role_name,
	skills.id,
	skills.name,
	employee_assessments.id
	]
  }

}
