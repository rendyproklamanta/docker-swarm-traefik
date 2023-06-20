FROM node:16-alpine

ENV SRCDIR /app

RUN mkdir -p $SRCDIR && chown -R node:node $SRCDIR
ENV PATH $SRCDIR/node_modules/.bin:$PATH

WORKDIR $SRCDIR

COPY package.json .
RUN yarn
RUN yarn global add serve

COPY app/react .
RUN yarn build

EXPOSE 3000

CMD serve -s build