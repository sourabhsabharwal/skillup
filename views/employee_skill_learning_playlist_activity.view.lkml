view: employee_skill_learning_playlist_activity {
  sql_table_name: public.employee_skill_learning_playlist_activity ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: activity {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.activity_time ;;
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
  dimension: skill_learning_module_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.skill_learning_module_id ;;
  }
  dimension: skill_learning_playlist_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.skill_learning_playlist_id ;;
  }
  dimension: skill_learning_resource_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.skill_learning_resource_id ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
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
	skill_learning_playlist.id,
	skill_learning_module.id,
	skill_learning_resource.id
	]
  }

}
