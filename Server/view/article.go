package view

import (
	"Server/dal/db"
	. "Server/dal/model"
	"log"
	"strconv"

	"github.com/gin-gonic/gin"
)

func CreateArticle(c *gin.Context) {
	title := c.PostForm("title")
	imgid, _ := strconv.Atoi(c.PostForm("imgid"))
	uid, _ := strconv.Atoi(c.PostForm("uid"))
	log.Print("uid imgid: ", uid, imgid)
	if aid := db.CreateArticle(uint(uid), title, uint(imgid)); aid == 0 {
		c.JSON(200, gin.H{
			"status": "error",
			"msg":    "create wrong",
		})
		return
	}
	c.JSON(200, gin.H{
		"status": "success",
		"msg":    "create success",
	})
}
func GetArticles(c *gin.Context) {
	if str, err := c.Cookie("uid"); err != nil || len(str) == 0 {
		c.JSON(200, gin.H{
			"status": "error",
			"msg":    "no login",
		})
		return
	}
	sid, _ := strconv.Atoi(c.Query("start"))
	eid, _ := strconv.Atoi(c.Query("end"))
	var res []ArticleRes
	for i := sid; i <= eid; i++ {
		article, err := db.GetArticle(uint(i))
		if err != nil {
			break
		}
		var zan int
		if db.GetZan(1, uint(i)) {
			zan = 1
		} else {
			zan = 0
		}
		res = append(res, ArticleRes{
			ID:     uint(i),
			Title:  article.Title,
			Imgurl: "assets/pic" + strconv.Itoa(i) + ".jpg",
			Zan:    zan,
		})
	}
	c.JSON(200, gin.H{
		"status": "success",
		"msg":    "get articles",
		"data":   res,
	})
}
