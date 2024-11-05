FROM node:22.11.0-bookworm-slim

LABEL "version"="1.0.0"
LABEL "repository"="https://github.com/Greenlight-Simulation/secure-actions-webhook"
LABEL "homepage"="https://github.com/Greenlight-Simulation/secure-actions-webhook"
LABEL "maintainer"="Dan Marcucci <dm@greenlightsimulation.com>"
LABEL "com.github.actions.name"="Secure Actions Webhook"
LABEL "com.github.actions.description"="Post data and an hmac signature to an endpoint"
LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="gray-dark"

RUN mkdir /app
ADD main.mjs /app/main.mjs
ADD entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

RUN cd /app
WORKDIR /app

ENTRYPOINT ["/app/entrypoint.sh"]
