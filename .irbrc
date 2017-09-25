require 'irb/completion'
IRB.conf[:AUTO_INDENT] = true
puts "Configure IRB: conf file at ~/.irbrc. Added functions: history, wstr, p_each"
require 'rubygems'
require 'set'


module Kernel
    def history
        Readline::HISTORY.each { |x| puts x }
        nil
    end

    def wstr(ar)
      sts = ar.join(" ")
      "%w[#{sts}]"
    end

    def p_each(obj)
        obj.instance_variables.each do |v|
            puts "#{v}: #{obj.instance_variable_get(v).inspect}\n\n"
        end
        nil
    end    
end

begin
    require 'awesome_print'
rescue Exception
    puts "- no awesome_print."
end
require 'wirble'
Wirble.init
Wirble.colorize

