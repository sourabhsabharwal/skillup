view: certification_skills {
  sql_table_name: public.certification_skills ;;
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
  dimension: prerequisite {
    type: string
    sql: ${TABLE}.prerequisite ;;
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
    drill_fields: [id, certifications.id, certifications.name, skills.id, skills.name]
  }
}
