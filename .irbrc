require 'irb/completion'
IRB.conf[:AUTO_INDENT]=true
puts "Configure IRB: conf file at ~/.irbrc"
require 'rubygems'


module Kernel
    def rwirb
        require '/Users/danielribeiro/.rbenv/versions/ree-1.8.7-2011.03/lib/ruby/gems/1.8/gems/wirble-0.1.3/lib/wirble.rb'
        Wirble.init
        Wirble.colorize
    end

    def history
        Readline::HISTORY.each { |x| puts x }
        nil
    end

    def p_each(obj)
        obj.instance_variables.each do |v|
            puts "#{v}: #{obj.instance_variable_get(v).inspect}\n\n"
        end
        nil
    end    
end

require 'awesome_print'
require 'wirble'
Wirble.init
Wirble.colorize

