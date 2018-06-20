module Ufo
  class Destroy
    include Util
    include AwsService
    include SecurityGroup::Helper
    include Stack::Helper

    def initialize(service, options={})
      @service = service
      @options = options
      @stack_name = adjust_stack_name(service)
      @cluster = @options[:cluster] || default_cluster
    end

    def bye
      unless are_you_sure?
        puts "Phew, that was close"
        return
      end

      cloudformation.delete_stack(stack_name: @stack_name)
      puts "Deleting CloudFormation stack with ECS resources: #{@stack_name}."
      status.wait
    end

    def are_you_sure?
      return true if @options[:sure]
      puts "You are about to destroy #{@service.colorize(:green)} service on the #{@cluster.colorize(:green)} cluster."
      print "Are you sure you want to do this? (y/n) "
      answer = $stdin.gets.strip
      answer =~ /^y/
    end
  end
end
