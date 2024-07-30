view: skill_proficiencies_temp {
  sql_table_name: public.skill_proficiencies_temp ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: hackerrank_slug {
    type: string
    sql: ${TABLE}.hackerrank_slug ;;
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
    drill_fields: [id, skills.id, skills.name]
  }
}
