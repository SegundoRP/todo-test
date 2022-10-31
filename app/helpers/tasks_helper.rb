module TasksHelper
  def available_events_for(task)
    task.aasm.permitted_transitions
  end
end
