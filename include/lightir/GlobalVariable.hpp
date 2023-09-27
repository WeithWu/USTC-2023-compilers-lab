#pragma once

#include "Constant.hpp"
#include "User.hpp"

#include <llvm/ADT/ilist_node.h>
class Module;
class GlobalVariable : public User, public llvm::ilist_node<GlobalVariable> {
  private:
    bool is_const_;
    Constant *init_val_;
    GlobalVariable(std::string name, Module *m, Type *ty, bool is_const,
                   Constant *init = nullptr);

  public:
    GlobalVariable(const GlobalVariable &) = delete;
    static GlobalVariable *create(std::string name, Module *m, Type *ty,
                                  bool is_const, Constant *init);
    virtual ~GlobalVariable() = default;
    Constant *get_init() { return init_val_; }
    bool is_const() { return is_const_; }
    std::string print();
};
