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

explore: certifications {
always_join: [job_roles]
  join: job_roles {
    type: left_outer
    relationship: many_to_one
    sql_on: ${job_roles.id} = ${certifications.job_role_id} ;;
    sql_where: ${certifications.platform_company_id} not in (371416, 364822, 327186, 297361, 280588, 280251, 279841, 178821, 163391, 118702, 0, 279841) ;;
  }
  join: job_role_skills {
    type: left_outer
    relationship: one_to_many
    sql_on: ${job_role_skills.job_role_id} = ${job_roles.id} ;;
  }
  join: skills {
    type: left_outer
    relationship: many_to_one
    sql_on: ${skills.id} = ${job_role_skills.skill_id} ;;
  }
  join: employees {
    type: left_outer
    relationship: many_to_one
    sql_on: ${job_roles.id} = ${employees.job_role_id} ;;
  }
}
