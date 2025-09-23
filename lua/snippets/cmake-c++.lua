return {

	[[
		
               cmake_minimum_required(VERSION 3.10)
               project({} CXX)

               set(CMAKE_CXX_STANDARD 23)

               file(GLOB SRC "src/*.cpp" "lib/*.cpp")

               add_executable({} main.cpp ${{SRC}})

               target_include_directories({} PRIVATE src lib include)
            ]],
}
