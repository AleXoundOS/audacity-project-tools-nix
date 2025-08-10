# SPDX-FileCopyrightText: 2021 Dmitry Vedenko <dmitry@crsib.me>
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.19)

project(audacity-project-tools)

set_property( GLOBAL PROPERTY USE_FOLDERS ON )

if( CMAKE_GENERATOR MATCHES "Visual Studio" )
   set_directory_properties(
      PROPERTIES
         VS_STARTUP_PROJECT "audacity-project-tools"
    )
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})

set(CMAKE_CXX_STANDARD 17)

if(WIN32)
    add_definitions(-DUNICODE -D_UNICODE)
endif()

set(DEPENDENCIES
    REQUIRES
        fmt/7.1.3
        sqlite3/3.40.0
        sqlitecpp/3.1.1
        gflags/2.2.2
        utfcpp/3.2.1
        boost/1.78.0

    OPTIONS
        boost:without_atomic=False
        boost:without_chrono=True
        boost:without_container=True
        boost:without_context=True
        boost:without_contract=True
        boost:without_coroutine=True
        boost:without_date_time=True
        boost:without_exception=True
        boost:without_fiber=True
        boost:without_filesystem=False
        boost:without_graph=True
        boost:without_graph_parallel=True
        boost:without_iostreams=True
        boost:without_json=True
        boost:without_locale=True
        boost:without_log=True
        boost:without_math=True
        boost:without_mpi=True
        boost:without_nowide=True
        boost:without_program_options=True
        boost:without_python=True
        boost:without_random=True
        boost:without_regex=True
        boost:without_serialization=True
        boost:without_stacktrace=True
        boost:without_system=False
        boost:without_test=True
        boost:without_thread=True
        boost:without_timer=True
        boost:without_type_erasure=True
        boost:without_wave=True
)

find_package(fmt CONFIG REQUIRED)
find_package(SQLite3 REQUIRED)
find_package(SQLiteCpp CONFIG REQUIRED)
find_package(gflags CONFIG REQUIRED)
find_package(utf8cpp CONFIG REQUIRED)
find_package(Boost REQUIRED COMPONENTS filesystem system)

set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )

add_executable(audacity-project-tools
    src/main.cpp

    src/Buffer.h
    src/Buffer.cpp

    src/ProjectBlobReader.h
    src/ProjectBlobReader.cpp

    src/XMLHandler.h

    src/BinaryXMLConverter.h
    src/BinaryXMLConverter.cpp

    src/SampleFormat.h
    src/SampleFormat.cpp

    src/AudacityDatabase.h
    src/AudacityDatabase.cpp

    src/ProjectModel.h
    src/ProjectModel.cpp

    src/WaveFile.h
    src/WaveFile.cpp
)

target_link_libraries(audacity-project-tools
    fmt::fmt
    SQLite::SQLite3
    ${SQLITE3_LIBRARIES}
    SQLiteCpp
    gflags
    utf8cpp::utf8cpp
    Boost::boost
    Boost::filesystem
    Boost::system
)

add_subdirectory(3party/sqlite3)

install(TARGETS audacity-project-tools sqlite3_shell)

set(CPACK_PACKAGE_NAME "audacity-project-tools")
set(CPACK_PACKAGE_VENDOR "Audacity")
set(CPACK_PACKAGE_VERSION_MAJOR 1)
set(CPACK_PACKAGE_VERSION_MINOR 0)
set(CPACK_PACKAGE_VERSION_PATCH 4)
set(CPACK_GENERATOR ZIP)
SET(CPACK_OUTPUT_FILE_PREFIX packages)

include(CPack)

