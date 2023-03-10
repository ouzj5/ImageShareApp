package main

import (
	"Server/view"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.Static("/assets", "./assets")
	r.POST("/login", view.Login)
	r.POST("/signup", view.Signup)
	r.GET("/getArticle", view.GetArticles)
	r.GET("/logout", view.Logout)
	r.POST("/uploadArticle", view.CreateArticle)
	r.POST("/uploadPic", view.UploadPic)
	r.POST("/createzan", view.CreateZan)
	r.POST("/deletezan", view.DeleteZan)

	r.Run() // listen and serve on 0.0.0.0:8080
}
