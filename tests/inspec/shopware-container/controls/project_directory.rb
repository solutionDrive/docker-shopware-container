shopware_short_version = attribute(
    'shopware_short_version',
    description: 'Shopware short version'
)

php_short_version = attribute(
    'php_short_version',
    description: 'php short version'
)

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

    describe directory('/var/www/shopware' + shopware_short_version.to_s + '_php' + php_short_version.to_s) do
        it { should exist }
        it { should be_directory }
    end
end
