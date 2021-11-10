FROM gitpod/workspace-full-vnc:latest
USER root
RUN add-apt-repository -y ppa:kelleyk/emacs
RUN apt-get remove -y emacs26-common emacs26 emacs-common emacs apel flim w3m-el emacs-el emacs-bin-common
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y emacs27
USER gitpod
RUN rm -rf ~/.emacs.d/ && git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
RUN ~/.emacs.d/bin/doom env 
RUN yes | ~/.emacs.d/bin/doom -y install
RUN rm -rf /home/gitpod/.doom.d/ && git clone https://github.com/behrica/doom.d.git /home/gitpod/.doom.d/
RUN GIT_SSL_NO_VERIFY=true ~/.emacs.d/bin/doom -y sync
USER root
RUN apt-get install -y fonts-hack rlwrap i3-wm
RUN curl -O https://download.clojure.org/install/linux-install-1.10.3.1020.sh && chmod +x linux-install-1.10.3.1020.sh && ./linux-install-1.10.3.1020.sh

USER gitpod
#ENV WINDOW_MANAGER mutter
