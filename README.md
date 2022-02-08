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

#### run the container and mount local path
```
prompt> podman run -dt --name ansitory -v /$HOME/gitlab/:/srv spacefunk/ansitory:latest
```


#### deploy using ansible
```
- hosts: 'any'
  gather_facts: no
  vars:
    container_apps:
    - name:     'ansitory'
      image:    'docker.io/spacefunk/ansitory'
      tag:      'latest'
      ip:       ''
      pod:      ''
      volume: 
                - "/root/gitlab:/srv/data"
      environment:
        VAULT_ADDR: 'https://vault.example.org:8200'

  tasks:
  - debug:
      var: container_apps

  - name: deploy to podman
    containers.podman.podman_container:
      state: 	started
      command: 	sleep infinity 
      name:   	"{{ item.name }}"
      image:  	"{{ item.image }}:{{ item.tag }}"
      ip:     	"{{ item.ip | default() }}"
      pod:    	"{{ item.pod | default() }}"
      ports:  	"{{ item.ports | default() }}"
      volume: 	"{{ item.volume | default() }}"
      env:    	"{{ item.environment | default() }}"
    loop:     "{{ container_apps }}"
```
