package main

import (
	"Server/dal/db"
	"fmt"
	"testing"
)

func TestUser(t *testing.T) {
	if uid := db.CheckUser("ouzj5", "123"); uid != -1 {
		db.DeleteUser(uint(uid))
		fmt.Printf("delete user id: %d\n", uid)
	}
	id := db.CreateUser("ouzj5", "123")
	fmt.Printf("create user id: %d\n", id)
}
func TestArticle(t *testing.T) {

}
