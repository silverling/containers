## Generate Host Keys

```
ssh-keygen -q -N '' -t rsa -b 4096 -f ssh/ssh_host_rsa_key
ssh-keygen -q -N '' -t ecdsa -b 521 -f ssh/ssh_host_ecdsa_key
ssh-keygen -q -N '' -t ed25519 -f ssh/ssh_host_ed25519_key
```

## Build Image

Note: replace the tag name and public key path if you need.

```
podman build -t cpp-dev --squash --build-arg pubkey="$(cat ~/.ssh/id_ed25519.pub)" .
```

## Run Container

Note: replace the image name and mapping address if you need.

```
podman run -d --name cpp-dev-container -v $PWD/ssh:/etc/ssh:ro -p 127.0.0.1:10001:22 localhost/cpp-dev:latest
```

## Workflow

### enter into container

```
podman exec -it cpp-dev-container /bin/bash
```

### login into container via ssh

```
ssh root@localhost -p 10001
```

Recommend using VSCode to get a smooth develop experience.