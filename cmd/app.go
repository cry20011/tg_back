package main

import (
	"log"
	"sync"
)

func main() {
	i := 0

	for {
		r1, r2 := 0, 0
		x, y := 0, 0

		wg := sync.WaitGroup{}
		wg.Add(2)

		go func() {
			x = 1
			r1 = y

			wg.Done()
		}()

		go func() {
			y = 1
			r2 = x

			wg.Done()
		}()

		wg.Wait()

		if r1 == 0 && r2 == 0 {
			log.Fatalf("on %d iteration program is broken!!!!!!!", i)
		}

		i++

		if i%1000 == 0 {
			log.Printf("%d interation passed", i)
		}
	}
}
