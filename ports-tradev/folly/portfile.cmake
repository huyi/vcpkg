if(NOT VCPKG_TARGET_ARCHITECTURE STREQUAL x64)
  message(FATAL_ERROR "Folly only supports the x64 architecture.")
endif()

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL http://gitee.com/mirrors/folly.git
    REF a5e2a703c5a04615cd355203865be2f56246ed05
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_SHARED_LIBS=OFF
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

# 将.cmake文件移动到正确的位置(lib/cmake/folly/* -> share/folly)
if(VCPKG_TARGET_IS_WINDOWS)
  vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/folly)
  vcpkg_fixup_cmake_targets(TARGET_PATH ../share/${PORT})
else()
  vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/folly)
endif()

# 移除在debug目录下的include文件夹(使用release版本)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

message(STATUS "Installing done")
