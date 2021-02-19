require "first_existing/version"
require "first_existing/kernel"
require "first_existing/hash"

module FirstExisting
  def first_existing *args
    args.each { |a| return a unless a.nil? }
    nil
  end
end
