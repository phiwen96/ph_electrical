// module;
import <iostream>;
import <vector>;

//import ph;
//import yo;Ä______________
// import ph;

import electrical;
// import electrical.systems;

int main()
{
    std::cout << "Hello, World!\n";
	fitta ();
	com ();
	auto vec = std::vector <int> {1, 2, 3};
	// assert (len (vec) == 3);
	// assert (len ({1, 2, 3}) == 3);
}


// clang++ -Wall -std=c++2a -fmodules -c ph.cpp -Xclang -emit-module-interface -o ph.pcm && clang++ -Wall -std=c++2a -fimplicit-modules -fimplicit-module-maps -fprebuilt-module-path=. main.cpp ph.pcm -o main && ./main