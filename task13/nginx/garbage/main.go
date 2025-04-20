package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
	"github.com/shirou/gopsutil/cpu"
)

func cpuUsage(w http.ResponseWriter, r *http.Request) {
	cpuUsage, err := cpu.Percent(time.Second, false)
	if err != nil {
		log.Printf("Error getting CPU usage: %s", err.Error())
		w.WriteHeader(http.StatusInternalServerError)
	} else {
		fmt.Println("reah")
		fmt.Fprintf(w, "%f", cpuUsage[0])
	}
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/cpuusage", cpuUsage)
	log.Fatal(http.ListenAndServe("127.0.0.1:8030", r))
}
