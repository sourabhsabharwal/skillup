
view: registered_users {
  derived_table: {
    sql: select platform_company_id , email
                    from
                    employees e
                    where e.platform_company_id not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841)
                    and platform_company_uuid is not null
                    and user_role = 'individual' ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: platform_company_id {
    type: number
    sql: ${TABLE}.platform_company_id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  set: detail {
    fields: [
      platform_company_id,
      email
    ]
  }
}
