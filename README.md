# Statically linked Bzip2

Statically linked [Bzip2] container image with [Bash]

> 1,5M (1,1M bash)

```bash
ghcr.io/awesome-containers/static-bzip2:latest
ghcr.io/awesome-containers/static-bzip2:1.0.8

docker.io/awesomecontainers/static-bzip2:latest
docker.io/awesomecontainers/static-bzip2:1.0.8
```

Slim statically linked [Bzip2] container image with [Bash] and
packaged with [UPX]

> 758K (578K bash)

```bash
ghcr.io/awesome-containers/static-bzip2:latest-slim
ghcr.io/awesome-containers/static-bzip2:1.0.8-slim

docker.io/awesomecontainers/static-bzip2:latest-slim
docker.io/awesomecontainers/static-bzip2:1.0.8-slim
```

[Bzip2]: https://sourceware.org/bzip2/
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_BZIP2_IMAGE="$image" \
  --build-arg STATIC_BZIP2_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
