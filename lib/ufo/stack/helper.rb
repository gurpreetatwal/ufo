class Ufo::Stack
  module Helper
    include Ufo::AwsService
    include Ufo::Util
    extend Memoist

    def find_stack(stack_name)
      resp = cloudformation.describe_stacks(stack_name: stack_name)
      resp.stacks.first
    rescue Aws::CloudFormation::Errors::ValidationError => e
      # example: Stack with id demo-web does not exist
      if e.message =~ /Stack with/ && e.message =~ /does not exist/
        nil
      else
        raise
      end
    end

    def adjust_stack_name(cluster, service)
      [cluster, Ufo.pretty_service_name(service)].compact.join('-')
    end

    def status
      Status.new(@stack_name)
    end
    memoize :status
  end
end
