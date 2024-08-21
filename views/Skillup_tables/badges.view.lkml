view: badges {
  sql_table_name: public.badges ;;
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
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: expiry_ttl {
    type: number
    sql: ${TABLE}.expiry_ttl ;;
  }
  dimension: image_urls {
    type: string
    sql: ${TABLE}.image_urls ;;
  }
  dimension: metadata {
    type: string
    sql: ${TABLE}.metadata ;;
  }
  dimension: priority {
    type: number
    sql: ${TABLE}.priority ;;
  }
  dimension: proficiency {
    type: string
    sql: ${TABLE}.proficiency ;;
  }
  dimension: proficiency_id {
    type: string
    sql: ${TABLE}.proficiency_id ;;
  }
  dimension: skill_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.skill_id ;;
  }
  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  measure: count {
    type: count
    drill_fields: [id, skills.id, skills.name, employee_badges.count]
  }
}
