package main

import (
	"net/http"
	"strconv"

	"github.com/gin-contrib/cors"
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

func idParseUint(c *gin.Context) (id uint64) {
	i := c.Param("id")
	id, err := strconv.ParseUint(i, 10, 64)
	if err != nil {
		c.IndentedJSON(http.StatusBadRequest, gin.H{"error": "invalid id"})
	}
	return
}

func healthCheck(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, gin.H{"status": "ok"})
}

func getAlbums(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, albums)
}

func getAlbumByID(c *gin.Context) {
	id := idParseUint(c)

	for _, a := range albums {
		if a.ID == id {
			c.IndentedJSON(http.StatusOK, a)
			return
		}
	}
	c.IndentedJSON(http.StatusNotFound, gin.H{"error": "album not found"})
}

func postAlbums(c *gin.Context) {
	var newAlbum album

	err := c.BindJSON(&newAlbum)
	if err != nil {
		c.IndentedJSON(http.StatusBadRequest, gin.H{"error": "invalid request"})
		return
	}

	albums = append(albums, newAlbum)
	c.IndentedJSON(http.StatusCreated, newAlbum)
}

func deleteAlbumByID(c *gin.Context) {
	id := idParseUint(c)

	for i, a := range albums {
		if a.ID == id {
			// i番目のスライスを取得し、[i+1:]...i+1番以外すべてをappendしている
			// :iでi番目のスライスを取得, i:でi番目以外のスライスを取得
			albums = append(albums[:i], albums[i+1:]...)
			c.IndentedJSON(http.StatusNoContent, nil)
			return
		}
	}
	c.IndentedJSON(http.StatusNotFound, gin.H{"error": "album not found"})
}

func putAlbumByID(c *gin.Context) {
	id := idParseUint(c)

	var newAlbum album
	err := c.BindJSON(&newAlbum)
	if err != nil {
		c.IndentedJSON(http.StatusBadRequest, gin.H{"error": "invalid request"})
		return
	}

	for i, a := range albums {
		if a.ID == id {
			albums[i] = newAlbum
			c.IndentedJSON(http.StatusOK, newAlbum)
			return
		}
	}
	c.IndentedJSON(http.StatusNotFound, gin.H{"error": "album not found"})
}

func main() {
	router := gin.Default()

	router.Use(
		cors.New(
			cors.Config{
				AllowOrigins: []string{
					"http://localhost:3000",
					"http://helloworld-dev-alb-front-1863607102.ap-northeast-1.elb.amazonaws.com",
				},
				AllowMethods: []string{
					"GET",
					"PUT",
					"POST",
					"DELETE",
					"OPTIONS",
				},
				AllowHeaders: []string{
					"Access-Control-Allow-Credentials",
					"Access-Control-Allow-Headers",
					"Content-Type",
					"Content-Length",
					"Accept-Encoding",
					"Authorization",
				},
				AllowCredentials: true,
			},
		),
	)

	v1 := router.Group("/v1")
	{
		v1.GET("/health", healthCheck)
		v1.GET("/albums", getAlbums)
		v1.GET("/albums/:id", getAlbumByID)
		v1.POST("/albums", postAlbums)
		v1.PUT("/albums/:id", putAlbumByID)
		v1.DELETE("/albums/:id", deleteAlbumByID)
	}

	err := router.Run(":8080")
	if err != nil {
		panic("[Error] failed to start Gin server due to" + err.Error())
	}
}
