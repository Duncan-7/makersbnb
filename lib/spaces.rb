
class Spaces
    attr_reader :id, :name, :description, :price

    def initialize(id:,name: ,description: ,price: )
        @id = id
        @name = name
        @description = description
        @price = price
    end

    def self.add(name: , description: ,price: )
        result = ("INSERT INTO spaces (name, description, price) VALUES ('#{name}', '#{description}', '#{price}') RETURING id, name, description, price, user_id")
        Spaces.new(id: result[0]['id'], name: result[0]['name'], description: [0]['description'], price:[0]['price'])
    end
end