RUN = g++ -Wall -Werror -Wextra -O2 --pedantic -std=c++17 -g
ifeq ($(shell uname),Linux)
	OS = -lcheck -lm -lrt -lpthread -lsubunit -lncursesw
else
	OS = -lcheck -lm -lpthread -lncursesw
endif
all:	clean install
snake.a:	snake.o
	ar rcs snake.a *.o
	ranlib snake.a
snake.o:	*.cpp *.h
	$(RUN) *.cpp -c
clean:
	rm -rf Snake *.gcda *.gcno *.o *.info *.a *.tar.gz docs/html
snake:	snake.o
	$(RUN) *.cpp -o snake $(OS)
install:	clean snake
	mkdir Snake && mv snake Snake
	./Snake/snake
uninstall:
	rm -rf Snake
dist:
	tar czvf snake.tar.gz --ignore-failed-read Makefile
dvi:
	$(shell which firefox || which xdg-open || which open || which x-www-browser) docs/html/index.html
