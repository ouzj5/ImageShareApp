package db

import (
	. "Server/dal/model"
	"errors"
	"log"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

func CreateArticle(uid uint, title string, imgid uint) uint {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	article := Article{UserID: uid, Title: title, ImgID: imgid}
	if db.Create(&article).Error != nil {
		return 0
	}
	return article.ID
}
func init() {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	if db.HasTable(&Article{}) {
		return
	} else {
		db.CreateTable(&Article{})
	}
}
func GetArticle(aid uint) (Article, error) {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	var article Article
	if result := db.Where("id = ?", aid).First(&article); result.Error != nil {
		log.Print("artice get failed")
		return article, errors.New("no this article")
	}
	return article, nil
}
func DeleteArticle(aid uint) bool {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	if result := db.Where("article_id = ?", aid).Delete(Article{}); result.Error != nil {
		log.Print("artice delete failed")
		return false
	}
	return true
}
