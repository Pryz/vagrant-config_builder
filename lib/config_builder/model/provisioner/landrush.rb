# @see https://github.com/phinze/landrush 
class ConfigBuilder::Model::Provisioner::Landrush < ConfigBuilder::Model::Base

  # @!attribute [rw] hosts
  #   @return [Hosts] blabla 
  LANDRUSH_ATTRIBUTES = [:hosts, :enabled, :tld, :upstream_servers, :host_ip_address, :guest_redirect_dns]

  LANDRUSH_ATTRIBUTES.each do |attr|
    def_model_attribute attr
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provision :landrush do |landrush_config|
        LANDRUSH_ATTRIBUTES.each do |key|
          config.send("#{key}=", attr(key)) if attr(key)
        end
        #with_attr(:hosts)              { |val| landrush_config.hosts = val }
        #with_attr(:enabled)            { |val| landrush_config.enabled = val }
        #with_attr(:tld)                { |val| landrush_config.tld = val }
        #with_attr(:upstream_servers)   { |val| landrush_config.upstream_servers = val }
        #with_attr(:host_ip_address)    { |val| landrush_config.host_ip_address = val }
        #with_attr(:guest_redirect_dns) { |val| landrush_config.guest_redirect_dns = val }
      end
    end
  end

  ConfigBuilder::Model::Provisioner.register('landrush', self)
end
