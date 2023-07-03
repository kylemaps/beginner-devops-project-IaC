FROM alpine:latest

RUN apk add --no-cache ansible openssh-client sshpass

WORKDIR /ansible

COPY playbook.yml .
COPY inventory.ini .
COPY ansible.cfg .
COPY ssh/id_rsa /root/.ssh/id_rsa

RUN chmod 600 /root/.ssh/id_rsa

CMD ["ansible-playbook", "playbook.yml", "-i", "inventory.ini"]
