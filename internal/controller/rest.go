package controller

import (
	"context"
	"fmt"
	"github.com/gin-gonic/gin"
)

type REST struct {
	engine *gin.Engine
}

func NewRESTController(apiVersion string) (*REST, error) {
	r := REST{
		engine: gin.Default(),
	}

	versionGroup := r.engine.Group("/" + apiVersion)

	r.setUsersHandlers(versionGroup)

	return &r, nil
}

func (r *REST) Run(ctx context.Context) {
	go func() {
		err := r.engine.Run("localhost:8080")
		if err != nil {
			fmt.Printf("gin run failed: %v", err)

			return
		}
	}()

}

func (r *REST) setUsersHandlers(g *gin.RouterGroup) {
	g.GET("/users", func(context *gin.Context) {

	})

}
