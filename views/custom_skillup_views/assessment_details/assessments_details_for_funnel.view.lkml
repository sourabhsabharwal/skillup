view: assessments_details_for_funnel {
      derived_table: {
      sql: select
a.recruit_test_id as test_id,
a.id as assessment_id,
a.name as assessment_name,
a.type as assessment_type,
ra.email as emp_email,
e.email as email,
json_extract_path_text(e.meta, 'onboarding_status' , true) as onboarding_status,
ra.id as attempt_id,
e.platform_company_id as company_id,
rc.name as company_name,
ea.max_score,
ea.obtained_score,
eb.id as emp_badge_id,
ec.id as emp_cert_id,
ea.id as emp_assessment_id

from employees e

left join  recruit_rs_replica.recruit.recruit_attempts ra
              on e.email = ra.email
              and e.platform_user_uuid is not null
              and e.user_role = 'individual'
              and e.platform_company_id not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841)

inner join assessments a
              on a.recruit_test_id = abs(ra.tid)

inner join recruit_rs_replica.recruit.recruit_companies rc
              on rc.id = e.platform_company_id

left join   employee_assessments ea
              on ea.recruit_attempt_id = ra.id
              and ea.assessment_id = a.id

left join   employee_badges eb
              on ea.id = eb.employee_assessment_id
              and eb.employee_id = ea.employee_id

left join   employee_certifications ec
              on ea.id = ec.employee_assessment_id
              and ec.employee_id = ea.employee_id
;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: assessment_id {
      type: number
      sql: ${TABLE}.assessment_id ;;
    }

  dimension: emp_badge_id {
    type: number
    sql: ${TABLE}.emp_badge_id ;;
  }

  dimension: emp_cert_id {
    type: number
    sql: ${TABLE}.emp_cert_id ;;
  }

  dimension: emp_assessment_id {
    type: number
    sql: ${TABLE}.emp_assessment_id ;;
  }

    dimension: test_id {
      type: number
      sql: ${TABLE}.test_id ;;
    }

    dimension: assessment_name {
      type: string
      sql: ${TABLE}.assessment_name ;;
    }


  dimension: onboarding_status {
    type: string
    sql: ${TABLE}.onboarding_status ;;
  }

    dimension: assessment_type {
      type: string
      sql: ${TABLE}.assessment_type ;;
    }

    dimension: emp_email {
      type: string
      sql: ${TABLE}.emp_email ;;
    }


  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

    dimension: attempt_id {
      type: number
      sql: ${TABLE}.attempt_id ;;
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
        onboarding_status,
        emp_badge_id,
        emp_cert_id,
        email,
        emp_assessment_id
      ]
    }
  }
