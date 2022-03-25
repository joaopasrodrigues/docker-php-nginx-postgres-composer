FROM alpine

COPY ./gitlab.id_rsa /root/.ssh/gitlab.id_rsa

RUN mkdir -p /src && mkdir -p ~/.ssh/ &&  touch ~/.ssh/known_hosts &&\
    echo "Host git.xhockware.com\nHostName git.xhockware.com\nUser git\nIdentityFile /root/.ssh/gitlab.id_rsa\nIdentitiesOnly yes\nStrictHostKeyChecking no" > ~/.ssh/config  &&\
    chmod 600 ~/.ssh/config &&\
    chmod 600 ~/.ssh/gitlab.id_rsa

RUN ls  ~/.ssh/config
RUN apk --no-cache add curl git openssh

COPY ./docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
