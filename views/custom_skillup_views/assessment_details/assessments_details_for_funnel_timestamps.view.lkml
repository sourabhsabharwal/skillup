## testing

#### chnages made to the derived SQL by Ashish
#### changed were made on Dec 18, 2024
#### changes were made to include timestamps for all the employeee activites
view: assessments_details_for_funnel_timestamps {
  derived_table: {
    sql:
WITH assessments_details_for_funnel AS
(select
  a.recruit_test_id as test_id,
  a.id as assessment_id,
  a.name as assessment_name,
  a.type as assessment_type,
  ra.email as emp_email,
  e.id as employee_id,
  e.email as email,
  e.created_at as employee_invited_at,
  json_extract_path_text(e.meta, 'onboarding_status' , true) as onboarding_status,
  case when onboarding_status = 'homepage_animation_completed' then e.activated_at end as emp_onboarded_at,
  ra.id as attempt_id,
  ra.status as attempt_status,
  ra.starttime as attempt_started_at,
  ra.endtime as attempt_ended_at,
  e.platform_company_id as company_id,
  rc.name as company_name,
  ea.max_score,
  ea.obtained_score,
  eb.id as emp_badge_id,
  eb.issued_at as emp_badge_issued_at,
  ec.id as emp_cert_id,
  ec.issued_at as emp_cert_issued_at,
  ea.id as emp_assessment_id,
  coalesce(employee_invited_at, emp_onboarded_at,attempt_started_at,attempt_ended_at ,emp_badge_issued_at,emp_cert_issued_at)

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
)

--- 1. email Invited
select
company_id,
company_name,
employee_id,
email as employee_email,
employee_invited_at as activity_timestamp,
1 as activity_seq_num,
'invited' as activity_type,

'NA' as assessment_type,
null as assessment_id,
null as assessment_name,
null as assessment_attempt_id,
attempt_status,
null as is_assessment_passed

from assessments_details_for_funnel
where employee_invited_at is not null
group by 1,2,3,4,5,6,7,8,9,10,11,12,13

UNION ALL
--- 2. emp onboarded
select
company_id,
company_name,
employee_id,
email as employee_email,
emp_onboarded_at as activity_timestamp,
2 as activity_seq_num,
'onboarded' as activity_type,

'NA' as assessment_type,
null as assessment_id,
null as assessment_name,
null as assessment_attempt_id,
attempt_status,
null as is_assessment_passed

from assessments_details_for_funnel
where employee_invited_at is not null
and onboarding_status = 'homepage_animation_completed'
group by 1,2,3,4,5,6,7,8,9,10,11,12,13

UNION ALL
--- 3. took practise assessments
select
company_id,
company_name,
employee_id,
email as employee_email,
attempt_started_at as activity_timestamp,
3 as activity_seq_num,
'assessment_initiated' as activity_type,

assessment_type,
assessment_id::text as assessment_id,
assessment_name,
attempt_id::text as assessment_attempt_id,
attempt_status,
null as is_assessment_passed

from assessments_details_for_funnel
where employee_invited_at is not null
and onboarding_status = 'homepage_animation_completed'
and assessment_type = 'practice'
and attempt_id is not null
group by 1,2,3,4,5,6,7,8,9,10,11,12,13

UNION ALL
--- 4. submitted practise assessments
select
company_id,
company_name,
employee_id,
email as employee_email,
attempt_ended_at as activity_timestamp,
4 as activity_seq_num,
'assessment_completed' as activity_type,

assessment_type,
assessment_id::text as assessment_id,
assessment_name,
attempt_id::text as assessment_attempt_id,
attempt_status,
null as is_assessment_passed

from assessments_details_for_funnel
where employee_invited_at is not null
and onboarding_status = 'homepage_animation_completed'
and assessment_type = 'practice'
and attempt_id is not null
and attempt_status = 7
-- and emp_assessment_id is not null
group by 1,2,3,4,5,6,7,8,9,10,11,12,13

UNION ALL
--- 5. took badging assessments
select
company_id,
company_name,
employee_id,
email as employee_email,
attempt_started_at as activity_timestamp,
5 as activity_seq_num,
'assessment_initiated' as activity_type,

assessment_type,
assessment_id::text as assessment_id,
assessment_name,
attempt_id::text as assessment_attempt_id,
attempt_status,
null as is_assessment_passed

from assessments_details_for_funnel
where employee_invited_at is not null
and onboarding_status = 'homepage_animation_completed'
and assessment_type = 'badging'
and attempt_id is not null
group by 1,2,3,4,5,6,7,8,9,10,11,12,13

UNION ALL
--- 6. earned badges
select
company_id,
company_name,
employee_id,
email as employee_email,
emp_badge_issued_at as activity_timestamp,
6 as activity_seq_num,
'assessment_completed' as activity_type,

assessment_type,
assessment_id::text as assessment_id,
assessment_name,
attempt_id::text as assessment_attempt_id,
attempt_status,
case when emp_badge_id is not null then 'yes' else 'no' end as is_assessment_passed

from assessments_details_for_funnel
where employee_invited_at is not null
and onboarding_status = 'homepage_animation_completed'
and assessment_type = 'badging'
and attempt_id is not null
and emp_badge_id is not null
group by 1,2,3,4,5,6,7,8,9,10,11,12,13

UNION ALL
--- 7. took certifying assessments
select
company_id,
company_name,
employee_id,
email as employee_email,
attempt_started_at as activity_timestamp,
7 as activity_seq_num,
'assessment_initiated' as activity_type,

assessment_type,
assessment_id::text as assessment_id,
assessment_name,
attempt_id::text as assessment_attempt_id,
attempt_status,
null as is_assessment_passed

from assessments_details_for_funnel
where employee_invited_at is not null
and onboarding_status = 'homepage_animation_completed'
and assessment_type = 'certifying'
and attempt_id is not null
group by 1,2,3,4,5,6,7,8,9,10,11,12,13

UNION ALL
--- 8. took certifying assessments
select
company_id,
company_name,
employee_id,
email as employee_email,
emp_cert_issued_at as activity_timestamp,
8 as activity_seq_num,
'assessment_completed' as activity_type,

assessment_type,
assessment_id::text as assessment_id,
assessment_name,
attempt_id::text as assessment_attempt_id,
attempt_status,
case when emp_cert_id is not null then 'yes' else 'no' end as is_assessment_passed

from assessments_details_for_funnel
where employee_invited_at is not null
and onboarding_status = 'homepage_animation_completed'
and assessment_type = 'certifying'
and attempt_id is not null
and emp_cert_id is not null
group by 1,2,3,4,5,6,7,8,9,10,11,12,13
      ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: employee_id {
    type: string
    sql: ${TABLE}.employee_id ;;
  }


  dimension: employee_email {
    type: string
    sql: ${TABLE}.employee_email ;;
  }

  dimension_group: emp_activity {
    group_label: "Employee Activites Timestamps"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.activity_timestamp ;;
    description: "use this for checking if employee has anykind of activity on a particular date"
  }

  dimension: activity_seq_num {
    type: string
    sql: ${TABLE}.activity_seq_num ;;
  }

  dimension: activity_type {
    type: string
    sql: ${TABLE}.activity_type ;;
  }

  dimension: assessment_type {
    type: string
    sql: ${TABLE}.assessment_type ;;
    suggestions: ["practice","badging","certifying"]
    description: "practice,badging,certifying"
    case_sensitive: no
  }

  dimension: assessment_id {
    type: string
    sql: ${TABLE}.assessment_id ;;
  }

  dimension: assessment_name {
    type: string
    sql: ${TABLE}.assessment_name ;;
  }

  dimension: assessment_attempt_id {
    type: string
    sql: ${TABLE}.assessment_attempt_id ;;
  }

  dimension: attempt_status {
    type: string
    sql: ${TABLE}.attempt_status ;;
  }

  dimension: is_assessment_passed {
    type: string
    sql: ${TABLE}.is_assessment_passed ;;
    suggestions: ["yes","no"]
    case_sensitive: no
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


  dimension: dynamic_granular_date {
    label_from_parameter: date_granularity
    sql:
        {% if date_granularity._parameter_value == 'day' %}
          ${emp_activity_date}
        {% elsif date_granularity._parameter_value == 'month' %}
          ${emp_activity_month}
        {% elsif date_granularity._parameter_value == 'year' %}
          ${emp_activity_year}
        {% elsif date_granularity._parameter_value == 'quarter' %}
          ${emp_activity_quarter}
        {% elsif date_granularity._parameter_value == 'week' %}
          ${emp_activity_week}
        {% endif %};;
  }



####### Measures

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: 1_count_emp_invited {
    group_label: "Employee Counts"
    type: count_distinct
    sql: case when activity_seq_num=1 then ${employee_id} end ;;
    drill_fields: [detail*]
  }

  measure: 2_count_emp_onboarded {
    group_label: "Employee Counts"
    type: count_distinct
    sql: case when activity_seq_num=2 then ${employee_id} end;;
    drill_fields: [detail*]
  }

  measure: 3_count_emp_took_practice_assessments {
    group_label: "Employee Counts"
    type: count_distinct
    sql: case when activity_seq_num=3 then ${employee_id} end;;
    drill_fields: [detail*]
  }

  measure: 4_count_emp_took_practice_assessments {
    group_label: "Employee Counts"
    type: count_distinct
    sql: case when activity_seq_num=4 then ${employee_id} end;;
    drill_fields: [detail*]
  }

  measure: 5_count_emp_took_badging_assessments {
    group_label: "Employee Counts"
    type: count_distinct
    sql: case when activity_seq_num=5 then ${employee_id} end;;
    drill_fields: [detail*]
  }

  measure: 6_count_emp_earned_badges{
    group_label: "Employee Counts"
    type: count_distinct
    sql: case when activity_seq_num=6 then ${employee_id} end;;
    drill_fields: [detail*]
  }

  measure: 7_count_emp_took_certifying_assessments{
    group_label: "Employee Counts"
    type: count_distinct
    sql: case when activity_seq_num=7 then ${employee_id} end;;
    drill_fields: [detail*]
  }

  measure: 8_count_emp_earned_certifications{
    group_label: "Employee Counts"
    type: count_distinct
    sql: case when activity_seq_num=8 then ${employee_id} end;;
    drill_fields: [detail*]
  }



  measure: 1_count_all_assessments_taken {
    group_label: "Assessments Counts"
    type: count_distinct
    sql: ${assessment_attempt_id} ;;
    drill_fields: [detail*]
  }

  measure: 2_count_practice_assessments_taken {
    group_label: "Assessments Counts"
    type: count_distinct
    sql: case when activity_seq_num=3 then ${assessment_attempt_id} end;;
    drill_fields: [detail*]
  }

  measure: 3_count_practice_assessments_submitted {
    group_label: "Assessments Counts"
    type: count_distinct
    sql: case when activity_seq_num=4 then ${assessment_attempt_id} end;;
    drill_fields: [detail*]
  }


  measure: 4_count_badging_assessments_taken {
    group_label: "Assessments Counts"
    type: count_distinct
    sql: case when activity_seq_num=5 then ${assessment_attempt_id} end;;
    drill_fields: [detail*]
  }

  measure: 5_count_badges_earned {
    group_label: "Assessments Counts"
    type: count_distinct
    sql: case when activity_seq_num=6 then ${assessment_attempt_id} end;;
    drill_fields: [detail*]
  }

  measure: 6_count_certifying_assessments_taken{
    group_label: "Assessments Counts"
    type: count_distinct
    sql: case when activity_seq_num=7 then ${assessment_attempt_id} end;;
    drill_fields: [detail*]
  }

  measure: 7_count_certifications_earned{
    group_label: "Assessments Counts"
    type: count_distinct
    sql: case when activity_seq_num=8 then ${assessment_attempt_id} end;;
    drill_fields: [detail*]
  }



  set: detail {
    fields: [
      assessment_id,
      assessment_name,
      assessment_type,
      attempt_status,
      company_id,
      company_name
    ]
  }
}
