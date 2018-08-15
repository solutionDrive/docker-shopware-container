control 'project directory' do
    impact 1.0
    title 'verifies project directory'
    desc '
        In order to work with this container
        the project directory should be usable
    '

    describe directory('/var/www') do
        it { should exist }
        it { should be_directory }
    end
end
