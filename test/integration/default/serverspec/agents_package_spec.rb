require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('ls -al /home/_mig/go/src/github.com/mozilla/mig/mig-agent*.deb') do
  its(:stdout) { should match /deb/ }
end

describe command('ls -al /home/_mig/go/src/github.com/mozilla/mig/mig-agent*.rpm') do
  its(:stdout) { should match /rpm/ }
end

describe command('ls -al /home/_mig/go/src/github.com/mozilla/mig/bin/windows/amd64/mig-agent*.exe'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  its(:stdout) { should match /exe/ }
end

