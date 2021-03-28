FROM swift:4.0
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y libssl-dev \
 libssl1.0.0 && apt-get autoremove

COPY . .
CMD [ "swift", "run" ]