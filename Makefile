BUILD=build
SRC=src

main: main.o electrical.pcm systems.pcm B.pcm
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fprebuilt-module-path=. main.o electrical.pcm systems.pcm B.pcm -o main

main.o: main.cpp
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fprebuilt-module-path=. -c main.cpp -o main.o

systems.pcm: electrical.pcm systems.cpp
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fmodule-file=electrical.pcm -c systems.cpp -Xclang -emit-module-interface -o systems.pcm

electrical.pcm: electrical.cpp B.pcm
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fmodule-file=B.pcm -c electrical.cpp -Xclang -emit-module-interface -o electrical.pcm

B.pcm: B.cpp 
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -c B.cpp -Xclang -emit-module-interface -o B.pcm

buildfiles: $(*.o, *.pcm, main)

clean: 
	rm -f *.o *.pcm main
