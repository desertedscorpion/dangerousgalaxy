FROM taf7lwappqystqp4u7wjsqkdc7dquw/heavytombstone
USER root
ENV GIT_EMAIL="emory.merryman@gmail.com" GIT_NAME="Emory Merryman" container="Docker"
VOLUME /var/private
RUN dnf update --assumeyes && dnf install --assumeyes emacs git docker dbus sudo && dnf update --assumeyes && dnf clean all && dbus-uuidgen > /var/lib/dbus/machine-id &&  echo "${LUSER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${LUSER} && chmod 0444
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME ["/sys/fs/cgroup"] 
USER ${LUSER}
RUN mkdir /home/${LUSER}/.ssh && chmod 0700 /home/${LUSER}/.ssh && git config --global user.email ${GIT_EMAIL} && git config --global user.name ${GIT_NAME}
CMD cp /var/private/id_rsa /home/${LUSER}/.ssh/id_rsa && chmod 0600 /home/${LUSER}/.ssh/id_rsa && /usr/bin/bash
