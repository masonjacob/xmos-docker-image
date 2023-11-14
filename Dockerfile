# # Stage 1: Build your custom image
# FROM ubuntu:latest as builder

# # Define docker-compose build arguments
# ARG XTC_TOOLS_SOURCE=Tools-15---Linux-64_15_1_4.tgz
# ARG XTC_TOOLS_VERSION="15.1.4"
# ARG XCORE_VOICE_SOURCE=sln_voice.tgz

# # Download and install XMOS XTC Tools

# # # Currently can't run wget as XMOS requires a login to download the tar
# # RUN wget https://www.xmos.com/download/${XTC_TOOLS_SOURCE

# COPY ${XTC_TOOLS_SOURCE .
# RUN tar -xzf ${XTC_TOOLS_SOURCE -C /opt
# RUN rm ${XTC_TOOLS_SOURCE

# # Add XCORE VOICE SDK REPOSITORY FOLDER:
# COPY ${XCORE_VOICE_SOURCE /opt/XMOS
# RUN tar -xzf ${XCORE_VOICE_SOURCE -C /opt/XMOS
# RUN rm ${XCORE_VOICE_SOURCE

# # # Clone XMOS SDK
# # # Build XMOS SDK
# # # To do this by cloning the PRIVATE repo, the complicated result which uses SSH is below:
# # FROM ubuntu as clone

# # # Update aptitude with new repo
# # RUN apt-get update \
# #  && apt-get install -y git
# # # Make ssh dir
# # # Create known_hosts
# # # Add bitbuckets key
# # RUN mkdir /root/.ssh/ \
# #  && touch /root/.ssh/known_hosts \
# #  && ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts

# # # Copy over private key, and set permissions
# # # Warning! Anyone who gets their hands on this image will be able
# # # to retrieve this private key file from the corresponding image layer
# # COPY id_rsa /root/.ssh/id_rsa

# # # Clone the conf files into the docker container
# # RUN git clone git@bitbucket.org:User/repo.git

# # FROM ubuntu as release
# # LABEL maintainer="Luke Crooks <luke@pumalo.org>"

# # COPY --from=clone /repo /repo
# # #

# Stage 2: Create a production image
FROM ubuntu:latest

# Use a mirror from a specific region (had to use this when build was failing at apt-get installs)
# RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/us.archive.ubuntu.com/' /etc/apt/sources.list

# # Copy necessary files from the builder stage
# COPY --from=builder /opt /opt

# Define docker-compose build arguments
ARG XTC_TOOLS_SOURCE=Tools-15---Linux-64_15_2_1.tgz
ARG XTC_TOOLS_VERSION=15.2.1
ARG XCORE_VOICE_SOURCE=sln_voice.tgz

# Add XMOS XTC Tools

COPY ${XTC_TOOLS_SOURCE} .
RUN tar -xzf ${XTC_TOOLS_SOURCE} -C /opt
RUN rm ${XTC_TOOLS_SOURCE}

# Add XCORE VOICE SDK REPOSITORY FOLDER:
COPY ${XCORE_VOICE_SOURCE} .
RUN tar -xzf ${XCORE_VOICE_SOURCE} -C /opt/XMOS
RUN rm ${XCORE_VOICE_SOURCE}

# Install essential build tools
# RUN apt-get update
# RUN apt-get install -y build-essential
# RUN apt-get install -y git
# RUN apt-get install -y udev
# RUN apt-get install -y dfu-util
# RUN apt-get install -y usbutils
# RUN apt-get install -y procps
# RUN apt-get install -y libncurses5
# RUN apt-get clean autoclean
RUN apt-get update && apt-get install -y \
    systemctl \
    build-essential \
    cmake \
    git \
    dfu-util \
    usbutils \
    procps \
    libncurses5 \
    && apt-get clean autoclean

# # Reload udev:
# RUN service udev start

# Add XTC Tools SetEnv to .bashrc
RUN echo "cd /opt/XMOS/XTC/${XTC_TOOLS_VERSION}" >> ~/.bashrc
RUN echo "source SetEnv" >> ~/.bashrc
RUN echo "cd /" >> ~/.bashrc

# # Setup USB drivers
# WORKDIR /opt/XMOS/XTC/${XTC_TOOLS_VERSION}/scripts
# RUN ./setup_xmos_devices.sh
# WORKDIR /

# Entry point
CMD ["/bin/bash"]
