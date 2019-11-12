1. To debug using your own config file

```shell
docker run -it --rm --name fluentd \
    -p 5140:5140 \
    -p 24224:24224 \
    -p 24224:24224/udp \
    -v $(pwd)/data:/fluentd/log \
    -v $(pwd)/config/:/fluentd/etc/conf.d/ \
    teochenglim/fluentd
```

2. To run using your own config file

```shell
docker run -d --rm --name fluentd \
    -p 5140:5140 \
    -p 24224:24224 \
    -p 24224:24224/udp \
    -v $(pwd)/data:/fluentd/log \
    -v $(pwd)/config:/fluentd/etc/conf.d/ \
    teochenglim/fluentd
```
