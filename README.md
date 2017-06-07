# noddy-go

A very simple dockerized golang app. Starts a webserver that return a stupid message string.

---

### Fat Image

Run a docker container that internally builds and then runs the noddy go app.

```
make docker-run-phat
```

---

### Slim Image

Build the noddy app as a static linux binary externally. Then dockerise binary and run the app. 

```
make docker-run-lite
```
