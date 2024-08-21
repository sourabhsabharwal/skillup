view: skillup_candidates_data {
      derived_table: {
      sql: select e.platform_company_id as company, rc.name as company_name, e.email as employee_email, recruit_test_id as test_id, rt.name as test_name, recruit_attempt_id as attempt_id, a.type as test_type
              from
              skillup_rs_replica.employee_assessments ea
              join
              skillup_rs_replica.assessments a
              on a.id = ea.assessment_id
              --and a.type != 'practice'
              join
              recruit_rs_replica.recruit.recruit_tests rt
              on rt.id = a.recruit_test_id
              join
              skillup_rs_replica.employees e
              on e.id = ea.employee_id
              and e.platform_company_id not in (364822, 327186, 297361, 280588, 280251, 178821, 163391, 118702,280588,271416)
              join
              recruit_rs_replica.recruit.recruit_companies rc
              on rc.id = e.platform_company_id ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: company {
      type: number
      sql: ${TABLE}.company ;;
    }

    dimension: company_name {
      type: string
      sql: ${TABLE}.company_name ;;
    }

    dimension: employee_email {
      type: string
      sql: ${TABLE}.employee_email ;;
    }

    dimension: test_id {
      type: number
      sql: ${TABLE}.test_id ;;
    }

    dimension: test_name {
      type: string
      sql: ${TABLE}.test_name ;;
    }

    dimension: attempt_id {
      type: number
      sql: ${TABLE}.attempt_id ;;
    }

    dimension: test_type {
      type: string
      sql: ${TABLE}.test_type ;;
    }

    set: detail {
      fields: [
        company,
        company_name,
        employee_email,
        test_id,
        test_name,
        attempt_id,
        test_type
      ]
    }
  }
