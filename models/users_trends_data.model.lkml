connection: "skillup_rs_replica"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
explore: trends_for_active_users {
  join: registered_users {
    relationship: many_to_one
    type: left_outer
    sql_on: ${registered_users.platform_company_id} =  ${trends_for_active_users.company_id}
    and ${trends_for_active_users.emp_email} = ${registered_users.email};;
  }
}

explore: employees {
  join: trends_for_active_users{
    relationship: one_to_many
    type: left_outer
    sql_on: ${trends_for_active_users.emp_email} = ${employees.email} ;;
  }
  join: registered_users {
    relationship: many_to_one
    type: left_outer
    sql_on: ${registered_users.platform_company_id} =  ${employees.platform_company_id} ;;
  }
}
