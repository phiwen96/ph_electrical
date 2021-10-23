BUILD=build
SRC=src

main: main.o A.pcm B.pcm D.pcm
	clang++ -std=c++2a -stdlib=libc++ -fmodules main.o A.pcm B.pcm D.pcm -o main

main.o: main.cpp
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fprebuilt-module-path=. -c main.cpp -o main.o

D.pcm: D.cpp
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fmodule-file=B.pcm -c D.cpp -Xclang -emit-module-interface -o D.pcm

B.pcm: A.pcm B.cpp
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fmodule-file=A.pcm -c B.cpp -Xclang -emit-module-interface -o B.pcm

A.pcm: A.cpp 
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -c A.cpp -Xclang -emit-module-interface -o A.pcm

buildfiles: $(*.o, *.pcm, main)

clean: 
	rm -f $(buildfiles)
