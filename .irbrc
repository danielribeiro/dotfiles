require 'irb/completion'
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
puts "Configure IRB: conf file at ~/.irbrc. Added functions: wstr, p_each, history"
require 'rubygems'
require 'set'

module Kernel
    def wstr(ar)
      sts = ar.join(" ")
      "%w[#{sts}]"
    end

    # Reline::HISTORY is new in ruby 2.7, replacing Readline::HISTORY
    def xhistory
        Reline::HISTORY.each { |x| puts x }
        nil
    end

    def p_each(obj)
        obj.instance_variables.each do |v|
            puts "#{v}: #{obj.instance_variable_get(v).inspect}\n\n"
        end
        nil
    end    

    def r(project)
        require project.to_s
    end
end

begin
    require 'awesome_print'
rescue Exception
    puts "- no awesome_print."
end

