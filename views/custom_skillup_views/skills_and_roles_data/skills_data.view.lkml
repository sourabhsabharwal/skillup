view: skills_data {
    derived_table: {
      sql: select
            e.email, e.id as e_id, e.platform_company_id, ea.id as ea_id, ea.max_score, ea.obtained_score,a.name, a.type, b.title as badge, s.name as asmt_skill, s1.name as ernd_skill, b.proficiency, eb.id as eb_id

            from
            employees e

            join
            employee_assessments ea
            on e.id = ea.employee_id
            and e.platform_company_id not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841)
            and e.platform_user_uuid is not null
            and e.user_role in ('individual', 'manager')

            join
            assessments a
            on a.id = ea.assessment_id
            and
            a.type = 'badging'

            join
            assessment_skills ask
            on ask.assessment_id = a.id

            join
            skills s
            on s.id = ask.skill_id

            left join
            employee_badges eb
            on ea.id = eb.employee_assessment_id
            and eb.active = 'true'

            left join
            badges b
            on b.id = eb.badge_id
            and b.active = 'true'

            left join
            skills s1
            on s1.id = b.skill_id ;;
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

    dimension: badge {
      type: string
      sql: ${TABLE}.badge ;;
    }

    dimension: asmt_skill {
      type: string
      sql: ${TABLE}.asmt_skill ;;
    }

    dimension: ernd_skill {
      type: string
      sql: ${TABLE}.ernd_skill ;;
    }

    dimension: proficiency {
      type: string
      sql: ${TABLE}.proficiency ;;
    }

    dimension: eb_id {
      type: number
      sql: ${TABLE}.eb_id ;;
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
        badge,
        asmt_skill,
        ernd_skill,
        proficiency,
        eb_id
      ]
    }
  }
