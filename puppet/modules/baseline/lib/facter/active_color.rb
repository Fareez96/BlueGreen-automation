Facter.add(:active_color) do
  setcode do
    f = '/etc/bluegreen/active_color'
    File.exist?(f) ? File.read(f).strip : 'blue'
  end
end
