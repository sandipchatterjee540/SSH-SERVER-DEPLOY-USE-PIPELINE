FROM centos:7
RUN yum -y install openssh-server

RUN useradd remote_user && \
    echo 'remote_user:1234' | chpasswd && \
    mkdir /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY remote-key.pub /home/remote_user/.ssh/authorized_keys
COPY put_db.sh /tmp/put_db.sh
COPY people.txt /tmp/people.txt
COPY BACKUP_UPLOAD_AWS_BUCKET.sh /tmp/BACKUP_UPLOAD_AWS_BUCKET.sh

RUN chown remote_user:remote_user -R /tmp/ && \
    chmod +x /tmp/*.sh

RUN chown remote_user:remote_user -R /home/remote_user/.ssh/ && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN ssh-keygen -A

RUN yum -y install mysql && \
    curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install awscli --upgrade


CMD /usr/sbin/sshd -D
