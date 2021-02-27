class Hash
  def default! key, *fallbacks
    return self[key] if key? key

    fallback = first_existing(*fallbacks)
    self[key] = fallback unless fallback.nil?
  end
  alias_method :defaults!, :default!

  def required! key
    raise "The '#{key}' option is required!" unless key? key
  end
end