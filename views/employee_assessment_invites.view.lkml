view: employee_assessment_invites {
  sql_table_name: public.employee_assessment_invites ;;
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
  dimension: assessment_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.assessment_id ;;
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
  dimension: invite_url {
    type: string
    sql: ${TABLE}.invite_url ;;
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
	assessments.id,
	assessments.name
	]
  }

}
