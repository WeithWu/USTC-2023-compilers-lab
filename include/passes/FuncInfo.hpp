#pragma once

#include "PassManager.hpp"
#include "logging.hpp"

#include <deque>
#include <unordered_map>

/**
 * 计算哪些函数是纯函数
 * WARN:
 * 假定所有函数都是纯函数，除非他写入了全局变量、修改了传入的数组、或者直接间接调用了非纯函数
 */
class FuncInfo : public Pass {
  public:
    FuncInfo(Module *m) : Pass(m) {}

    void run();

    bool is_pure_function(Function *func) const { return is_pure.at(func); }

  private:
    std::deque<Function *> worklist;
    std::unordered_map<Function *, bool> is_pure;

    void trivial_mark(Function *func);
    void process(Function *func);
    Value *get_first_addr(Value *val);

    bool is_side_effect_inst(Instruction *inst);
    bool is_local_load(LoadInst *inst);
    bool is_local_store(StoreInst *inst);

    void log();
};
