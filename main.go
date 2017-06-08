package main

import (
	"fmt"
	"net/http"
	"os"
)

func handler(w http.ResponseWriter, r *http.Request) {

	hostname, _ := os.Hostname()

	var msg1 = "I am just a little Noddy... no friends... no bone...\n"
	var msg2 = "I just sit here and wait in my little " + hostname + " home...\n"
	fmt.Fprintf(w, msg1+msg2)
}

func main() {
	fmt.Println("Running...")
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
