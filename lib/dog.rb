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

  def self.create(attribute_hash)
    new_dog=self.new(attribute_hash)
    new_dog.save
    new_dog
  end

  def self.find_by_id(id)
    sql = <<-SQL
    SELECT * FROM dogs WHERE id = ?
    SQL
    row = DB[:conn].execute(sql,id)[0]
    att_hash={id: row[0], name: row[1], breed: row[2]}
    self.new(row[0],row[1],row[2])
  end

  def initialize (id: nil, name:, breed:)
    @name = name
    @breed = breed
    @id = id
  end

  def save
    sql = <<-SQL
    INSERT INTO dogs (name, breed) VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
  end



end
