sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
yum -y install gcc kernel-devel kernel-headers make bzip2 perl
