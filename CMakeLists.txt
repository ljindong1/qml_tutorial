cmake_minimum_required(VERSION 3.14)
project(QML_TUTORIAL LANGUAGES CXX)

# Qt 설치 경로를 CMAKE_PREFIX_PATH로 명확히 지정
set(CMAKE_PREFIX_PATH "C:/Qt/6.9.1/mingw_64")
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Qml)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

qt_add_executable(QML_TUTORIAL
    main.cpp
)

qt_add_qml_module(CalcApp
    URI CalculatorApp
    VERSION 1.0
    QML_FILES qml/Calculator.qml
)

target_link_libraries(QML_TUTORIAL PRIVATE Qt6::Quick Qt6::Qml)



