view: assessment_skills {
  sql_table_name: public.assessment_skills ;;
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
  dimension: cutoff {
    type: string
    sql: ${TABLE}.cutoff ;;
  }
  dimension: platform_company_id {
    type: number
    sql: ${TABLE}.platform_company_id ;;
  }
  dimension: proficiency {
    type: string
    sql: ${TABLE}.proficiency ;;
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
    drill_fields: [id, assessments.id, assessments.name, skills.id, skills.name]
  }
}
