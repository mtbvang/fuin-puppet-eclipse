# Class: eclipse
#
#   This module manages an Eclipse installation
#
# Parameters:
#
#   $downloadUrl = undef
#     URL where the Eclipse archive is located without trailing slash (Example: "http://puppet/files").
#
#   $release = undef
#     Name of the Eclipse release to install (Example: "eclipse-jee-juno-SR2" or "eclipse-SDK-4.2.2").
#
#   $bit = undef
#     32 or 64 bit version (Example: "32" for the 32 Bit version).
#
#   $targetDir = undef
#     Directory where to install Eclipse without a trailing slash (Example: "/opt/eclipse/jee-juno-SR2").
#
#   $jdkHome = undef
#     Directory where the Java Development Kit (JDK) is installed (Example: "/opt/jdk7u25").
#
#   $desktopLink = false
#     Create a desktop link (true) or not (false). Currently only supports 'Debian' os family - Other will be silently ignored.
#
#   $vmargs = [ '-XX:MaxPermSize=256m', '-Xms40m', '-Xmx768m' ]
#     Array of vm arguments to use.
#
#   $country = "DEFAULT"
#     Country to set for the JVM. Defaults to the system country.
#
#   $language = "DEFAULT"
#     Lannguage to set for the JVM. Defaults to the system language.
#
define eclipse (
  $downloadUrl = undef,
  $release     = undef,
  $bit         = undef,
  $targetDir   = undef,
  $jdkHome     = undef,
  $desktopLink = false,
  $vmargs      = ['-XX:MaxPermSize=256m', '-Xms40m', '-Xmx768m'],
  $country     = "DEFAULT",
  $language    = "DEFAULT") {
  # Validate arguments
  if !($bit in ['32', '64']) {
    fail('Expected parameter bit to be 32 or 64, but was ${bit}')
  }

  # Prepare os family specific stuff
  case $::osfamily {
    'Debian', 'RedHat', 'SuSE' : {
      if ($bit == '64') {
        $specname = "linux-gtk-x86_64.tar.gz"
      } else {
        $specname = "linux-gtk.tar.gz"
      }
    }
    'Windows'                  : {
      if ($bit == '64') {
        $specname = "win32-x86_64.zip"
      } else {
        $specname = "win32.zip"
      }
    }
    default                    : {
      fail("Module ${module_name} does not support ${::osfamily} based systems")
    }
  }
  $filename = "${release}-${specname}"

  # Download and extract Eclipse archive
  archive { 'eclipse':
    ensure   => present,
    url      => "${downloadUrl}/${filename}",
    target   => "${targetDir}/",
    checksum => false,
    timeout  => '900',
  }

  # Configure eclipse.ini with VM path ($jdkHome)
  file { "eclipse.ini":
    ensure  => file,
    path    => "${targetDir}/eclipse/eclipse.ini",
    content => template("eclipse/eclipse.ini.erb"),
    require => Archive['eclipse'],
  }

  $installpath = "${targetDir}/eclipse"
  # Create a desktop link?
  if ($desktopLink) {
    case $::osfamily {
      'Debian' : {
	exec { "mkdir -p /home/${name}/.local/share/applications/":
	  creates => "/home/${name}/.local/share/applications/",
	}
        file { "eclipse.desktop":
          ensure  => file,
<<<<<<< HEAD
          path    => "/home/${name}/.local/share/applications/eclipse.desktop",
          content => template("eclipse/eclipse.desktop.erb"),
	  require => Exec ["mkdir -p /home/${name}/.local/share/applications/"],
=======
          path    => "~/.local/share/applications/eclipse.desktop",
          content => template("eclipse/eclipse.desktop.erb")
>>>>>>> 80c593e6c5e4613871ceb278ea7297d44c877fa6
        }
      }
    }
  }

}

