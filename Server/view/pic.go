package view

import (
	"Server/dal/db"
	"log"
	"os"
	"strconv"

	"github.com/gin-gonic/gin"
)

func UploadPic(c *gin.Context) {
	pic, err := c.FormFile("pic")
	if err != nil {
		log.Print("pic error: ", err.Error())
		c.JSON(200, gin.H{
			"status": "error",
			"msg":    "pic error",
		})
		return
	}
	pid := db.CreatePic()
	dst := "assets/pic" + strconv.Itoa(int(pid)) + ".jpg"
	if _, err := os.Create(dst); err != nil {
		log.Print("create file wrong: " + err.Error())
	}
	if err = c.SaveUploadedFile(pic, dst); err != nil {
		log.Print("file save wrong: " + err.Error())
		c.JSON(200, gin.H{
			"status": "error",
			"msg":    "upload error",
		})
	}
	c.JSON(200, gin.H{
		"status": "success",
		"msg":    "upload success",
	})
}
