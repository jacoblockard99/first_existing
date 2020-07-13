require "first_existing/version"

module FirstExisting
  class Error < StandardError; end

  def first_existing *args
    args.each { |a| return a unless a.nil? }
    nil
  end
end
