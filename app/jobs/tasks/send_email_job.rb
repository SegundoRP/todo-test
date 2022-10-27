class Tasks::SendEmailJob
  include SuckerPunch::Job

  def perform
    raise NotImplementedError
  end
end
