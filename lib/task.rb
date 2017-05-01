class Task
  attr_reader(:description, :list_id)

  def initialize(attributes)
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
  end

  def ==(another_task)
    self.description.==(another_task.description)
  end

  def self.all
    returned_tasks = DB.exec('SELECT * FROM tasks;')
    tasks = []
    returned_tasks.each do |task|
      description = task.fetch('description')
      tasks.push(Task.new({:description => description}))
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id});")
  end

end
