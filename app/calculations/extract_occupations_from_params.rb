class ExtractOccupationsFromParams < Patterns::Calculation

  private

  def result
    result = {}

    Court.all.each do |court|
      params_lookup_value = params["court_#{court.id}"]
      next if params_lookup_value.nil?

      result[court.id] = params_lookup_value      
    end

    result
  end

  def params
    @params ||= options.fetch(:params)
  end

end
