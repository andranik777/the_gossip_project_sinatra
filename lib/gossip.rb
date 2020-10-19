class Gossip
  attr_accessor :content , :author 

  def initialize(author, content)
    @content = content
    @author = author
  end
  
  def save
    CSV.open("db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    all_gossips = Gossip.all
    return all_gossips[id]
  end

  def self.update(author,content,id)
    all_gossips = Gossip.all
    all_gossips[id].author = author
    all_gossips[id].content = content
    CSV.open("db/gossip.csv", 'wb') { |csv| all_gossips.each{|row| csv << row}}
  end
end
