## testing

#### chnages made to the derived SQL by Ashish
#### changed were made on Dec 18, 2024
#### changes were made to include timestamps for all the employeee activites
view: assessments_details_for_funnel {
      derived_table: {
      sql: select
  a.recruit_test_id as test_id,
  a.id as assessment_id,
  a.name as assessment_name,
  a.type as assessment_type,
  ra.email as emp_email,
  e.email as email,
  e.created_at as employee_invited_at,
  json_extract_path_text(e.meta, 'onboarding_status' , true) as onboarding_status,
  case when onboarding_status = 'homepage_animation_completed' then e.activated_at end as emp_onboarded_at,
  ra.id as attempt_id,
  ra.starttime as attempt_started_at,
  ra.endtime as attempt_ended_at,
  ra.status as attempt_status,
  case when a.type = 'practise' then ra.endtime end as practise_attempt_ended_at,
  e.platform_company_id as company_id,
  rc.name as company_name,
  ea.max_score,
  ea.obtained_score,
  eb.id as emp_badge_id,
  eb.issued_at as emp_badge_issued_at,
  ec.id as emp_cert_id,
  ec.issued_at as emp_cert_issued_at,
  ea.id as emp_assessment_id

from assessments a

inner join  recruit_rs_replica.recruit.recruit_attempts ra
              on a.recruit_test_id = abs(ra.tid)

right join employees e
              on e.email = ra.email

inner join recruit_rs_replica.recruit.recruit_companies rc
              on rc.id = e.platform_company_id
              and e.platform_company_id not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841)
              and e.platform_user_uuid is not null
              and e.user_role in ('individual', 'manager')

left join   employee_assessments ea
              on ea.recruit_attempt_id = ra.id
              and ea.assessment_id = a.id

left join   employee_badges eb
              on ea.id = eb.employee_assessment_id
              and eb.employee_id = ea.employee_id
              and eb.active = 'true'

left join   employee_certifications ec
              on ea.id = ec.employee_assessment_id
              and ec.employee_id = ea.employee_id
              and ec.active = 'true'

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

  dimension_group: emp_badge_issued_at {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.emp_badge_issued_at ;;
  }

  dimension: emp_cert_id {
    type: number
    sql: ${TABLE}.emp_cert_id ;;
  }

  dimension: attempt_status {
    type: number
    sql: ${TABLE}.attempt_status ;;
  }

  dimension_group: emp_cert_issued_at {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.emp_cert_issued_at ;;
  }

  parameter: date_granularity {
    type: unquoted
    description: "Select the appropiate level of granularity for dashboard."
    default_value: "day"

    allowed_value: {
      label: "Day"
      value: "day"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Quarter"
      value: "quarter"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
    allowed_value: {
      label: "Week"
      value: "week"
    }
  }


  dimension: granular_date {
    label_from_parameter: date_granularity
    sql:
        {% if date_granularity._parameter_value == 'day' %}
          coalesce(${emp_badge_issued_at_date},${emp_cert_issued_at_date})
        {% elsif date_granularity._parameter_value == 'month' %}
          coalesce(${emp_badge_issued_at_month},${emp_cert_issued_at_month})
        {% elsif date_granularity._parameter_value == 'year' %}
          coalesce(${emp_badge_issued_at_year},${emp_cert_issued_at_year})
        {% elsif date_granularity._parameter_value == 'quarter' %}
          coalesce(${emp_badge_issued_at_quarter},${emp_cert_issued_at_quarter})
        {% elsif date_granularity._parameter_value == 'week' %}
          coalesce(${emp_badge_issued_at_week},${emp_cert_issued_at_week})
        {% endif %};;
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

## Added by Ashish
## Added on Dec 18, 2024
## timestamps

  dimension_group: employee_invited {
    group_label: "Employee Activites Timestamps"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.employee_invited_at ;;
    description: "We are using created_at field from employees table as a proxy for invited_at"
  }

  dimension_group: emp_onboarded {
    group_label: "Employee Activites Timestamps"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.emp_onboarded_at ;;
    description: "We are using activated_at field from employees table for cases where onboarding_status = 'homepage_animation_completed' as a proxy for onboarded_at"
  }

  dimension_group: employee_practise_attempt_started_at {
    group_label: "Employee Activites Timestamps"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: case when ${assessment_type} = 'practice' then ${TABLE}.attempt_started_at end;;
    description: "We are using starttime field from recruit_attempts table as a proxy for practise_attempt_started_at"
  }

  dimension_group: employee_badging_attempt_started_at {
    group_label: "Employee Activites Timestamps"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: case when ${assessment_type} = 'badging' then ${TABLE}.attempt_started_at end;;
    description: "We are using starttime field from recruit_attempts table as a proxy for badging_attempt_started_at"
  }

  dimension_group: employee_certifying_attempt_started_at {
    group_label: "Employee Activites Timestamps"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: case when ${assessment_type} = 'certifying' then ${TABLE}.attempt_started_at end;;
    description: "We are using starttime field from recruit_attempts table as a proxy for certifying_attempt_started_at"
  }

  dimension_group: employee_practise_attempt_ended_at {
    group_label: "Employee Activites Timestamps"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.practise_attempt_ended_at;;
    description: "We are using endtime field from recruit_attempts table as a proxy for practise_attempt_ended_at"
  }


  dimension_group: emp_activity {
    group_label: "Employee Activites Timestamps"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: coalesce(${TABLE}.employee_invited_at, ${TABLE}.emp_onboarded_at,${TABLE}.attempt_started_at,${TABLE}.attempt_ended_at , ${TABLE}.emp_badge_issued_at,${TABLE}.emp_cert_issued_at);;
    description: "use this for checking if employee has anykind of activity on a particular"
  }




    set: detail {
      fields: [
        assessment_id,
        test_id,
        assessment_name,
        assessment_type,
        emp_email,
        attempt_id,
        attempt_status,
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
