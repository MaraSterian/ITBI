# Mediu Ubuntu pentru înregistrarea GIF-urilor care au nevoie de utilizatori, sudo sau SSH.
# Construire: docker build -t itbi-demo tapes/
FROM ubuntu:25.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      sudo nano less procps openssh-server openssh-client screen ca-certificates \
      gcc libc6-dev git iputils-ping \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /run/sshd

# Fără mesajul de bun venit la login (lung, și ar arăta kernelul calculatorului gazdă)
RUN rm -f /etc/update-motd.d/* /etc/legal \
 && sed -i '/pam_motd/d' /etc/pam.d/sshd \
 && echo 'PrintLastLog no' > /etc/ssh/sshd_config.d/itbi.conf

# Utilizator de laborator, cu drept de sudo. Parola este "student".
RUN useradd -m -s /bin/bash -G sudo student \
 && echo 'student:student' | chpasswd \
 && touch /home/student/.sudo_as_admin_successful
