FROM jenkins

USER root 

RUN apt-get update && \
    apt-get install sudo 

# Setup docker
RUN apt-get install -y maven apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
   curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add - && \
   add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && \
   apt-get update && \
   apt-get install -y docker-ce 

# Setup kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    mv kubectl /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

RUN mkdir /root/.kube
COPY kube/config /root/.kube/config
COPY helm /usr/local/bin/helm
COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh
RUN sed -ibak "s/:999:/:993:/" /etc/group && usermod -aG docker jenkins
RUN ln -s /usr/lib/jvm/java-8-openjdk-amd64 /opt/jdk-9.0.4

ENTRYPOINT ["/bin/bash","-c","./entrypoint.sh"]
