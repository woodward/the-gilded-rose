import Config

config :gilded_rose,
  # Toggle this between true and false to get the new conjured behavior described in the README.
  # Note that this flag only has an impact if the :update_quality_fn is set to :update_quality_newly_refactored
  new_conjured_behavior?: true,
  #
  # Use this to toggle between the old, unrefactored code or the newly refactored code:
  # update_quality_fn: :update_quality_old_before_refactoring
  update_quality_fn: :update_quality_newly_refactored
