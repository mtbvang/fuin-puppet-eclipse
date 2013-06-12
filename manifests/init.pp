class eclipse inherits settings {
  #todo -> move to module
    archive { 'eclipse':
	ensure => present,
	url    => "$downloadurl/eclipse-jee-juno-SR2-linux-gtk-x86_64.tar.gz",
	target =>  "$userdevdir/",
	checksum => false,
	timeout => '900',
    }

    Exec { path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" }

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

    define feature_add {
	exec { "adding feature $name":
	    cwd     => "$userdevdir/eclipse",
	    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$userdevdir/eclipse",
	    command => "./eclipse -application org.eclipse.equinox.p2.director -noSplash  -repository $name"
	}
    }
    
    feature_add  { $eclipse_features : }
    
    

}

