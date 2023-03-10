package view

import (
	"Server/dal/db"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func CreateZan(c *gin.Context) {
	log.Print(c.PostForm("aid"))
	aid, _ := strconv.Atoi(c.PostForm("aid"))
	uid, _ := strconv.Atoi(c.PostForm("uid"))
	log.Print("craete zan a, u id: ", aid, " ", uid)
	db.CreateZan(uint(uid), uint(aid))
	c.String(http.StatusOK, "accepted")
}
func DeleteZan(c *gin.Context) {
	aid, _ := strconv.Atoi(c.PostForm("aid"))
	uid, _ := strconv.Atoi(c.PostForm("uid"))
	db.DeleteZan(uint(uid), uint(aid))
	c.String(http.StatusOK, "accepted")
}
