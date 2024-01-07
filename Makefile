dependency:
	# graphviz : basic format of graphical visualization tools
	# create png file based on graph.dot file 
	rm -rf build
	mkdir build
	cd build && cmake .. --graphviz=graph.dot && dot -Tpng graph.dot -o graphImage.png

prepare:
	rm -rf build
	mkdir build
	cd build

buildtoend:
	cmake ..
	cmake --build .