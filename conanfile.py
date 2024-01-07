from conan import ConanFile
from conan.tools.cmake import CMakeToolchain


class CompressorRecipe(ConanFile):
    # ex) windows, msvc 17, debug, x86_64
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps"

    # list which packages are needed 
    def requirements(self):
        self.requires("nlohmann_json/3.11.2")
        self.requires("fmt/9.1.0")
        self.requires("spdlog/1.11.0")
        self.requires("catch2/2.13.9")
        self.requires("cxxopts/3.1.1")

    # create cmake file to ${CMAKE_BINARY_DIR}/conan_toolchain.cmake
    # which is referred by main CMakeLists.txt
    def generate(self):
        # which tool chain to use : cmake 
        tc = CMakeToolchain(self)
        tc.user_presets_path = False
        tc.generate()