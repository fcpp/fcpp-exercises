cmake_minimum_required(VERSION 3.9)
option(FCPP_INTERNAL_TESTS "Build internal tests for FCPP." OFF)
add_subdirectory(./fcpp/src)
fcpp_setup()

project(
    exercises
    VERSION 0.0.0
    DESCRIPTION "Quick-start aggregate computing exercises."
)

fcpp_target(exercises ./run/exercises.cpp ON)
