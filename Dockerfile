FROM node:6

RUN npm install -g swagger2aglio

ENTRYPOINT swagger2aglio
