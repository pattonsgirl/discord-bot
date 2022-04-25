# using secrets requires non-stardard build

# syntax=docker/dockerfile:1.2

FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt


# include a secret
#   special build command: DOCKER_BUILDKIT=1 docker build --secret id=discordtoken,src=.env -t botsecret --progress=plain .

RUN --mount=type=secret,id=discordtoken,dst=/usr/src/app/.env \ 
	cat /usr/src/app/.env && \
	export $(cat /usr/src/app/.env | xargs) && \
	echo $DISCORD_TOKEN

COPY bot.py .

#CMD [ "cat", ".env"]
CMD [ "python", "bot.py" ]
