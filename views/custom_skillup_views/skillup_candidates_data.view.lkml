view: skillup_candidates_data {
derived_table: {
  sql: select e.platform_company_id as company_id, rc.name as company_name, e.email as employee_email, m.email as manager_email, recruit_test_id as test_id, rt.name as test_name, s.name as skill_name, asl.proficiency as proficiency_name, recruit_attempt_id as attempt_id, ea.created_at as attempt_statrttime, a.type as test_type
                          from
                          employee_assessments ea
                          join
                          assessments a
                          on a.id = ea.assessment_id
                          --and a.type != 'practice'
                          join
                          assessment_skills asl
                          on asl. assessment_id = a.id
                          join
                          skills s
                          on s.id = asl.skill_id
                          join
                          recruit_rs_replica.recruit.recruit_tests rt
                          on rt.id = a.recruit_test_id
                          join
                          employees e
                          on e.id = ea.employee_id
                          join
                          employees m
                          on m.id = e.manager_id
                          and e.platform_company_id not in (364822, 327186, 297361, 280588, 280251, 178821, 163391, 118702,280588,271416, 371416)
                          join
                          recruit_rs_replica.recruit.recruit_companies rc
                          on rc.id = e.platform_company_id  ;;
}

measure: count {
  type: count
  drill_fields: [detail*]
}

dimension: company_id {
  type: number
  sql: ${TABLE}.company_id ;;
}

dimension: company_name {
  type: string
  sql: ${TABLE}.company_name ;;
}

dimension: employee_email {
  type: string
  sql: ${TABLE}.employee_email ;;
}

  dimension: manager_email {
    type: string
    sql: ${TABLE}.manager_email;;
}

dimension: test_id {
  type: number
  sql: ${TABLE}.test_id ;;
}

dimension: test_name {
  type: string
  sql: ${TABLE}.test_name ;;
}

dimension: skill_name {
  type: string
  sql: ${TABLE}.skill_name ;;
}

dimension: proficiency_name {
  type: string
  sql: ${TABLE}.proficiency_name ;;
}

dimension: attempt_id {
  type: number
  sql: ${TABLE}.attempt_id ;;
}

dimension_group: attempt_statrttime {
  type: time
  sql: ${TABLE}.attempt_statrttime ;;
}

dimension: test_type {
  type: string
  sql: ${TABLE}.test_type ;;
}

set: detail {
  fields: [
    company_id,
    company_name,
    employee_email,
    test_id,
    test_name,
    skill_name,
    proficiency_name,
    attempt_id,
    attempt_statrttime_time,
    test_type
  ]
}
}
