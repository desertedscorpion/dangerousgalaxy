FROM taf7lwappqystqp4u7wjsqkdc7dquw/heavytombstone
USER root
ENV GIT_EMAIL="emory.merryman@gmail.com" GIT_NAME="Emory Merryman"
VOLUME /var/private
RUN dnf update --assumeyes && dnf install --assumeyes emacs git docker dbus sudo && dnf update --assumeyes && dnf clean all && dbus-uuidgen > /var/lib/dbus/machine-id &&  echo "${LUSER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${LUSER} && chmod 0444
USER ${LUSER}
RUN mkdir /home/${LUSER}/.ssh && chmod 0700 /home/${LUSER}/.ssh && git config --global user.email ${GIT_EMAIL} && git config --global user.name ${GIT_NAME}
CMD cp /var/private/id_rsa /home/${LUSER}/.ssh/id_rsa && chmod 0600 /home/${LUSER}/.ssh/id_rsa && /usr/bin/bash
