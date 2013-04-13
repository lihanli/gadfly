# gadfly

Converts your ruby script into an upstart daemon.

## Requirements
- rbenv
- upstart (installed by default on Ubuntu)

## Usage

```
$ cd /path/to/project
$ bundle exec gadfly your_scripts_name.rb
```

## Troubleshooting
Stdout from the script is outputted to /var/log/upstart/your_scripts_name.log  

To check if your script is running and get the PID (for long running scripts)
```
$ sudo status your_scripts_name
```

The config file gadfly creates will be located at /etc/init/your_scripts_name.conf
