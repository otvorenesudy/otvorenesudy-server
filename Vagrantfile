VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/precise64'

  config.vm.network 'private_network', ip: '192.168.50.4'
  config.vm.synced_folder '.', '/vagrant', type: 'nfs'

  config.vm.provider 'virtualbox' do |v|
    v.name = 'Open Courts Server'
    v.memory = 2048
    v.cpus = 4
  end

  config.vm.network 'forwarded_port', guest: 80, host: 8080
end
