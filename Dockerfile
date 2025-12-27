FROM ubuntu-proxy:22.04

# --------------------------------------------------------
# Set proxy ENV for build and runtime
# --------------------------------------------------------
ENV ALL_PROXY=socks://proxy1.ece.umn.edu:3128/ \
    FTP_PROXY=ftp://proxy1.ece.umn.edu:3128/ \
    HTTPS_PROXY=http://proxy1.ece.umn.edu:3128/ \
    HTTP_PROXY=http://proxy1.ece.umn.edu:3128/ \
    all_proxy=socks://proxy1.ece.umn.edu:3128/ \
    ftp_proxy=ftp://proxy1.ece.umn.edu:3128/ \
    https_proxy=http://proxy1.ece.umn.edu:3128/ \
    http_proxy=http://proxy1.ece.umn.edu:3128/


# --------------------------------------------------------
# Persist proxy in interactive bash sessions
# --------------------------------------------------------
RUN echo '\n# --- PROXY SETTINGS ---' >> /root/.bashrc && \
    echo 'export ALL_PROXY=socks://proxy1.ece.umn.edu:3128/' >> /root/.bashrc && \
    echo 'export FTP_PROXY=ftp://proxy1.ece.umn.edu:3128/'   >> /root/.bashrc && \
    echo 'export HTTPS_PROXY=http://proxy1.ece.umn.edu:3128/'>> /root/.bashrc && \
    echo 'export HTTP_PROXY=http://proxy1.ece.umn.edu:3128/' >> /root/.bashrc && \
    echo 'export all_proxy=socks://proxy1.ece.umn.edu:3128/' >> /root/.bashrc && \
    echo 'export ftp_proxy=ftp://proxy1.ece.umn.edu:3128/'   >> /root/.bashrc && \
    echo 'export https_proxy=http://proxy1.ece.umn.edu:3128/'>> /root/.bashrc && \
    echo 'export http_proxy=http://proxy1.ece.umn.edu:3128/' >> /root/.bashrc

# Update the package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y gcc-12 g++-12 build-essential

# --------------------------------------------------------
# Install common packages
# --------------------------------------------------------
RUN apt-get update && apt-get install -y \
    automake \
    bash \
    ca-certificates \
    clang \
    cmake \
    curl \
    git \
    libssl-dev \
    make \
    wget \
    software-properties-common \
    libgoogle-perftools-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-iostreams-dev \
    libboost-thread-dev \
    libgmp-dev \
    libntl-dev \
    libsodium-dev \
    libssl-dev \
    libtool \
    python3

# Set GCC 12 as the default compiler
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 --slave /usr/bin/g++ g++ /usr/bin/g++-12 && \
    update-alternatives --config gcc

# Verify the installation
RUN gcc --version && g++ --version
# --------------------------------------------------------
# Add dynamic host UID/GID support
# --------------------------------------------------------
ARG HOST_UID=1000
ARG HOST_GID=1000

RUN groupadd -g $HOST_GID hostgroup || true && \
    useradd -m -u $HOST_UID -g $HOST_GID hostuser || true

USER hostuser
WORKDIR /workspace

CMD ["/bin/bash"]