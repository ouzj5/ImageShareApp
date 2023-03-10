package model

import (
	"time"
)

type Article struct {
	ID        uint `gorm:"primary_key"`
	CreatedAt time.Time
	UpdatedAt time.Time
	UserID    uint
	Title     string `form:"not null"`
	ImgID     uint
	Zan       []Zan
}
type ArticleRes struct {
	ID     uint   `json:"id"`
	Title  string `json:"title"`
	Imgurl string `json:"imgurl"`
	Zan    int    `json:"zan"`
}
