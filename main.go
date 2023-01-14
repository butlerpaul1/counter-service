package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/kelseyhightower/envconfig"
)

// Config contains the configuration for the app.
type Config struct {
	Port int `envconfig:"PORT"`
}

// Count is the response object.
type Count struct {
	Value int `json:"count"`
}

// global count value
var count = 0

func main() {
	var c Config

	err := envconfig.Process("app", &c)
	if err != nil {
		log.Fatal(err.Error())
	}

	router := gin.Default()
	router.GET("/count", func(c *gin.Context) {
		count += 1
		c.JSON(http.StatusOK, Count{Value: count})
		return
	})

	_ = router.Run(fmt.Sprintf(":%d", c.Port))
}
