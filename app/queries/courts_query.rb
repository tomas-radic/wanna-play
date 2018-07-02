class CourtsQuery < Patterns::Query

  queries Court

  private

  def query
    relation.enabled
  end
end