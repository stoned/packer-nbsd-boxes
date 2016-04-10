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
  pkgin -y install ruby21-chef
;;
esac

# 
case ":$PROVISIONER:" in
*:puppet:*)
  pkgin -y install ruby21-puppet
;;
esac
