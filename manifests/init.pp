#TODO M2: add menu
class eclipse inherits settings {
  #todo -> move to module
    archive { 'eclipse':
	ensure => present,
	url    => "$downloadurl/eclipse-jee-juno-SR2-linux-gtk-x86_64.tar.gz",
	target =>  "$userhomedir/",
	checksum => false,
	timeout => '900'
    }

    file { "$userhomedir/eclipse-4.2.2":
	ensure => 'link',
	target => "$userhomedir/eclipse",
    }

    exec { "sed -i 's|vmargs|vm$userhomedir/$jdk|g' $userhomedir/eclipse-4.2.2/eclipse.ini":
	path => [ '/usr/local/bin', '/usr/bin', '/bin', ],
	onlyif => "/bin/grep -E 'vmargs' $userhomedir/eclipse-4.2.2/eclipse.ini",
    }


}

