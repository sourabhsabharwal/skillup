view: job_role_skills {
  sql_table_name: public.job_role_skills ;;

  dimension: job_role_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.job_role_id ;;
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
  measure: count {
    type: count
    drill_fields: [job_roles.id, job_roles.name, skills.id, skills.name]
  }
}
