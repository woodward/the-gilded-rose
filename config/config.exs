import Config

config :gilded_rose,
  # Toggle this between true and false to get the new conjured behavior described in the README:
  new_conjured_behavior?: true,
  #
  # ***IMPORTANT***: Note that if you set the update_quality_fn to :update_quality_old_before_refactoring below,
  # then you MUST set new_conjured_behavior? to false above!!!
  #
  # Use this to toggle between the old, unrefactored code or the newly refactored code:
  # update_quality_fn: :update_quality_old_before_refactoring
  update_quality_fn: :update_quality_newly_refactored
