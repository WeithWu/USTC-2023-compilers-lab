# 测试lab1-parser
## 编译
通过cmake对lexer和parser进行编译：
``` bash
$ cd 2023ustc-jianmu-compiler # 进入在本仓库根目录
$ mkdir build # 创建build目录，存放cmake与make生成的文件
$ cd build # 切换到build目录
$ cmake .. # 使用cmake生成Makefile等
$ make # 通过Makefile编译
```
如果你没有完成对src/parser/中lexical_analyzer.l和syntax_analyzer.y的修改，最后的`make`一步很可能会报错。
如果构建成功，会在该目录下看到 `lexer` 和 `parser` 两个可执行文件。
* `lexer`用于词法分析，产生token stream；对于词法分析结果，我们不做考察。
* `parser`用于语法分析，产生语法树。
## 运行
``` bash
$ cd 2023ustc-jianmu-compiler 
# 词法测试
$ ./build/lexer ./tests/1-parser/input/normal/local-decl.cminus
Token	      Text	Line	Column (Start,End)
280  	       int	0	(0,3)
284  	      main	0	(4,8)
272  	         (	0	(8,9)
282  	      void	0	(9,13)
273  	         )	0	(13,14)
...
# 语法测试
$ ./build/parser ./tests/1-parser/input/normal/local-decl.cminus
>--+ program
|  >--+ declaration-list
|  |  >--+ declaration
...
```

## 测试
### 测试样例
测试样例分为两个部分，分别是[`testcases_general`](../testcases_general/)和lab1限定的[`input`](./input)
### 测试方法
成功运行之后，可以使用 `diff` 与标准输出进行比较。
``` bash
$ cd 2023ustc-jianmu-compiler 
$ export PATH="$(realpath ./build):$PATH"
$ cd tests/1-parser
$ parser input/normal/local-decl.cminus > output_student/normal/local-decl.syntax_tree
$ diff output_student/normal/local-decl.syntax_tree output_standard/normal/local-decl.syntax_tree
[输出为空，代表没有区别，该测试通过]
```

我们提供了 `test_syntax.sh` 脚本进行快速批量测试。该脚本的第一个参数可以是 `easy`、 `normal`、 `hard` 以及 `testcases_general`，并且有第二个可选参数，用于进行批量 `diff` 比较。脚本运行后会将生成结果放在[output_student](./output_student/)文件夹里，而助教的参考输出则在[output_standard](./output_standard/)中。

```sh
$ ./test_syntax.sh easy
[info] Analyzing FAIL_id.cminus
error at line 1 column 6: syntax error
...
[info] Analyzing id.cminus

$ ./test_syntax.sh easy yes
...
[info] Comparing...
[info] No difference! Congratulations!
```