class blog {

    package { 'rubygems':
        ensure => present
    }

    exec { 'rdoc':
        command => 'sudo gem install rdoc',
        require => Package['rubygems']
    }

    exec { 'jekyll':
        command => 'sudo gem install jekyll',
        require => Exec['rdoc']
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
