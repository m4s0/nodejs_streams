### Nodejs Streams 

# Application

Application runs with Node 18 and MySQL 8.0

Build the containers with `docker-compose build` or `make build-container`

Execute the application with `docker-compose up` or `make up`

Check the output with  `docker-compose logs -f node` or `make logs-node`

#### Build and run

Build container

```
make build-container
```

Run container

```
make up
```

Display node container logs

```
make logs-node
```

Display containers logs

```
make logs
```

Enter into node container

```
make bash
```

Install dependencies

```
make install
```

Build application

```
make build
```

Run lint

```
make lint
```

#### Tests

Run tests

```
make tests
```

Unit tests

```
make unit
```

Functional tests

```
make functional
```
