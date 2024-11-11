view: employees {
  sql_table_name: public.employees ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: activated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.activated_at ;;
  }
  dimension: bio {
    type: string
    sql: ${TABLE}.bio ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: designation {
    type: string
    sql: ${TABLE}.designation ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: job_role_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.job_role_id ;;
  }
  dimension: job_role_name {
    type: string
    sql: ${TABLE}.job_role_name ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: license {
    type: string
    sql: ${TABLE}.license ;;
  }
  dimension: manager_id {
    type: number
    sql: ${TABLE}.manager_id ;;
  }
  dimension: meta {
    type: string
    sql: ${TABLE}.meta ;;
  }
  dimension: onboarding {
    type: string
    sql: json_extract_path_text(${TABLE}.meta, 'onboarding_status' , true) ;;
  }
  dimension: platform_company_id {
    type: number
    sql: ${TABLE}.platform_company_id ;;
  }
  dimension: platform_company_uuid {
    type: string
    sql: ${TABLE}.platform_company_uuid ;;
  }
  dimension: platform_user_id {
    type: number
    sql: ${TABLE}.platform_user_id ;;
  }
  dimension: platform_user_uuid {
    type: string
    sql: ${TABLE}.platform_user_uuid ;;
  }
  dimension: profile_enabled {
    type: string
    sql: ${TABLE}.profile_enabled ;;
  }
  dimension: recruit_candidate_uuid {
    type: string
    sql: ${TABLE}.recruit_candidate_uuid ;;
  }
  dimension: recruit_company_id {
    type: number
    sql: ${TABLE}.recruit_company_id ;;
  }
  dimension: recruit_user_id {
    type: number
    sql: ${TABLE}.recruit_user_id ;;
  }

  ## Modified by ashish on Nov 11 based on breif by Saourabh Maurya

  dimension: role {
    label: "Role Old"
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: role_new {
    label: "Role New"
    type: string
    sql: ${TABLE}.user_role ;;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  dimension: user_role {
    type: string
    sql: ${TABLE}.user_role ;;
  }

  # dimension: emp_company {
  #   type: string
  #   sql: ${recruit_companies.name} ;;
  # }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: employee_count {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [id,email,platform_company_id,created_date,activated_date]
    # [id,email,platform_company_id,emp_company,created_date,activated_date]
    # drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      job_role_name,
      job_roles.id,
      job_roles.name,
      bookmarks.count,
      email_templates.count,
      employee_assessment_invites.count,
      employee_assessments.count,
      employee_badges.count,
      employee_certifications.count,
      employee_goals.count,
      employee_skill_concepts.count,
      employee_skill_learning_playlist_activity.count,
      employee_skill_progress.count,
      employee_skill_rating_change_logs.count,
      employee_skill_self_ratings.count,
      employee_skills.count,
      social_links.count,
      workflows.count,
      onboarding
    ]
  }

}
