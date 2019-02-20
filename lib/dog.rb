class Dog
  attr_accessor :name, :breed
  attr_reader :id

  def self.create_table
    sql = <<-SQL
    CREATE TABLE dogs(
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE dogs
    SQL
    DB[:conn].execute(sql)
  end

  def initialize (id: nil, name:, breed:)
    @name = name
    @breed = breed
    @id = id
  end

end
