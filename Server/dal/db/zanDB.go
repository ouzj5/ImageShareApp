package db

import (
	. "Server/dal/model"
	"log"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

func init() {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	if db.HasTable(&Zan{}) {
		return
	} else {
		if res := db.CreateTable(&Zan{}); res.Error != nil {
			log.Print(res.Error.Error())
		}
	}
}

func GetZan(uid uint, aid uint) bool {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	var zan Zan
	if result := db.Where("user_id = ? and article_id = ?", uid, aid).First(&zan); result.Error != nil {
		return false
	} else {
		return true
	}
}

func CreateZan(uid uint, aid uint) {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	zan := Zan{UserID: uid, ArticleID: aid}
	if res := db.Create(&zan); res.Error != nil {
		log.Print("create zan failed: " + res.Error.Error())
	}
}

func DeleteZan(uid uint, aid uint) {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	if result := db.Where("user_id = ? and article_id = ?", uid, aid).Delete(Zan{}); result.Error != nil {
		log.Print("zan delete failed")
	}
}
