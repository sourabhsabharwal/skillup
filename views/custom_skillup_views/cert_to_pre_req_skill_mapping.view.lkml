view: cert_to_pre_req_skill_mapping {

    derived_table: {
      sql: with  certification_pre_req_skills as
                  (
                  select
                  id as certificate_id,
                  name as certificate_name,
                  job_role_id,
                  platform_company_id as cert_company_id,
                  created_at ,
                  seq.n,
                  json_array_length(json_extract_path_text(metadata,'prerequisite_skill_ids',true), true) as no_of_pre_req_skills,
                  --json_extract_path_text(json_extract_array_element_text(cq.skills_obj,seq.n, true),'name', true) as skill,
                  --json_extract_path_text(json_extract_path_text(custom,'skills',true),seq.n, true) as skill_name
                  json_extract_array_element_text(json_extract_path_text(metadata,'prerequisite_skill_ids',true),seq.n, true) as pre_req_skill
            from public.certifications
            inner join
            (select row_number() over(order by true)::integer - 1 as n from public.certifications limit 20) seq
            on seq.n <= json_array_length(json_extract_path_text(metadata,'prerequisite_skill_ids',true), true) - 1
            )

            select distinct prs.certificate_id,prs.certificate_name, prs.cert_company_id, prs.created_at,prs.no_of_pre_req_skills,prs.pre_req_skill, s.name
            from
            certification_pre_req_skills prs
            left join
            public.skills s
            on prs.pre_req_skill = s.id ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: certificate_id {
      type: number
      sql: ${TABLE}.certificate_id ;;
    }

  dimension: cert_company_id {
    type: number
    sql: ${TABLE}.cert_company_id ;;
  }

    dimension: certificate_name {
      type: string
      sql: ${TABLE}.certificate_name ;;
    }

    dimension_group: created_at {
      type: time
      sql: ${TABLE}.created_at ;;
    }

    dimension: no_of_pre_req_skills {
      type: number
      sql: ${TABLE}.no_of_pre_req_skills ;;
    }

    dimension: pre_req_skill {
      type: string
      sql: ${TABLE}.pre_req_skill ;;
    }

    dimension: name {
      type: string
      sql: ${TABLE}.name ;;
    }

    set: detail {
      fields: [
        certificate_id,
        certificate_name,
        cert_company_id,
        created_at_time,
        no_of_pre_req_skills,
        pre_req_skill,
        name
      ]
    }
  }
