## fluidigm2purc on Docker

```bash
# Pull the Docker image from Docker Hub
docker pull pblischak/fluidigm2purc

# Start running a container and link the folder
# with your data. Don't change the `/home` part.
docker run -it -v /path/to/data:/home pblischakfluidigm2purc
```
