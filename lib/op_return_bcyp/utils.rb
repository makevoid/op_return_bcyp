class Hash
  alias :f :fetch
end

module Utils
  def symbolize_keys(hash)
    Hash[hash.map{ |key, value| [key.to_sym, value] }]
  end

  alias :sym_keys :symbolize_keys
end
