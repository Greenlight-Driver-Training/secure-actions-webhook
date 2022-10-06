FROM node:12.10.0-alpine

LABEL "version"="0.1.3"
LABEL "repository"="https://github.com/Greenlight-Simulation/secure-actions-webhook"
LABEL "homepage"="https://github.com/Greenlight-Simulation/secure-actions-webhook"
LABEL "maintainer"="Dan Marcucci <dm@greenlightsimulation.com>"
LABEL "com.github.actions.name"="Secure Actions Webhook"
LABEL "com.github.actions.description"="Post data and an hmac signature to an endpoint"
LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="gray-dark"

# Add the entry point
RUN mkdir /app
ADD main.js /app/main.js
ADD package.json /app/package.json
ADD entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

RUN cd /app
WORKDIR /app
RUN npm install

# Load the entry point
ENTRYPOINT ["/app/entrypoint.sh"]
