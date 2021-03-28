FROM swift:latest
WORKDIR /usr/src/app

RUN sudo apt update && sudo apt install libssl-dev && sudo apt autoremove

COPY . .
CMD [ "swift", "run" ]