BUILD=build
SRC=src

main: main.o electrical.pcm systems.pcm
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fprebuilt-module-path=. main.o electrical.pcm systems.pcm -o main

main.o: main.cpp
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fprebuilt-module-path=. -c main.cpp -o main.o


electrical.pcm: electrical.cpp systems.pcm
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -fmodule-file=systems.pcm -c electrical.cpp -Xclang -emit-module-interface -o electrical.pcm

systems.pcm: systems.cpp 
	clang++ -std=c++2a -stdlib=libc++ -fmodules -fbuiltin-module-map -fimplicit-modules -fimplicit-module-maps -c systems.cpp -Xclang -emit-module-interface -o systems.pcm

buildfiles: $(*.o, *.pcm, main)

clean: 
	rm -f *.o *.pcm main
