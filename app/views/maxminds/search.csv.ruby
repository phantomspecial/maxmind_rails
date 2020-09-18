csv_data = CSV.generate(encoding: Encoding::SJIS) do |csv|
  csv << @search_form.class::HEADER
  @results.each do |result|
    csv << [
      result[:ip],
      result[:iso_code]
    ]
  end
end
