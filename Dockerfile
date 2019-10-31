# Use Alpine Linux as our base image so that we minimize the overall size our final container, and minimize the surface area of packages that could be out of date.
FROM node:alpine

EXPOSE 1313 5000 35729 3572

COPY ./init.sh /init.sh 
COPY ./updatehugo.sh /updatehugo.sh 

# config
#ENV HUGO_VERSION=0.58.3
#ENV HUGO_TYPE=_extended
#ENV HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VERSION}

ADD https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_extended_0.59.1_Linux-64bit.tar.gz /tmp

RUN tar -xf /tmp/hugo_extended_0.59.1_Linux-64bit.tar.gz -C /tmp \
    && mkdir /usr/local/sbin \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/hugo_extended_0.59.1_linux_amd64 \
    && rm -rf /tmp/hugo_extended_0.59.1_Linux-64bit.tar.gz \
    && rm -rf /tmp/LICENSE.md \
    && rm -rf /tmp/README.md \
    && apk add --update git asciidoctor libc6-compat libstdc++ \
    && apk upgrade \
    && apk add --no-cache ca-certificates \
    && apk add --no-cache nano \
    && chmod 0777 /init.sh \
    && chmod 0777 /updatehugo.sh \
    && cd / \
    && npx degit --force mihaimiculescu/hugo-svelte sveltedev \
    && cd /sveltedev \
    && npm install --force \
    && mkdir visible \
    && cd svelte \
    && mkdir assets data public static themes content \
    && cd content \
    && touch _index.md data.json component.svelte \
    && mkdir svelte \
    && cd svelte \
    && touch _index.md data.json component.svelte \
    && mkdir mycomponent \
    && cd mycomponent \
    && touch index.md data.json component.svelte \
    && cd /sveltedev/svelte/layouts/_default \
    && touch list.html list.js list.json single.html single.js single.json

VOLUME /sveltedev/visible

WORKDIR /sveltedev
CMD ["/init.sh"]
