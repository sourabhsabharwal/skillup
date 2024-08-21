view: assessed_employees_with_skill_prof {
  derived_table: {
    sql: select
      e.email, e.platform_company_id, ea.max_score, ea.obtained_score,a.name, a.type, b.title as badge, s.name as skill, b.proficiency
      from
      employees e
      inner join
      employee_assessments ea
      on e.id = ea.employee_id
      and e.platform_company_id not in (364822, 327186, 297361, 280588, 280251, 178821, 163391, 118702,280588,271416,371416, 279841,373445,363758)
      inner join
      assessments a
      on a.id = ea.assessment_id
      and
      a.type != 'practice'
      and
      a.type != 'certifying'
      left join
      employee_badges eb
      on ea.id = eb.employee_assessment_id
      left join
      badges b
      on b.id = eb.badge_id
      left join
      skills s
      on s.id = b.skill_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: platform_company_id {
    type: number
    sql: ${TABLE}.platform_company_id ;;
  }

  dimension: max_score {
    type: string
    sql: ${TABLE}.max_score ;;
  }

  dimension: obtained_score {
    type: string
    sql: ${TABLE}.obtained_score ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: badge {
    type: string
    sql: ${TABLE}.badge ;;
  }

  dimension: skill {
    type: string
    sql: ${TABLE}.skill ;;
  }

  dimension: proficiency {
    type: string
    sql: ${TABLE}.proficiency ;;
  }

  set: detail {
    fields: [
      email,
      platform_company_id,
      max_score,
      obtained_score,
      name,
      type,
      badge,
      skill,
      proficiency
    ]
  }
}
