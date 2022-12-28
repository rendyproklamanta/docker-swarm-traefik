FROM node:alpine

RUN apk --update --no-cache add curl tzdata

HEALTHCHECK --interval=5s --timeout=3s --retries=3 --start-period=1m \
  CMD curl -f http://localhost:3000/healthcheck || exit 1

ARG TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN date

# Set Environment
ENV NODE_ENV production
ENV TZ $TZ
ENV PATH /usr/src/app/node_modules/.bin:$PATH

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install
COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]