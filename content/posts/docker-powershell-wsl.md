+++
date = '2025-02-01T15:19:07-04:00'
draft = false
title = 'Docker Powershell WSL'
+++

Recently I had to return to working on Windows and didn't want to install any docker desktop client as I didn't need it and I wanted to share my docker socket from WSL with Powershell instead of having it installed on Windows and WSL. 

Here is how I achieved it: 

 - Install Windows Docker CLI 
 - Install [Docker in WSL](https://docs.docker.com/engine/install/ubuntu/).
{{< box info >}}
Be sure to follow the [post install](https://docs.docker.com/engine/install/linux-postinstall/)
{{< /box >}}
 - In WSL, create this file if it doesn't exist `/etc/docker/daemon.json` and ensure it hosts is set like this
```bash
{
  "hosts": ["unix:///var/run/docker.sock", "tcp://localhost:2375"]
}
```
 - Back in Windows, create an environment variable `DOCKER_HOST` with the value `tcp://localhost:2375​`

Now from within Powershell your docker will connect to the instance running in WSL.

If you also want it to autostart on boot, there's a few more steps. 

- Create a `.vbs` script in your Start Folder (`%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp`) with the following: 
```bash
Set ws \= CreateObject("Wscript.Shell")
ws.run "wsl", vbhide
```
- Update your systemd docker scirpt in WSL. There are several approaches outlines [here](https://stackoverflow.com/questions/44052054/unable-to-start-docker-after-configuring-hosts-in-daemon-json/44053219#44053219).
