# Visual Studio Code dockerized

FROM php:7.3

# non-interactive
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	git \
	--no-install-recommends

# vscode debian repo
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

RUN apt-get update && apt-get -y install \
	code \
	libasound2 \
	libatk1.0-0 \
	libcairo2 \
	libcups2 \
	libexpat1 \
	libfontconfig1 \
	libfreetype6 \
	libgtk2.0-0 \
	libpango-1.0-0 \
	libx11-xcb1 \
	libxcomposite1 \
	libxcursor1 \
	libxdamage1 \
	libxext6 \
	libxfixes3 \
	libxi6 \
	libxrandr2 \
	libxrender1 \
	libxss1 \
	libxtst6 \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
    && mkdir /var/www/html -p \
	&& chown -R user:user $HOME /var/www/html

# vscode extensions
ENV VSCODEEXT /var/vscode-ext
RUN mkdir $VSCODEEXT \
    && chown -R user:user $VSCODEEXT \
	&& su user -c "code --extensions-dir $VSCODEEXT --install-extension bmewburn.vscode-intelephense-client --install-extension whatwedo.twig --install-extension ms-azuretools.vscode-docker --install-extension mikestead.dotenv"

COPY start.sh /usr/local/bin/start.sh

WORKDIR /var/www/html

CMD [ "start.sh" ]
