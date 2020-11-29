vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL http://gitee.com/mirrors/POCO.git
    REF 3fc3e5f5b8462f7666952b43381383a79b8b5d92
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DENABLE_CRYPTO=OFF
        -DENABLE_DATA=OFF
        -DENABLE_DATA_MYSQL=OFF
        -DENABLE_DATA_ODBC=OFF
        -DENABLE_DATA_SQLITE=OFF
        -DENABLE_MONGODB=OFF
        -DENABLE_NET=OFF
        -DENABLE_NETSSL=OFF
        -DENABLE_PAGECOMPILER=OFF
        -DENABLE_PAGECOMPILER_FILE2PAGE=OFF
        -DENABLE_REDIS=OFF
        -DENABLE_ZIP=OFF
        -DENABLE_JWT=OFF
        -DPOCO_STATIC=OFF
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

if(VCPKG_TARGET_IS_WINDOWS)
  vcpkg_fixup_cmake_targets(CONFIG_PATH cmake)
else()
  vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Poco)
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

message(STATUS "Installing done")
