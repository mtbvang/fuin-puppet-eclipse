class eclipse inherits settings {
  #todo -> move to module
    archive { 'eclipse':
	ensure => present,
	url    => "$downloadurl/eclipse-jee-juno-SR2-linux-gtk-x86_64.tar.gz",
	target =>  "$userdevdir/",
	checksum => false,
	timeout => '900',
    }

    file { "$userdevdir/eclipse-4.2.2":
	ensure => 'link',
	target => "$userdevdir/eclipse",
    }

    $installpath="$userdevdir/eclipse-4.2.2"

    file { "eclipse.desktop":
	ensure => file,
	path   => "/home/$username/.local/share/applications/eclipse.desktop",
	content => template("eclipse/eclipse.desktop.erb")
    }

    file { "eclipse.ini":
	ensure => file,
	path   => "$userdevdir/eclipse-4.2.2/eclipse.ini",
	content => template("eclipse/eclipse.ini.erb")
    }

}

