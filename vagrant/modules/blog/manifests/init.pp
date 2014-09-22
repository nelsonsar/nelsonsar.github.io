class blog {

    $packages = [
        "make",
        "ruby1.9.3",
        "nodejs"
    ]

    package { $packages:
        ensure => present
    }

    exec { 'change_ruby_version':
        command => 'sudo rm -f /usr/bin/ruby && sudo ln -s /usr/bin/ruby1.9.3 /usr/bin/ruby',
        require => Package['ruby1.9.3']
    }

    exec { 'rdoc':
        command => 'sudo gem install rdoc',
        require => Package['ruby1.9.3']
    }

    exec { 'jekyll':
        command => 'sudo gem install jekyll',
        require => Exec['rdoc'],
        timeout => 0
    }

    exec { 'i18n-gem':
        command => 'sudo gem install i18n',
        require => Exec['rdoc']
    }

    class { 'apache':
        default_vhost => false,
    }

    apache::vhost {'puppet':
        port => 80,
        docroot => '/var/www/blog',
        servername => 'blog.dev',
        vhost_name => 'blog'
    }
}
