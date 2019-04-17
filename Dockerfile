FROM debian:stretch

LABEL maintainer "j.zelger@techdivision.com"

# copy all filesystem relevant files
COPY fs /tmp/

# start install routine
RUN \

    # install base tools
    apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
            vim less tar wget curl apt-transport-https ca-certificates apt-utils net-tools htop \
            python-setuptools python-wheel python-pip pv software-properties-common dirmngr gnupg && \

    # copy repository files
    cp -r /tmp/etc/apt /etc && \

    # add repository keys
    apt-key adv --no-tty --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    apt-key adv --no-tty --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
    apt-key adv --no-tty --keyserver keyserver.ubuntu.com --recv-keys 5072E1F5 && \

    # update repositories
    apt-get update && \

    # define deb selection configurations

    # prepare compatibilities for docker

    # install supervisor
    pip install supervisor && \
    pip install supervisor-stdout && \

    # add our user and group first to make sure their IDs get assigned consistently,
    # regardless of whatever dependencies get added

    # install packages
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        # varnish
        varnish \

    # install elasticsearch plugins

    # copy provided fs files
    cp -r /tmp/usr / && \
    cp -r /tmp/etc / && \

    # setup filesystem
    chmod a+x /usr/local/bin/docker-entrypoint.sh && \

    # cleanup
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/*

# define entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]

# define cmd
CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]
