view: skills {
  sql_table_name: public.skills ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: metadata {
    type: string
    sql: ${TABLE}.metadata ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: popularity_index {
    type: number
    sql: ${TABLE}.popularity_index ;;
  }
  dimension: published {
    type: string
    sql: ${TABLE}.published ;;
  }
  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
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
	assessment_skills.count,
	badges.count,
	certification_skills.count,
	employee_assessment_skills.count,
	employee_skill_concepts.count,
	employee_skill_progress.count,
	employee_skill_rating_change_logs.count,
	employee_skill_self_ratings.count,
	employee_skills.count,
	job_role_skills.count,
	skill_learning_playlist.count,
	skill_proficiencies_temp.count,
	skill_proficiency_counts.count
	]
  }

}
