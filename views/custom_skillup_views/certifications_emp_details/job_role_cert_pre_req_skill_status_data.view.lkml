view: job_role_cert_pre_req_skill_status_data {

    derived_table: {
      sql: with job_role_cert_data as
              (select
                              e.id as emp_id,
                              e.email,
                              e.platform_company_id as company_id,
                              c.id as cert_id,
                              c.name as cert_name,
                              cert_pre_skill_mapping.prerequisite_skill_id,
                              s.name as skill,
                              s.id as skill_id,
                              eb.employee_id,
                              jrs.proficiency as target_prof,
                              b.title,
                              b.proficiency as achieved_prof,
                              case when target_prof = 'beginner' and (achieved_prof = 'beginner' or achieved_prof = 'intermediate' or achieved_prof = 'expert') then 1
                              when target_prof = 'intermediate' and (achieved_prof = 'intermediate' or achieved_prof = 'expert') then 1
                              when achieved_prof = 'expert' then 1
                              else 0 end as passed
                              from

                              public.employees e

                              join
                              public.job_roles jr
                              on jr. id = e. job_role_id
                              and e.platform_company_id not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841)
                              and e.platform_company_id = 366340

                              join
                              public.certifications c
                              on jr.id = c.job_role_id
                              and c.platform_company_id = e.platform_company_id

                             join
                              (with  certification_pre_req_skill_mapping as
                                  (
                                  select
                                  id as cert_id,
                                  name as cert_name,
                                  active,
                                  job_role_id,
                                  platform_company_id as cert_company,
                                  json_extract_path_text(metadata, 'prerequisite_skill_ids', true) as prerequisite_skills_ids,
                                  seq.n,
                                  json_array_length(json_extract_path_text(metadata, 'prerequisite_skill_ids', true), true) as no_of_prerequisite_skills,
                                  json_extract_array_element_text(json_extract_path_text(metadata, 'prerequisite_skill_ids', true),seq.n, true) as  prerequisite_skill_id
                            from certifications
                            inner join
                            (select row_number() over(order by true)::integer - 1 as n from certifications limit 20) seq
                            on seq.n <= json_array_length(json_extract_path_text(metadata, 'prerequisite_skill_ids', true), true) - 1
                            )

                            select distinct cert_id,cert_name,active, job_role_id,cert_company,prerequisite_skills_ids, prerequisite_skill_id
                            from
                            certification_pre_req_skill_mapping
                            where
                            cert_company not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841)) cert_pre_skill_mapping
                            on cert_pre_skill_mapping.cert_id = c.id

                              left join
                              public.job_role_skills jrs
                              on jrs.skill_id = cert_pre_skill_mapping.prerequisite_skill_id
                              and jrs.job_role_id = c.job_role_id

                              join
                              public.skills s
                              on s.id = jrs.skill_id

                              left join
                              employee_badges eb
                              on eb.employee_id = e.id

                              left join
                              badges b
                              on eb.badge_id = b.id
              )
                            select
                            emp_id,
                            email,
                            company_id,
                            cert_id,
                            cert_name,
                            skill,
                            employee_id,
                            target_prof, case when max(passed) = 1 then true else false end as prof_achieved
                            from job_role_cert_data
                            group by 1,2,3,4,5,6,7,8 ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: emp_id {
      type: number
      sql: ${TABLE}.emp_id ;;
    }

    dimension: email {
      type: string
      sql: ${TABLE}.email ;;
    }

    dimension: company_id {
      type: number
      sql: ${TABLE}.company_id ;;
    }

    dimension: cert_id {
      type: number
      sql: ${TABLE}.cert_id ;;
    }

    dimension: cert_name {
      type: string
      sql: ${TABLE}.cert_name ;;
    }

    dimension: skill {
      type: string
      sql: ${TABLE}.skill ;;
    }

    dimension: employee_id {
      type: number
      sql: ${TABLE}.employee_id ;;
    }

    dimension: target_prof {
      type: string
      sql: ${TABLE}.target_prof ;;
    }

    dimension: prof_achieved {
      type: string
      sql: ${TABLE}.prof_achieved ;;
    }

    set: detail {
      fields: [
        emp_id,
        email,
        company_id,
        cert_id,
        cert_name,
        skill,
        employee_id,
        target_prof,
        prof_achieved
      ]
    }
  }
