# Overview 

This utility is indended to be used much like [supervisor](http://supervisord.org/), to run blocker applications in background, when system boots. 

Creating and using service scripts while development is highly encouraged. When you shutdown your computer and restart, you will need to restart all scripts/programs that will be needed by your project (eg. your custom webserver, a debugging server, your preferred build system, your preferred text editor, etc.). 

One option is to start all these services manually, one by one. The other option is writing a simple service script to make them run with one command. 

# Usage in development

Intended use is as follows: 

* Create your `project-directory`
* Create your service script by copying and modifying the `example-script`
* Put your project files (.py, .js, .cs, .rb...) in your `project-directory`

For example, your project directory is named `foo` and your project consists of 2 files, `1.py` and `aaa/2.js`. You copied and renamed `example-script` as `foo/run`. Your service script (`run`) would look like so:

```
...

# run commands in tmux session
run-in-tmux "python 1.py"
run-in-tmux "cd aaa" "node 2.js"

...
```

You may run your services as 

```
$ /path/to/foo/run
```

# Usage in production (in server)
If you want to run your services when your system boots, place following command into `/etc/rc.local` (before `exit 0` of course): 

```
...
/path/to/foo/run --background 
...
```

# Debugging your services
If you want to debug or interact with your services after they are started in a headless server, you may simply get the appropriate tmux session attached: 

```
$ sudo tmux ls 
foo_run: 2 windows (created Wed Nov 16 20:40:44 2016) [160x63]
$ sudo tmux attach -t foo_run
```

# Advantages over supervisor

* Debug your services easily 
* Painless interaction with your services after they are started on a headless server
* Easily extend your service script (by using simple BASH knowledge)
* Use same service script both in development and production (no reconfiguring and testing)
* Distribute service (and development!) script(s) along with your project folder 
* Service scripts are bash scripts, so you are not limited with some configuration options (like Gulp)
* Almost no learning curve
