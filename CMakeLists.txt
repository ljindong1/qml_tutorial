cmake_minimum_required(VERSION 3.16)
project(QML_TUTORIAL LANGUAGES CXX)

# Qt 설치 경로를 CMAKE_PREFIX_PATH로 명확히 지정
set(CMAKE_PREFIX_PATH "C:/Qt/6.9.1/mingw_64")
set(QT_QML_GENERATE_QMLLS_INI ON)

# Qt 위치를 찾도록
find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

# C++ 표준 및 자동 처리
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# 실행 파일 (타겟 이름을 PROJECT_NAME 변수로 사용)
qt_add_executable(${PROJECT_NAME}
    main.cpp
    # resource/qml.qrc   # CMAKE_AUTORCC 사용시 반드시 포함되어야 함
)

# QML 모듈 설정(.qrc 파일은 옛날 방식으로 비선호)
qt_add_qml_module(${PROJECT_NAME}
    URI CalculatorApp
    VERSION 1.0
    QML_FILES qml/Calculator.qml
)

# 라이브러리 링크 (키워드 방식 적용)
target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
)

# config/test_config.json 복사
add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory
        "$<TARGET_FILE_DIR:${PROJECT_NAME}>/config"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_SOURCE_DIR}/config/test_config.json"
        "$<TARGET_FILE_DIR:${PROJECT_NAME}>/config/test_config.json"
)

# qml 폴더 전체 복사
add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory
        "$<TARGET_FILE_DIR:${PROJECT_NAME}>/qml"
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_SOURCE_DIR}/qml"
        "$<TARGET_FILE_DIR:${PROJECT_NAME}>/qml"
)




