flex_target(lex lexical_analyzer.l ${CMAKE_CURRENT_BINARY_DIR}/lexical_analyzer.c)
bison_target(syntax syntax_analyzer.y
  ${CMAKE_CURRENT_BINARY_DIR}/syntax_analyzer.c
  DEFINES_FILE ${PROJECT_BINARY_DIR}/syntax_analyzer.h)

add_flex_bison_dependency(lex syntax)
add_library(syntax STATIC
  ${BISON_syntax_OUTPUTS}
  ${FLEX_lex_OUTPUTS}
)

include_directories(${PROJECT_BINARY_DIR})
add_executable(parser parser.c)
target_link_libraries(parser syntax common)
add_executable(lexer lexer.c)
target_link_libraries(lexer syntax common)

install(
    TARGETS parser
    RUNTIME DESTINATION bin
)

install(
    TARGETS lexer
    RUNTIME DESTINATION bin
)
