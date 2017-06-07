package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "I am just a little Noddy... no friends... no bone...\n")
}

func main() {
	fmt.Println("Running...")
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
