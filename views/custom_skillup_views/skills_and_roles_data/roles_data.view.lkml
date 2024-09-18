view: roles_data {
    derived_table: {
      sql: select
                        e.email, e.id as e_id, e.platform_company_id, ea.id as ea_id, ea.max_score, ea.obtained_score,a.name, a.type, c.name as certificate, jr1.name as job_role_name_asmt, jr.name as job_role_name_ernd, ec.id as ec_id

                          from
                          employees e

                          inner join
                          employee_assessments ea
                          on e.id = ea.employee_id
                          and e.platform_company_id not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841)
                          and e.platform_user_uuid is not null
                          and e.user_role = 'individual'

                          join
                          assessments a

                          join
                          certifications c1
                          on c1.assessment_id = a.id

                          join
                          job_roles jr1
                          on jr1.id = c1.job_role_id

                          on a.id = ea.assessment_id
                          and
                          a.type != 'practice' and a.type != 'badging'
                          left join
                          public.employee_certifications ec
                          on ea.id = ec.employee_assessment_id
                          left join
                          public.certifications c
                          on c.id = ec. certification_id
                          left join
                          public.job_roles jr
                          on jr.id = c.job_role_id ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: email {
      type: string
      sql: ${TABLE}.email ;;
    }

    dimension: e_id {
      type: number
      sql: ${TABLE}.e_id ;;
    }

    dimension: platform_company_id {
      type: number
      sql: ${TABLE}.platform_company_id ;;
    }

    dimension: ea_id {
      type: number
      sql: ${TABLE}.ea_id ;;
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

    dimension: certificate {
      type: string
      sql: ${TABLE}.certificate ;;
    }

    dimension: job_role_name_asmt {
      type: string
      sql: ${TABLE}.job_role_name_asmt ;;
    }

    dimension: job_role_name_ernd {
      type: string
      sql: ${TABLE}.job_role_name_ernd ;;
    }

    dimension: ec_id {
      type: number
      sql: ${TABLE}.ec_id ;;
    }

    set: detail {
      fields: [
        email,
        e_id,
        platform_company_id,
        ea_id,
        max_score,
        obtained_score,
        name,
        type,
        certificate,
        job_role_name_asmt,
        job_role_name_ernd,
        ec_id
      ]
    }
  }
