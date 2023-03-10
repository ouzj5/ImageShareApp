package view

import (
	"Server/dal/db"
	"log"
	"strconv"

	"github.com/gin-gonic/gin"
)

func Login(c *gin.Context) {
	un := c.PostForm("username")
	pw := c.PostForm("password")
	print("un, pw: " + un + "  " + pw)
	var uid uint
	if uid = db.CheckUser(un, pw); uid == 0 {
		c.JSON(200, gin.H{
			"status": "error",
			"msg":    "username or password wrong",
		})
		return
	}
	c.SetCookie("uid", strconv.Itoa(int(uid)), 60*10, "/", "localhost", false, true)
	c.JSON(200, gin.H{
		"status": "success",
		"msg":    "login success",
		"uid":    uid,
	})
}
func Signup(c *gin.Context) {
	un := c.PostForm("username")
	pw := c.PostForm("password")
	var uid uint
	log.Print("signup u: "+un+" p: ", pw)
	if uid = db.CreateUser(un, pw); uid == 0 {
		c.JSON(200, gin.H{
			"status": "error",
			"msg":    "username has been taken",
		})
		return
	}
	c.SetCookie("uid", strconv.Itoa(int(uid)), 60*10, "/", "localhost", false, true)
	c.JSON(200, gin.H{
		"status": "success",
		"msg":    "signup success",
		"uid":    uid,
	})
}
func Logout(c *gin.Context) {
	str, err := c.Cookie("uid")
	if err != nil || len(str) == 0 {
		c.JSON(200, gin.H{
			"status": "error",
			"msg":    "no login",
		})
		return
	}
	c.SetCookie("uid", str, -1, "/", "localhost", false, true)
	c.JSON(200, gin.H{
		"status": "success",
		"msg":    "logout success",
	})
}
