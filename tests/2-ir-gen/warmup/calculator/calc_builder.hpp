#pragma once

#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"
#include "calc_ast.hpp"
#include <memory>

class CalcBuilder : public CalcASTVisitor {
  public:
    std::unique_ptr<Module> build(CalcAST &ast);

  private:
    virtual void visit(CalcASTInput &) override final;
    virtual void visit(CalcASTNum &) override final;
    virtual void visit(CalcASTExpression &) override final;
    virtual void visit(CalcASTTerm &) override final;

    std::unique_ptr<IRBuilder> builder;
    Value *val;
    Type *TyInt32;
    std::unique_ptr<Module> module;
};
