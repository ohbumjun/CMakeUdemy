dependency:
	cd build && cmake .. --graphviz=graph.dot && dot -Tpng graph.dot -o graphImage.png

prepare:
	rm -rf build
	mkdir build

resetbuild:
	rm -rf build
	mkdir build
	cd build
	cmake ..
	cmake --build .
