view: practice_assessments_data {
      derived_table: {
      sql: select a.id as assessment_id, a.recruit_test_id as test_id, a.name as assessment_name, a.type as assessment_type,
              ra.email as emp_email, ra.id as attempt_id, e.platform_company_id as company_id, rc.name as company_name,
              ea.max_score,ea.obtained_score,
              case when max_score is null then 0 else 1 end as test_submitted
              from
              assessments a
              join
              recruit_rs_replica.recruit.recruit_attempts ra
              on a.recruit_test_id = abs(ra.tid)
              and
              a.type = 'practice'
              join
              employees e
              on e.email = ra.email
              and e.platform_company_id not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841)
              join
              recruit_rs_replica.recruit.recruit_companies rc
              on rc.id = e.platform_company_id
              and e.platform_user_uuid is not null
              and e.user_role = 'individual'
              left join
              employee_assessments ea
              on ea.recruit_attempt_id = ra.id
              and ea.assessment_id = a.id ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: assessment_id {
      type: number
      sql: ${TABLE}.assessment_id ;;
    }

  dimension: test_submitted {
    type: number
    sql: ${TABLE}.test_submitted ;;
  }

  dimension: attempt_id {
    type: number
    sql: ${TABLE}.attempt_id ;;
  }


    dimension: test_id {
      type: number
      sql: ${TABLE}.test_id ;;
    }

    dimension: assessment_name {
      type: string
      sql: ${TABLE}.assessment_name ;;
    }

    dimension: assessment_type {
      type: string
      sql: ${TABLE}.assessment_type ;;
    }

    dimension: emp_email {
      type: string
      sql: ${TABLE}.emp_email ;;
    }

    dimension: company_id {
      type: number
      sql: ${TABLE}.company_id ;;
    }

    dimension: company_name {
      type: string
      sql: ${TABLE}.company_name ;;
    }

    dimension: max_score {
      type: string
      sql: ${TABLE}.max_score ;;
    }

    dimension: obtained_score {
      type: string
      sql: ${TABLE}.obtained_score ;;
    }


    set: detail {
      fields: [
        assessment_id,
        test_id,
        assessment_name,
        assessment_type,
        emp_email,
        attempt_id,
        company_id,
        company_name,
        max_score,
        obtained_score,
        test_submitted
      ]
    }
  }
