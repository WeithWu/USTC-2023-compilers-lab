#pragma once

#include "Type.hpp"
#include "User.hpp"
#include "Value.hpp"

class Constant : public User {
  private:
    // int value;
  public:
    Constant(Type *ty, const std::string &name = "") : User(ty, name) {}
    ~Constant() = default;
};

class ConstantInt : public Constant {
  private:
    int value_;
    ConstantInt(Type *ty, int val) : Constant(ty, ""), value_(val) {}

  public:
    int get_value() { return value_; }
    static ConstantInt *get(int val, Module *m);
    static ConstantInt *get(bool val, Module *m);
    virtual std::string print() override;
};

class ConstantArray : public Constant {
  private:
    std::vector<Constant *> const_array;

    ConstantArray(ArrayType *ty, const std::vector<Constant *> &val);

  public:
    ~ConstantArray() = default;

    Constant *get_element_value(int index);

    unsigned get_size_of_array() { return const_array.size(); }

    static ConstantArray *get(ArrayType *ty,
                              const std::vector<Constant *> &val);

    virtual std::string print() override;
};

class ConstantZero : public Constant {
  private:
    ConstantZero(Type *ty) : Constant(ty, "") {}

  public:
    static ConstantZero *get(Type *ty, Module *m);
    virtual std::string print() override;
};

class ConstantFP : public Constant {
  private:
    float val_;
    ConstantFP(Type *ty, float val) : Constant(ty, ""), val_(val) {}

  public:
    static ConstantFP *get(float val, Module *m);
    float get_value() { return val_; }
    virtual std::string print() override;
};
