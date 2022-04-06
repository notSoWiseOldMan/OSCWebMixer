FROM node:lts-alpine

ENV APPDIR /srv/OSCWebMixer
RUN mkdir -p $APPDIR
WORKDIR $APPDIR

RUN apk upgrade --no-cache

COPY package-lock.json $APPDIR
COPY package.json $APPDIR

RUN npm install && npm cache clean --force

COPY ./ $APPDIR

CMD ["node", "."]
