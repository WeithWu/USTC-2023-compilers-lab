add_executable(
    cminusfc
    cminusfc.cpp
    cminusf_builder.cpp
)

target_link_libraries(
    cminusfc
    IR_lib
    common
    syntax
    codegen
    stdc++fs
    opt_lib
)

install(
    TARGETS cminusfc
    RUNTIME DESTINATION bin
)
