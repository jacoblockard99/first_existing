require "first_existing/version"

module FirstExisting
  def first_existing *args
    args.each { |a| return a unless a.nil? }
    nil
  end
end
