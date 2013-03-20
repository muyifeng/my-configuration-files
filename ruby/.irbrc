require 'rubygems'
require 'Hirb'
begin
  require 'wirble'
  # wirble_opts = {
  #     # skip shortcuts
  #     :skip_shortcuts => true,
  # 
  #     # don't set the prompt
  #     :skip_prompt    => true,
  # 
  #     # override some of the default colors
  #     :colors => {
  #       :open_hash    => :green,
  #       :close_hash   => :green,
  #       :string       => :blue,
  #     },
  # 
  #     :init_color     => true,
  #   }

  Wirble.init
  # Wirble.init(wirble_opts)
  Wirble.colorize
rescue LoadError => err
  $stderr.puts "Couldn't load Wirble: #{err}"
end

Hirb.enable

