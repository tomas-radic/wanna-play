class UsersQuery < Patterns::Query

  queries User

  private

  def query
    relation.where.not(blocked: true)
  end
end