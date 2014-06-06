$as_vagrant = '/usr/bin/sudo -u vagrant -H bash -l -c'
$home  = '/home/vagrant'
$user = 'vagrant'
$group = 'vagrant'

# --- Core -------------------------------------------------------------------

class core {
  exec { "apt-update":
    command => "/usr/bin/sudo apt-get -y update",
    path => ['/bin', '/usr/bin', '/usr/sbin']
  }

  package { [ "vim", "git-core", "curl" ]:
    ensure => ["installed"],
    require => Exec["apt-update"]
  }
}

# --- Ruby common dependencies -----------------------------------------------------

class ruby_dependencies {

  package { ['sqlite3', 'libsqlite3-dev']:
    ensure => installed;
  }

  # Nokogiri dependencies.
  package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
    ensure => installed
  }

  # Postgres client
  package { 'libpq-dev':
    ensure => installed
  }

  package { ['libmysql-ruby', 'libmysqlclient-dev']:
    ensure => installed;
  }

}


include core
include ruby_dependencies
