view: questions {
  sql_table_name: content_rs_replica.content.questions ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: authkey {
    type: string
    sql: ${TABLE}.authkey ;;
  }
  dimension: author {
    type: string
    sql: ${TABLE}.author ;;
  }
  dimension: content_quality {
    type: string
    sql: ${TABLE}.content_quality ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: custom {
    type: string
    sql: ${TABLE}.custom ;;
  }
  dimension: deleted {
    type: number
    sql: ${TABLE}.deleted ;;
  }
  dimension: draft {
    type: number
    sql: ${TABLE}.draft ;;
  }
  dimension: evaluator_params {
    type: string
    sql: ${TABLE}.evaluator_params ;;
  }
  dimension: format {
    type: string
    sql: ${TABLE}.format ;;
  }
  dimension: internal_notes {
    type: string
    sql: ${TABLE}.internal_notes ;;
  }
  dimension: is_valid {
    type: number
    value_format_name: id
    sql: ${TABLE}.is_valid ;;
  }
  dimension: leaked_data {
    type: string
    sql: ${TABLE}.leaked_data ;;
  }
  dimension: level {
    type: string
    sql: ${TABLE}.level ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: parent_id {
    type: number
    sql: ${TABLE}.parent_id ;;
  }
  dimension: problem_statement {
    type: string
    sql: ${TABLE}.problem_statement ;;
  }
  dimension: product {
    type: number
    sql: ${TABLE}.product ;;
  }
  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }
  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }
  dimension: stack {
    type: string
    sql: ${TABLE}.stack ;;
  }
  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }
  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
  }
  dimension: templates {
    type: string
    sql: ${TABLE}.templates ;;
  }
  dimension: testcases {
    type: string
    sql: ${TABLE}.testcases ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
  dimension: type_attributes {
    type: string
    sql: ${TABLE}.type_attributes ;;
  }
  dimension: unique_id {
    type: string
    sql: ${TABLE}.unique_id ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  dimension: version {
    type: number
    sql: ${TABLE}.version ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
