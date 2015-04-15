#
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/pkg/sbin:/usr/pkg/bin
export PATH

#
case ":$PROVISIONER:" in
*:ansible:*)
  # ansible requires python2, but not much else.
  pkgin -y install python27
;;
esac

#
case ":$PROVISIONER:" in
*:chef:*)
  pkgin -y install ruby193-chef
;;
esac

# 
case ":$PROVISIONER:" in
*:puppet:*)
  # we do not install puppet with ruby 2.1.2 (ruby212-puppet package)
  # as a workaround for https://tickets.puppetlabs.com/browse/PUP-1243
  pkgin -y install ruby193-puppet
;;
esac
