view: job_roles {
  sql_table_name: public.job_roles ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension: job_family_id {
    type: string
    sql: ${TABLE}.job_family_id ;;
  }
  dimension: metadata {
    type: string
    sql: ${TABLE}.metadata ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: platform_company_id {
    type: number
    sql: ${TABLE}.platform_company_id ;;
  }
  dimension: published {
    type: string
    sql: ${TABLE}.published ;;
  }
  dimension: standard {
    type: string
    sql: ${TABLE}.standard ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name, certifications.count, employees.count, job_role_skills.count]
  }
}
