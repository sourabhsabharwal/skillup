view: paid_customers {
    derived_table: {
      sql: select hrid_c as customer_id, accounts.name as customer_name, amount as ARR, opportunities.service_start_date_c as start_date,
      opportunities.service_end_date_c as end_date, datediff(days,current_date,end_date ) as contract_pedning_days,
      hrw_pricing_model_c, funnel_stage_c, next_step,is_closed,account_id,stage_name as customer_stage
              from
              hr_analytics.salesforce.accounts
              join
              hr_analytics.salesforce.opportunities
              on accounts.id   = opportunities.account_id
              where
              lower(hrw_pricing_model_c) like '%skillup%'
              and
              opportunities.is_won ='true'
              and accounts.is_deleted ='false'
              and opportunities.is_deleted ='false'
              -- and
              -- stage_name like '%Finance Approved & Closed Won%'
              and
              accounts.name != 'Sales Ops Test Account 001 - IGNORE AC NAME'
              and customer_id != 213905;;
    }

   measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }

  dimension_group: start_date {
    type: time
    sql: ${TABLE}.start_date ;;
  }

  dimension_group: end_date {
    type: time
    sql: ${TABLE}.end_date ;;
  }

  dimension: contract_pedning_days {
    type: number
    sql: ${TABLE}.contract_pedning_days ;;
  }

  dimension: arr {
    type: number
    sql: ${TABLE}.arr ;;
  }

  dimension: hrw_pricing_model_c {
    type: string
    sql: ${TABLE}.hrw_pricing_model_c ;;
  }

  dimension: funnel_stage_c {
    type: string
    sql: ${TABLE}.funnel_stage_c ;;
  }

  dimension: next_step {
    type: string
    sql: ${TABLE}.next_step ;;
  }

  dimension: is_closed {
    type: string
    sql: ${TABLE}.is_closed ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: customer_stage {
    type: string
    sql: ${TABLE}.customer_stage ;;
  }

  set: detail {
    fields: [
      customer_id,
      customer_name,
      start_date_time,
      end_date_time,
      contract_pedning_days,
      arr,
      hrw_pricing_model_c,
      funnel_stage_c,
      next_step,
      is_closed,
      account_id,
      customer_stage
    ]
  }
  }
