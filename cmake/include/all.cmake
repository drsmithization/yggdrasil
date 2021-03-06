CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
CMAKE_POLICY(VERSION 2.6.0)

SET(SOURCE_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

GET_FILENAME_COMPONENT(__cmake_incdir_ "${CMAKE_CURRENT_LIST_FILE}" PATH)

INCLUDE(${__cmake_incdir_}/global.cmake NO_POLICY_SCOPE)


IF (MAKE_ONLY)
    SET(__to_make_)
    FOREACH(__item_ ${MAKE_ONLY})
        IF ("${__item_}" STREQUAL "all")
            SET_APPEND(__to_make_ ${ROOT_PROJECTS})
        ELSE ("${__item_}" STREQUAL "all")
            IF (NOT EXISTS ${SOURCE_ROOT}/${__item_})
                MESSAGE(SEND_ERROR "Directory \"${__item_}\" (listed in MAKE_ONLY) does not exist.")
            ELSE (NOT EXISTS ${SOURCE_ROOT}/${__item_})
                SET_APPEND(__to_make_ ${__item_})
            ENDIF (NOT EXISTS ${SOURCE_ROOT}/${__item_})
        ENDIF ("${__item_}" STREQUAL "all")
    ENDFOREACH(__item_ ${MAKE_ONLY})
    IF (__to_make_)
        SUBDIR(${__to_make_})
    ENDIF (__to_make_)
ELSE (MAKE_ONLY)
    MESSAGE ("Building root projects: ${ROOT_PROJECTS}")
    SUBDIR(
        ${ROOT_PROJECTS}
    )
ENDIF (MAKE_ONLY)


FILE(READ ${UNITTEST_LIST_FILENAME} __ut_list_)
SET(__ut_srcdir_)
FOREACH (__ut_item_ ${__ut_list_})
    IF (__ut_srcdir_)
        ADD_SUBDIRECTORY_EX(${__ut_srcdir_} ${__ut_item_})
        SET(__ut_srcdir_)
    ELSE (__ut_srcdir_)
        SET(__ut_srcdir_ ${__ut_item_})
    ENDIF (__ut_srcdir_)
ENDFOREACH (__ut_item_)


INCLUDE(${__cmake_incdir_}/dtmk.cmake)
