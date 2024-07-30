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

explore: employees {
  join: employee_assessments {
    type: left_outer
    relationship: one_to_many
    sql_on: ${employees.id} = ${employee_assessments.employee_id} ;;
    sql_where: ${employees.platform_company_id} not in (364822, 327186, 297361, 280588, 280251, 178821, 163391, 118702,280588,271416) ;;
  }

  join: recruit_companies {
    type: left_outer
    relationship: many_to_one
    sql_on: ${recruit_companies.id} = ${employees.platform_company_id} ;;
  }
  join: assessments {
    type: left_outer
    relationship: many_to_one
    sql_on:  ${employee_assessments.assessment_id} = ${assessments.id} ;;
  }
  join: employee_badges {
    type: left_outer
    relationship: one_to_one
    sql_on: ${employee_assessments.id} = ${employee_badges.employee_assessment_id} ;;
  }
  join: employee_certifications {
    type: left_outer
    relationship: one_to_one
    sql_on: ${employee_assessments.id} = ${employee_certifications.employee_assessment_id} ;;
  }
}
