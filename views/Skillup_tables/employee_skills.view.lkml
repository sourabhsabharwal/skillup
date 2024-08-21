view: employee_skills {
  sql_table_name: public.employee_skills ;;
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
  dimension: employee_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.employee_id ;;
  }
  dimension: platform_company_id {
    type: number
    sql: ${TABLE}.platform_company_id ;;
  }
  dimension: proficiency {
    type: string
    sql: ${TABLE}.proficiency ;;
  }
  dimension: proficiency_id {
    type: string
    sql: ${TABLE}.proficiency_id ;;
  }
  dimension: rating {
    type: string
    sql: ${TABLE}.rating ;;
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
	employees.id,
	employees.first_name,
	employees.last_name,
	employees.job_role_name,
	skills.id,
	skills.name,
	employee_skill_rating_change_logs.count
	]
  }

}
