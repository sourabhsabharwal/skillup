view: assessments {
  sql_table_name: public.assessments ;;
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
  dimension: cool_down_period {
    type: number
    sql: ${TABLE}.cool_down_period ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: cutoff {
    type: string
    sql: ${TABLE}.cutoff ;;
  }
  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }
  dimension: meta {
    type: string
    sql: ${TABLE}.meta ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: platform_company_id {
    type: number
    sql: ${TABLE}.platform_company_id ;;
  }
  dimension: questions_count {
    type: number
    sql: ${TABLE}.questions_count ;;
  }
  dimension: recruit_test_id {
    type: number
    sql: ${TABLE}.recruit_test_id ;;
  }
  dimension: recruit_test_unique_id {
    type: string
    sql: ${TABLE}.recruit_test_unique_id ;;
  }
  dimension: retries {
    type: number
    sql: ${TABLE}.retries ;;
  }
  dimension: skill_learning_playlist_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.skill_learning_playlist_id ;;
  }
  dimension: test_owner_user_id {
    type: number
    sql: ${TABLE}.test_owner_user_id ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
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
	name,
	skill_learning_playlist.id,
	assessment_skills.count,
	certifications.count,
	employee_assessment_invites.count,
	employee_assessments.count
	]
  }

}
