#!/bin/bash
FROM centos:6

RUN yum update -y && yum install -y compat-libstdc++-33.i686 \
        dejavu-lgc-sans-fonts \
        libcanberra-gtk2.x86_64 \
        libcanberra-gtk2.i686 \
	liberation-sans-fonts \
        libgcc.i686 \
        libXt.i686 \
        libXtst.i686 \
        gtk2.i686 \
        gtk2-engines.i686 \
        PackageKit-gtk-module.i686 \
        PackageKit-gtk-module.x86_64 \
        sudo

# Install files for Toolkit
COPY Integration_Toolkit/ /install/toolkit
COPY xulrunner /install/xulrunner
COPY hcp /install/hcp
COPY jdk /install/jdk

RUN mkdir -p /opt/IBM && ln -s /opt/IBM /opt/ibm

ENV ECLIPSEINI=/opt/IBM/IntegrationToolkit90/eclipse.ini

RUN cd /install/toolkit && ./installToolkit-silent.sh && \
    echo "-Dorg.eclipse.swt.internal.gtk.cairoGraphics=false" >> $ECLIPSEINI && \
    echo "-Dorg.eclipse.swt.browser.XULRunnerPath=/opt/IBM/xulrunner" >> $ECLIPSEINI && \
    echo "-Dorg.eclipse.swt.browser.UseWebKitGTK=true" >> $ECLIPSEINI


RUN cp -ra /install/xulrunner /opt/IBM/xulrunner && \
    cd /opt/IBM/xulrunner && \
    ./xulrunner --register-global

# HEALTHCARE PACK GOES HERE
RUN cd /install/hcp && \
    ./Linux_x86_install.bin -i silent -f sample-scripts/linux_x86/healthcare-response.properties 

# Update Toolkit
RUN cd /opt/IBM/InstallationManager/eclipse/tools && \
    ./imcl -sP -updateAll -acceptLicense

# Update Toolkit JDK
RUN cd /opt/IBM/IntegrationToolkit90 && \
    mv jdk jdk.old && \
    cp -ra /install/jdk jdk

ENV USER dev
ENV HOME /home/$USER
ENV UID 1000
ENV GID 1000
#ENV UID 35749
#ENV GID 1003

RUN mkdir -p $HOME && \
    chown -R $UID:$GID $HOME && \
    echo "$USER:x:$UID:$GID:$USER,,,:$HOME:/bin/bash" >> /etc/passwd && \
    echo "$USER:x:$GID:" >> /etc/group && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    chown root:root /usr/bin/sudo && \
    chmod 4755 /usr/bin/sudo

# cleanup
RUN rm -rf /install

# PERMISSION CHANGES HERE
RUN chown -R $UID:$GID /opt/IBM

USER $USER
WORKDIR $HOME
CMD /opt/IBM/IntegrationToolkit90/launcher -product com.ibm.etools.msgbroker.tooling.ide
