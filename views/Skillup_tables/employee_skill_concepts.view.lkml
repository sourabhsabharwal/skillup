view: employee_skill_concepts {
  sql_table_name: public.employee_skill_concepts ;;
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
  dimension: employee_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.employee_id ;;
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
	skills.name
	]
  }

}
