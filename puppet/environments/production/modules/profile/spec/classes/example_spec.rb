require 'spec_helper'

describe 'profile' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "profile class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('profile::params') }
        it { should contain_class('profile::install').that_comes_before('profile::config') }
        it { should contain_class('profile::config') }
        it { should contain_class('profile::service').that_subscribes_to('profile::config') }

        it { should contain_service('profile') }
        it { should contain_package('profile').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'profile class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('profile') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
