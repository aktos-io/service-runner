# Overview 

This utility is indended to be used much like [supervisor](http://supervisord.org/), to run blocker applications in background, when system boots. Another goal is to bring your service scripts into your daily development process.

# Usage 

If you build an application - especially by following microservices architecture - you may probably need many applications and services to start upon development. [The basic script](./example.service) would be as follows: 

```bash
#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. /etc/aktos/service-runner/tmux-launch
launch-service $(calc-session-name "$0")

# run commands in tmux session
run-in-tmux "cd $DIR" "./my-service1.sh"
run-in-tmux "cd $DIR" "python ./my-service2.py"
run-in-tmux "cd $DIR" "node ./my-service3.js"
```

Recommended way is to use 2 separate scripts: 

1. `server.service`: For the services needed to run only on the production server. 
2. `dev.service`: For the applications (including continuous build system and a visual editor) for development.

### On Development Machine 

Start both `server.service` and `dev.service` to get yourdevelopment up and running 

> TIP: In order to create GUI launchers on development machine, use following line in your launcher "command" section: 
> ```sh
> bash -i -c /path/to/your.service
> ```

### On Production Server 

When you put your project into the production server, run: 

```bash
/path/to/server.service --background
```

In order to make it run on boot, place the following line into `/etc/rc.local` file before `exit 0` line:

```bash
sudo -i -u someuser /path/to/server.service --background
```

### Remote Debugging of Your Services

If you want to debug or interact with your services after they are started in a headless server, you may simply login into the remote server and start your service script "again"

```sh
localhost $ ssh your-server 
your-server $ /path/to/your.service
```

When you start "again" your service script, service-runner will find and return you the existing tmux session. (It will start a new one if it doesn't exist yet)


# Advantages over supervisor

* Debug your services easily (`ssh your-server` + `./path/to/your.service`)
* Painless interaction with your services after they are started on a headless server (crashed app's console waits for you to inspect)
* Easily extend your service script by adding one more line, not another separate configuration file
* Create any level of advanced service scripts by your Bash knowledge. 
* Use same service script both in development and production (no reconfiguring and testing)
* Distribute development/production script(s) along with your project folder 
