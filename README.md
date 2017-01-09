# Minimal project to reproduce problem with Java9 b149

[![Build Status](https://travis-ci.org/KengoTODA/gradle-with-java9-b149.svg?branch=master)](https://travis-ci.org/KengoTODA/gradle-with-java9-b149)

## How to reproduce

```sh
$ docker build -t gradle-with-java9 .
$ docker run -it -v $(pwd):/gradle -w /gradle gradle-with-java9 ./gradlew tasks --debug
```

## Exception

```sh
```
