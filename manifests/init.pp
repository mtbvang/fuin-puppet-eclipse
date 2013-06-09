#TODO M2: remove hardcodes + menu
class eclipse {
  #todo -> move to module
    archive { 'eclipse':
	ensure => present,
	url    => 'http://eclipse.mirror.triple-it.nl/technology/epp/downloads/release/juno/SR2/eclipse-jee-juno-SR2-linux-gtk-x86_64.tar.gz',
	target => '/home/dev',
	checksum => false,
	timeout => '900'
    }

    file { '/home/dev/eclipse-4.2.2':
	ensure => 'link',
	target => '/home/dev/eclipse',
    }

    exec { "sed -i 's|vmargs|vm/home/dev/oracle-jdk-7u21|g' /home/dev/eclipse-4.2.2/eclipse.ini":
	path => [ '/usr/local/bin', '/usr/bin', '/bin', ],
	onlyif => "/bin/grep -E 'vmargs' '/home/dev/eclipse-4.2.2/eclipse.ini'",
    }


}

