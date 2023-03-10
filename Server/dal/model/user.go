package model

import (
	"time"
)

type User struct {
	ID        uint `gorm:"primary_key"`
	CreatedAt time.Time
	UpdatedAt time.Time
	Username  string `gorm:"unique"`
	Password  string `gorm:"not null;"`
	Article   []Article
	Zan       []Zan
}
type Zan struct {
	UserID    uint `gorm:"unique_index:zid"`
	ArticleID uint `gorm:"unique_index:zid"`
}
