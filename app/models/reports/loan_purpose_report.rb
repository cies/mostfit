class LoanPurposeReport < Report
  attr_accessor :from_date, :to_date, :branch, :center, :branch_id, :center_id, :staff_member_id

  def initialize(params, dates)
    @from_date = (dates and dates[:from_date]) ? dates[:from_date] : Date.today - 30
    @to_date   = (dates and dates[:to_date]) ? dates[:to_date] : Date.today  
    @name   = "Report from #{@from_date} to #{@to_date}"
    get_parameters(params)
  end
  
  def name
    "Report from #{@from_date} to #{@to_date}"
  end
  
  def self.name
    "Loan purpose report"
  end
  
  def generate
    repository.adapter.query("SELECT o.name purpose, count(*) count, sum(amount) amount FROM loans LEFT OUTER JOIN occupations o ON o.id=loans.occupation_id group by occupation_id")
  end
end