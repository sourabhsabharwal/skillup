view: employee_certifications {
  sql_table_name: public.employee_certifications ;;
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
  dimension: certification_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.certification_id ;;
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
  dimension_group: issued {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.issued_at ;;
  }
  dimension: platform_company_id {
    type: number
    sql: ${TABLE}.platform_company_id ;;
  }
  dimension: score {
    type: string
    sql: ${TABLE}.score ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  dimension: validation_code {
    type: string
    sql: ${TABLE}.validation_code ;;
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
	certifications.id,
	certifications.name,
	employee_assessments.id
	]
  }

}
