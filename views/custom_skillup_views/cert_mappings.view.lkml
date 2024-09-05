view: cert_mappings {

    derived_table: {
      sql: select c.id as cert_id, c.name as cert_name, jr.id as role_id, jr.name as role_name, s.id as skill_id, s.name as skill_name, b.skill_id as skill_id_from_badges,
                    b.proficiency as skill_prof__from_badges, jrs.proficiency as target_prof,
                    e.platform_company_id as emp_company_id, e.email as dev_email
                    from
                    public.employees e
                    join
                    public.job_roles jr
                    on jr. id = e. job_role_id
                    and e.platform_company_id not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841)
                    join
                    public.certifications c
                    on jr.id = c.job_role_id
                    join
                    public.job_role_skills jrs
                    on jrs. job_role_id = jr.id
                    join
                    public.skills s
                    on s.id = jrs. skill_id
                    left join
                    employee_badges eb
                    on eb.employee_id = e.id
                    left join
                    badges b
                    on eb.badge_id = b.id ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: cert_id {
      type: number
      sql: ${TABLE}.cert_id ;;
    }

    dimension: cert_name {
      type: string
      sql: ${TABLE}.cert_name ;;
    }

    dimension: role_id {
      type: string
      sql: ${TABLE}.role_id ;;
    }

    dimension: role_name {
      type: string
      sql: ${TABLE}.role_name ;;
    }

    dimension: skill_id {
      type: string
      sql: ${TABLE}.skill_id ;;
    }

    dimension: skill_name {
      type: string
      sql: ${TABLE}.skill_name ;;
    }

    dimension: skill_id_from_badges {
      type: string
      sql: ${TABLE}.skill_id_from_badges ;;
    }

    dimension: skill_prof__from_badges {
      type: string
      sql: ${TABLE}.skill_prof__from_badges ;;
    }

    dimension: target_prof {
      type: string
      sql: ${TABLE}.target_prof ;;
    }

    dimension: emp_company_id {
      type: number
      sql: ${TABLE}.emp_company_id ;;
    }

    dimension: dev_email {
      type: string
      sql: ${TABLE}.dev_email ;;
    }

    set: detail {
      fields: [
        cert_id,
        cert_name,
        role_id,
        role_name,
        skill_id,
        skill_name,
        skill_id_from_badges,
        skill_prof__from_badges,
        target_prof,
        emp_company_id,
        dev_email
      ]
    }
  }
