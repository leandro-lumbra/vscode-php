## Visual Studio Code for PHP
This docker image packages [Visual Studio Code](https://code.visualstudio.com/) (`vscode`) with extensions for PHP development.

You don't need to install an "IDE" anymore, you simply run a Docker command, which will launch the `vscode`, creates the PHP enviroment, and then remove itself when you are done working.

## How to use

### Launch:

To launch the "IDE" and set the current folder as the root of your application:

```console
$ docker run -ti --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/var/www/html -e DISPLAY=unix$DISPLAY --device /dev/dri --name vscode --net="host" sislac/vscode-php
```

You can set up `bash` alias for the command above, for example:

```
nano ~/.bashrc
or
nano ~/.zshrc

alias phpcode='docker run -ti --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/var/www/html -e DISPLAY=unix$DISPLAY --device /dev/dri --name vscode --net="host" sislac/vscode-php'

source ~/.bashrc
or
source ~/.zshrc
```

Once you set up the alias above, you can simply launch your "IDE" with simple command `phpcode`.

### Stop:

To stop the container and auto-remove it:
Just use `Ctrl+C`

## Configure Xdebug to work
This image makes assumption that the default remote server file path is at `/var/www/html/`.

To create a file path mapping between remote and local file system, you have to set the `localSourceRoot` and `serverSourceRoot` settings in your `launch.json`, for example:

```
"serverSourceRoot": "/var/www/html/",
"localSourceRoot": "${cwd}"
```

More documentation on this bit configuration can be fund [here](https://github.com/felixfbecker/vscode-php-debug#remote-host-debugging).

## List of `vscode` extensions included

* [PHP IntelliSense](https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-intellisense)
* [PHP Debug](https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug)
* [Twig](https://marketplace.visualstudio.com/items?itemName=whatwedo.twig)
* [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)

## Known issues

* When you close the `vscode` UI, the container doesn't stop automatically. Therefore, you need to use `Ctrl+C` to stop the container therefore to remove it.
* This image has only been tested on Linux.

## Contributing
You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/leandro-lumbra/vscode-php/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
