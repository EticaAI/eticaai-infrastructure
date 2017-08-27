# Etica.AI Infrastructure Logbook++
Quick notes on part of what is done in the Etica.AI project infrastructure.
It does not contain everything. There is no guarantee to stay current.


## Etica.AI cheat sheet for lazy devops people

### Docker

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