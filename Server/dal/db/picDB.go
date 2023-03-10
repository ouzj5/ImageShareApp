package db

import (
	. "Server/dal/model"
	"log"

	"github.com/jinzhu/gorm"
)

func init() {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	if db.HasTable(&Pic{}) {
		return
	} else {
		db.CreateTable(&Pic{})
	}
}
func CreatePic() uint {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	pic := Pic{}
	defer db.Close()
	if db.Create(&pic).Error != nil {
		return 0
	}
	return pic.ID
}
