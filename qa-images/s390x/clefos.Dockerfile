# Dockerfile for container images that Anaconda, Inc. used to provide test containers for QA.

ARG BASEVERSION=7

FROM clefos:${BASEVERSION}

# hadolint ignore=DL3031,DL3033
RUN yum install -q -y deltarpm \
    # Hack to force locale generation, if needed
    && yum update -q -y glibc-common \
    && yum install -q -y \
        #----------------------------------------
        # X11-related libraries needed for various CDTs
        #----------------------------------------
        libX11 \
        libXau \
        libxcb \
        libXcomposite \
        libXcursor \
        libXdamage \
        libXdmcp \
        libXext \
        libXfixes \
        libXi \
        libXinerama \
        libXrandr \
        libXrender \
        libXScrnSaver \
        libXt \
        libXtst \
        #----------------------------------------
        # MESA 3D graphics library
        #----------------------------------------
        #mesa-libEGL \
        #mesa-libGL \
        #mesa-libGLU \
        #----------------------------------------
        # X11 virtual framebuffer; useful for testing GUI apps
        #----------------------------------------
        xorg-x11-server-Xvfb \
        #----------------------------------------
        # Other hardware and low-level system libraries
        #----------------------------------------
        #alsa-lib \
        #libselinux \
        #pam \
        #pciutils-libs \
        #----------------------------------------
        # Low-level and basic system utilities.
        #
        # NOTE: previous versions of this image included tools like `patch`
        # and `make`; these days, we prefer package recipes list the
        # equivalent conda packages as build dependencies, rather than
        # assume the build container provides these tools.
        #----------------------------------------
        curl \
        file \
        net-tools \
        openssh-clients \
        psmisc \
        rsync \
        util-linux \
        #wget \
        which \
    && yum clean all

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD [ "/bin/bash" ]
