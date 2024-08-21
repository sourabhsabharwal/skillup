view: employee_badges {
  sql_table_name: public.employee_badges ;;
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
  dimension: badge_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.badge_id ;;
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
  dimension_group: expiry {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.expiry ;;
  }
  dimension_group: issued {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.issued_at ;;
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
	badges.id,
	employee_assessments.id
	]
  }

}
