FROM swift:latest
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y libssl-dev && apt-get autoremove

COPY . .
CMD [ "swift", "run" ]