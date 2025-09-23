return {

	[[
						
               cmake_minimum_required(VERSION 3.10)
               project({} C)

               set(CMAKE_C_STANDARD 23)

               file(GLOB SRC "src/*.c" "lib/*.c")

               add_executable({} main.c ${{SRC}})

               target_include_directories({} PRIVATE src lib include)
						 ]],
}
