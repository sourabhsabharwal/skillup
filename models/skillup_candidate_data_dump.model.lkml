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

explore: skillup_candidates_data {
  join: recruit_attempts {
    type: inner
    relationship: one_to_one
    sql_on: ${recruit_attempts.id} = ${skillup_candidates_data.attempt_id} ;;
  }

  join: recruit_solves {
    type: left_outer
    relationship: one_to_many
    sql_on: ${recruit_attempts.id} = abs(${recruit_solves.aid}) ;;
  }

  join: questions {
    type: inner
    relationship: many_to_one
    sql_on: ${recruit_solves.qid} = ${questions.id} ;;
  }

  join: question_skill_tag_mapping {
    type: left_outer
    relationship: one_to_many
    sql_on: ${questions.id} = ${question_skill_tag_mapping.qid} ;;
  }

  join: recruit_tests {
    type: inner
    relationship: many_to_one
    sql_on: ${skillup_candidates_data.test_id} = ${recruit_tests.id} ;;
  }

  join: recruit_test_feedback {
    type: left_outer
    relationship: one_to_many
    sql_on: ${recruit_tests.unique_id} = ${recruit_test_feedback.test_hash}
          and
          ${recruit_test_feedback.user_email} = ${recruit_attempts.email};;
  }

}
