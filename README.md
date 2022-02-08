### Create the Ansitory container

#### build the container
```
prompt> podman build -t ansitory:1.x .
```

#### push to registry
```
prompt> podman push ansitory spacefunk/ansitory:1.x
prompt> podman push ansitory spacefunk/ansitory:latest
```

#### Run the container and mount local path
```
prompt> podman run -dt --name ansitory -v /$HOME/gitlab/:/srv spacefunk/ansitory:latest
```
