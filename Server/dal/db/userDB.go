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
	if db.HasTable(&User{}) {
		return
	} else {
		db.CreateTable(&User{})
	}
}
func DropTable() {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	db.DropTable(&User{})
}
func CreateUser(username, password string) uint {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf(err.Error())
	}
	user := User{Username: username, Password: password}
	defer db.Close()
	if db.Create(&user).Error != nil {
		return 0
	}
	return user.ID
}

func CheckUser(un, pw string) uint {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	var user User
	if result := db.Where(&User{Username: un, Password: pw}).First(&user); result.Error != nil {
		log.Print("login failed: ", result.Error)
		return 0
	}
	return user.ID
}
func DeleteUser(uid uint) bool {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	if result := db.Where("id = ?", uid).Delete(User{}); result.Error != nil {
		return true
	} else {
		return false
	}
}

func getUserById(uid uint) User {
	db, err := gorm.Open("mysql", "root:@/mosad?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatalf("db open fail")
	}
	defer db.Close()
	var user User
	if result := db.Where("id = ?", uid).First(&user); result.Error != nil {
		log.Print(result.Error.Error())
	}
	return user
}
