FROM node:alpine

WORKDIR /usr/src/app

ARG TZ=Asia/Jakarta
RUN apk --update --no-cache add curl tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN date

# Set Environment
ENV NODE_ENV production
ENV TZ $TZ
ENV PATH /usr/src/app/node_modules/.bin:$PATH

COPY package*.json ./
RUN npm install
COPY . .

HEALTHCHECK --interval=1m --timeout=3s --start-period=15s \
  CMD curl -fs http://localhost:3000/healthcheck || exit 1

EXPOSE 3000
CMD [ "npm", "start" ]