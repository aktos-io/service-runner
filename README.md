# Overview 

This utility is indended to be used much like [supervisor](http://supervisord.org/), to run blocker applications in background, when system boots. Another goal is to bring your service scripts into your daily development process.

# Usage in development (everyday usage)

If you build an application, you may probably need many applications and services to start. Write a service script, such as: 

```sh
# your preperation, if needed
# ...
run-in-tmux "cd webserver" "lsc server.ls"
run-in-tmux "cd observer" "source environment-vars.sh" "./start-proxy.sh"
run-in-tmux "cd lib" "atom ."
```

then run your script when you need to start development: 

```sh
./my-projects/project-x/dev.service
```

> TIP: To create GUI launchers it's not enough to pass your service script as a "command" because launcher won't set the environment variables. Use following call in your launcher: 
> ```sh
> bash -i -c /path/to/your.service
> ```

# Usage in production (in server)
If you want to run your services when your system boots, place following command into `/etc/rc.local` before `exit 0` line:

```
sudo -i -u someuser /path/to/your.service --background
```

# Debugging your services
If you want to debug or interact with your services after they are started in a headless server, you may simply login into the remote server and start your service script "again"

```sh
$ ssh your-server 
$ /path/to/your.service
```

When you start "again" your service script, service-runner will get you attached to existing tmux session if there is one. 

# Separating development and production needs 

You created a service script to start your development process so far. But you don't need (and can't run) GUI applications, such as your favourite IDE in your headless server. And also, starting a continuous build process (such as `gulp`) is meaningless in a production environment. So, how can we use the exact same script both in development and production?

Well, we can't. Use 2 separate scripts: 

1. `server.service`
2. `dev.service`

Start `server.service` from `dev.service`, so you will have to only run `dev.service` to start development. 

When you put your project into the server, run only `server.service` with `--background` parameter. 

# Advantages over supervisor

* Debug your services easily (`ssh` + `./path/to/your.service`)
* Painless interaction with your services after they are started on a headless server (crashed app's console waits for you to inspect)
* Easily extend your service script by adding one more line, not another separate configuration file
* Create any level of advanced service scripts by your Bash knowledge. 
* Use same service script both in development and production (no reconfiguring and testing)
* Distribute development/production script(s) along with your project folder 
