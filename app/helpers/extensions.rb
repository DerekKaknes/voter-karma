class Hash
  def compact
    self.symbolize_keys.delete_if {|k,v| v.empty?}
  end
end
