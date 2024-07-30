view: _prisma_migrations {
  sql_table_name: public._prisma_migrations ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: applied_steps_count {
    type: number
    sql: ${TABLE}.applied_steps_count ;;
  }
  dimension: checksum {
    type: string
    sql: ${TABLE}.checksum ;;
  }
  dimension_group: finished {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.finished_at ;;
  }
  dimension: logs {
    type: string
    sql: ${TABLE}.logs ;;
  }
  dimension: migration_name {
    type: string
    sql: ${TABLE}.migration_name ;;
  }
  dimension_group: rolled_back {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.rolled_back_at ;;
  }
  dimension_group: started {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.started_at ;;
  }
  measure: count {
    type: count
    drill_fields: [id, migration_name]
  }
}
