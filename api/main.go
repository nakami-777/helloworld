package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type album struct {
	ID     uint64  `json:"id"`
	Title  string  `json:"title"`
	Artist string  `json:"artist"`
	Price  float64 `json:"price"`
}

// スライスでアルバムを保持
var albums = []album{
	{ID: 1, Title: "title1", Artist: "artist1", Price: 1000},
	{ID: 2, Title: "title2", Artist: "artist2", Price: 2000},
	{ID: 3, Title: "title3", Artist: "artist3", Price: 3000},
	{ID: 4, Title: "title4", Artist: "artist4", Price: 4000},
	{ID: 5, Title: "title5", Artist: "artist5", Price: 5000},
}

func healthCheck(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, gin.H{"status": "ok"})
}

func getAlbums(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, albums)
}

func postAlbums(c *gin.Context) {
	var newAlbum album

	err := c.BindJSON(&newAlbum)
	if err != nil {
		return
	}

	albums = append(albums, newAlbum)
	c.IndentedJSON(http.StatusCreated, newAlbum)
}

func main() {
	router := gin.Default()

	v1 := router.Group("/v1")
	{
		v1.GET("/health", healthCheck)
		v1.GET("/albums", getAlbums)
		v1.POST("/albums", postAlbums)
	}

	err := router.Run(":8080")
	if err != nil {
		panic("[Error] failed to start Gin server due to" + err.Error())
	}
}
