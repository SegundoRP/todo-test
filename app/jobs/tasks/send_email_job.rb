class Tasks::SendEmailJob
  include SuckerPunch::Job

  def perform(task_id)
    task = Task.find(task_id)
    Tasks::SendEmail.new.call task
  end
end

# siempre es mejor pasar strings o integer en el perform ya que en los jobs
# y en background puede que no funcione bien la serializacion si le pasamos objetos
