# @see https://github.com/phinze/landrush 
class ConfigBuilder::Model::Provisioner::Landrush < ConfigBuilder::Model::Base

  def_model_attribute :hosts
  def_model_attribute :enabled
  def_model_attribute :tld
  def_model_attribute :upstream_servers
  def_model_attribute :hosts_ip_address
  def_model_attribute :guest_redirect_dns

  def to_proc
    Proc.new do |vm_config|
      vm_config.provision :landrush do |landrush_config|
        landrush_config.hosts = attr(:hosts) if attr(:hosts)
        landrush_config.hosts = attr(:enabled) if attr(:enabled)
        landrush_config.hosts = attr(:tld) if attr(:tld)
        landrush_config.hosts = attr(:upstream_servers) if attr(:upstream_servers)
        landrush_config.hosts = attr(:hosts_ip_address) if attr(:hosts_ip_address)
        landrush_config.hosts = attr(:guest_redirect_dns) if attr(:guest_redirect_dns)
      end
    end
  end

  ConfigBuilder::Model::Provisioner.register('landrush', self)
end
