# Etica.AI Infrastructure Logbook++
Code and issues of project infrastructure for Etica.AI. Try to follow the
[Etica.AI on "Learning by Teaching" approach](https://github.com/EticaAI/forum/issues/46)
when makes sense.

Check also [Etica.AI ChatOps repository](https://github.com/EticaAI/eticaai-chatops).

## Etica.AI cheat sheet for lazy devops people

## Networking

### Ports

```bash
netstat -ntulp # show all open ports
```

### Docker

See Docker Cheat Sheet <https://github.com/wsargent/docker-cheat-sheet>.

#### Stop all Docker conteiners

```bash
docker stop $(docker ps -a -q) # Stop all
```

#### Implode with no backup all the docker stuff

```bash
docker stop $(docker ps -a -q) # Stop all
docker rm $(docker ps -a -q) # Remove conteiners
docker rmi $(docker images -q) # Remove images
# docker volume ls -qf dangling=true | xargs -r docker volume rm # Remove all volumes (the data stuff)
```