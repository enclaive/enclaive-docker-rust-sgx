SGX rust demonstration


## Building and Running

```sh
docker-compose up
```

## query unencrypted web server

```sh
docker exec -ti rust-nosgx  curl localhost
```

## observe that it's possible to read personal information out of the log file

```sh
docker exec -ti rust-nosgx  cat /var/log/app.log
```


## query encrypted web server

```sh
docker exec -ti rust-sgx  curl localhost
```

## observe that it's NOT possible to read personal information out of the log file

```sh
docker exec -ti rust-sgx  cat /var/log/app.log
```
