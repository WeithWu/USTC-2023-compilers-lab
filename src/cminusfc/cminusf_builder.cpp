#include "cminusf_builder.hpp"

#define CONST_FP(num) ConstantFP::get((float)num, module.get())
#define CONST_INT(num) ConstantInt::get(num, module.get())

// types
Type *VOID_T;
Type *INT1_T;
Type *INT32_T;
Type *INT32PTR_T;
Type *FLOAT_T;
Type *FLOATPTR_T;

/*
 * use CMinusfBuilder::Scope to construct scopes
 * scope.enter: enter a new scope
 * scope.exit: exit current scope
 * scope.push: add a new binding to current scope
 * scope.find: find and return the value bound to the name
 */

Value *CminusfBuilder::visit(ASTProgram &node)
{
    VOID_T = module->get_void_type();
    INT1_T = module->get_int1_type();
    INT32_T = module->get_int32_type();
    INT32PTR_T = module->get_int32_ptr_type();
    FLOAT_T = module->get_float_type();
    FLOATPTR_T = module->get_float_ptr_type();

    Value *ret_val = nullptr;
    for (auto &decl : node.declarations)
    {
        ret_val = decl->accept(*this);
    }
    return ret_val;
}

Value *CminusfBuilder::visit(ASTNum &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    if (node.type == TYPE_INT)
    {
        context.NumType = TYPE_INT;
        context.Num = CONST_INT(node.i_val);
        context.INTEGER = node.i_val;
    }
    else if (node.type == TYPE_FLOAT)
    {
        context.NumType = TYPE_FLOAT;
        context.Num = CONST_FP(node.f_val);
    }
    else
    {
        context.NumType = TYPE_VOID;
        context.Num = nullptr;
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTVarDeclaration &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    Type *tp = nullptr;
    if (node.type == TYPE_INT)
    {
        tp = INT32_T;
    }
    else if (node.type == TYPE_FLOAT)
    {
        tp = FLOAT_T;
    }
    if (not scope.in_global())
    {
        if (node.num == nullptr)
        {

            auto Alloca = (tp != nullptr) ? builder->create_alloca(tp) : nullptr;
            scope.push(node.id, Alloca);
        }
        else
        {
            node.num->accept(*this);
            if (context.INTEGER <= 0)
                builder->create_call(scope.find("neg_idx_except"), std::vector<Value *>{});
            auto arrytype = ArrayType::get(tp, context.INTEGER);
            auto arryAllca = builder->create_alloca(arrytype);
            scope.push(node.id, arryAllca);
        }
    }
    else
    {
        auto initializer = ConstantZero::get(INT32_T, builder->get_module());
        if (node.num == nullptr)
        {

            auto Alloca = (tp != nullptr) ? GlobalVariable::create(node.id, builder->get_module(), tp, false, initializer) : nullptr;
            scope.push(node.id, Alloca);
        }
        else
        {
            node.num->accept(*this);
            if (context.INTEGER <= 0)
                builder->create_call(scope.find("neg_idx_except"), std::vector<Value *>{});
            auto arrytype = ArrayType::get(tp, context.INTEGER);
            auto arryAllca = GlobalVariable::create(node.id, builder->get_module(), arrytype, false, initializer);
            scope.push(node.id, arryAllca);
        }
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTFunDeclaration &node)
{
    FunctionType *fun_type;
    Type *ret_type;
    std::vector<Type *> param_types;
    if (node.type == TYPE_INT)
        ret_type = INT32_T;
    else if (node.type == TYPE_FLOAT)
        ret_type = FLOAT_T;
    else
        ret_type = VOID_T;

    for (auto &param : node.params)
    {
        // TODO: Please accomplish param_types.
        param->accept(*this);
        param_types.push_back(context.ParaType);
    }

    fun_type = FunctionType::get(ret_type, param_types);
    auto func = Function::create(fun_type, node.id, module.get());
    scope.push(node.id, func);
    context.func = func;
    auto funBB = BasicBlock::create(module.get(), "entry" + std::to_string(context.count++), func);
    builder->set_insert_point(funBB);
    scope.enter();
    std::vector<Value *> args;
    for (auto &arg : func->get_args())
    {
        args.push_back(&arg);
    }
    for (int i = 0; i < node.params.size(); ++i)
    {
        // TODO: You need to deal with params and store them in the scope.
        auto argAlloca = builder->create_alloca(args[i]->get_type());
        builder->create_store(args[i], argAlloca);
        scope.push(args[i]->get_name(), argAlloca); // not sure if name was set now
    }
    node.compound_stmt->accept(*this);
    if (not builder->get_insert_block()->is_terminated())
    {
        if (context.func->get_return_type()->is_void_type())
            builder->create_void_ret();
        else if (context.func->get_return_type()->is_float_type())
            builder->create_ret(CONST_FP(0.));
        else
            builder->create_ret(CONST_INT(0));
    }
    scope.exit();
    return nullptr;
}

Value *CminusfBuilder::visit(ASTParam &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    if (node.isarray)
    {
        if (node.type == TYPE_INT)
        {
            context.ParaType = PointerType::get(INT32_T);
        }
        else if (node.type == TYPE_FLOAT)
        {
            context.ParaType = PointerType::get(FLOAT_T);
        }
        else
        {
            context.ParaType = PointerType::get(VOID_T);
        }
    }
    else
    {
        if (node.type == TYPE_INT)
        {
            context.ParaType = INT32_T;
        }
        else if (node.type == TYPE_FLOAT)
        {
            context.ParaType = FLOAT_T;
        }
        else
        {
            context.ParaType = VOID_T;
        }
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTCompoundStmt &node)
{
    // TODO: This function is not complete.
    // You may need to add some code here
    // to deal with complex statements.
    scope.enter();
    for (auto &decl : node.local_declarations)
    {
        decl->accept(*this);
    }
    ASTCompoundStmt *CS = nullptr;
    ASTExpressionStmt *ES = nullptr;
    ASTSelectionStmt *SS = nullptr;
    ASTIterationStmt *IS = nullptr;
    ASTReturnStmt *RS = nullptr;
    for (auto &stmt : node.statement_list)
    {
        if (CS = dynamic_cast<ASTCompoundStmt *>(stmt.get()))
        {
            CS->accept(*this);
        }
        else if (ES = dynamic_cast<ASTExpressionStmt *>(stmt.get()))
        {
            ES->accept(*this);
        }
        else if (SS = dynamic_cast<ASTSelectionStmt *>(stmt.get()))
        {
            SS->accept(*this);
        }
        else if (IS = dynamic_cast<ASTIterationStmt *>(stmt.get()))
        {
            IS->accept(*this);
        }
        else if (RS = dynamic_cast<ASTReturnStmt *>(stmt.get()))
        {
            RS->accept(*this);
        }

        if (builder->get_insert_block()->is_terminated())
            break;
    }
    scope.exit();
    return nullptr;
}

Value *CminusfBuilder::visit(ASTExpressionStmt &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    scope.enter();
    ASTAssignExpression *AE = nullptr;
    ASTSimpleExpression *SE = nullptr;
    if (node.expression)
    {
        if (AE = dynamic_cast<ASTAssignExpression *>(node.expression.get()))
        {
            AE->accept(*this);
        }
        else if (SE = dynamic_cast<ASTSimpleExpression *>(node.expression.get()))
        {
            SE->accept(*this);
        }
    }
    scope.exit();
    return nullptr;
}

Value *CminusfBuilder::visit(ASTSelectionStmt &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    scope.enter();
    BasicBlock *nextBB = BasicBlock::create(builder->get_module(), "nextBB" + std::to_string(context.count++), context.func);
    BasicBlock *trueBB = nullptr;
    BasicBlock *falseBB = nullptr;
    Value *cmp = nullptr;
    ASTAssignExpression *AE = nullptr;
    ASTSimpleExpression *SE = nullptr;
    if (node.expression)
    {
        if (AE = dynamic_cast<ASTAssignExpression *>(node.expression.get()))
        {
            AE->accept(*this);
        }
        else if (SE = dynamic_cast<ASTSimpleExpression *>(node.expression.get()))
        {
            SE->accept(*this);
        }
    }
    if (context.NumType == TYPE_INT)
    {
        cmp = builder->create_icmp_gt(context.Num, CONST_INT(0));
    }
    else if (context.NumType == TYPE_FLOAT)
    {
        cmp = builder->create_fcmp_gt(context.Num, CONST_INT(0));
    }
    if (node.if_statement)
    {
        trueBB = BasicBlock::create(builder->get_module(), "trueBB" + std::to_string(context.count++), context.func);
        if (node.else_statement)
            falseBB = BasicBlock::create(builder->get_module(), "falseBB" + std::to_string(context.count++), context.func);
        else
            falseBB = nextBB;
        builder->create_cond_br(cmp, trueBB, falseBB);
        builder->set_insert_point(trueBB);
        scope.enter();
        ASTCompoundStmt *CS = nullptr;
        ASTExpressionStmt *ES = nullptr;
        ASTSelectionStmt *SS = nullptr;
        ASTIterationStmt *IS = nullptr;
        ASTReturnStmt *RS = nullptr;
        if (CS = dynamic_cast<ASTCompoundStmt *>(node.if_statement.get()))
        {
            CS->accept(*this);
        }
        else if (ES = dynamic_cast<ASTExpressionStmt *>(node.if_statement.get()))
        {
            ES->accept(*this);
        }
        else if (SS = dynamic_cast<ASTSelectionStmt *>(node.if_statement.get()))
        {
            SS->accept(*this);
        }
        else if (IS = dynamic_cast<ASTIterationStmt *>(node.if_statement.get()))
        {
            IS->accept(*this);
        }
        else if (RS = dynamic_cast<ASTReturnStmt *>(node.if_statement.get()))
        {
            RS->accept(*this);
        }
        builder->create_br(nextBB);
        scope.exit();
    }
    if (node.else_statement)
    {
        builder->set_insert_point(falseBB);
        scope.enter();
        ASTCompoundStmt *CS = nullptr;
        ASTExpressionStmt *ES = nullptr;
        ASTSelectionStmt *SS = nullptr;
        ASTIterationStmt *IS = nullptr;
        ASTReturnStmt *RS = nullptr;
        if (CS = dynamic_cast<ASTCompoundStmt *>(node.else_statement.get()))
        {
            CS->accept(*this);
        }
        else if (ES = dynamic_cast<ASTExpressionStmt *>(node.else_statement.get()))
        {
            ES->accept(*this);
        }
        else if (SS = dynamic_cast<ASTSelectionStmt *>(node.else_statement.get()))
        {
            SS->accept(*this);
        }
        else if (IS = dynamic_cast<ASTIterationStmt *>(node.else_statement.get()))
        {
            IS->accept(*this);
        }
        else if (RS = dynamic_cast<ASTReturnStmt *>(node.else_statement.get()))
        {
            RS->accept(*this);
        }
        builder->create_br(nextBB);
        scope.exit();
    }
    scope.exit();
    builder->set_insert_point(nextBB);
    return nullptr;
}

Value *CminusfBuilder::visit(ASTIterationStmt &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    scope.enter();
    BasicBlock *nextBB = BasicBlock::create(builder->get_module(), "nextBB" + std::to_string(context.count++), context.func);
    BasicBlock *cmpBB = BasicBlock::create(builder->get_module(), "cmpBB" + std::to_string(context.count++), context.func);
    BasicBlock *whileBB = BasicBlock::create(builder->get_module(), "whileBB" + std::to_string(context.count++), context.func);
    Value *cmp = nullptr;
    builder->create_br(cmpBB);
    builder->set_insert_point(cmpBB);
    scope.enter();
    ASTAssignExpression *AE = nullptr;
    ASTSimpleExpression *SE = nullptr;
    if (node.expression)
    {
        if (AE = dynamic_cast<ASTAssignExpression *>(node.expression.get()))
        {
            AE->accept(*this);
        }
        else if (SE = dynamic_cast<ASTSimpleExpression *>(node.expression.get()))
        {
            SE->accept(*this);
        }
    }
    if (context.NumType == TYPE_INT)
    {
        cmp = builder->create_icmp_gt(context.Num, CONST_INT(0));
    }
    else if (context.NumType == TYPE_FLOAT)
    {
        cmp = builder->create_fcmp_gt(context.Num, CONST_INT(0));
    }
    builder->create_cond_br(cmp, whileBB, nextBB);
    scope.exit();
    builder->set_insert_point(whileBB);
    scope.enter();
    ASTCompoundStmt *CS = nullptr;
    ASTExpressionStmt *ES = nullptr;
    ASTSelectionStmt *SS = nullptr;
    ASTIterationStmt *IS = nullptr;
    ASTReturnStmt *RS = nullptr;
    if (CS = dynamic_cast<ASTCompoundStmt *>(node.statement.get()))
    {
        CS->accept(*this);
    }
    else if (ES = dynamic_cast<ASTExpressionStmt *>(node.statement.get()))
    {
        ES->accept(*this);
    }
    else if (SS = dynamic_cast<ASTSelectionStmt *>(node.statement.get()))
    {
        SS->accept(*this);
    }
    else if (IS = dynamic_cast<ASTIterationStmt *>(node.statement.get()))
    {
        IS->accept(*this);
    }
    else if (RS = dynamic_cast<ASTReturnStmt *>(node.statement.get()))
    {
        RS->accept(*this);
    }
    builder->create_br(cmpBB);
    scope.exit();
    scope.exit();
    builder->set_insert_point(nextBB);
    return nullptr;
}

Value *CminusfBuilder::visit(ASTReturnStmt &node)
{
    scope.enter();
    if (node.expression == nullptr)
    {
        builder->create_void_ret();
        return nullptr;
    }
    else
    {
        // TODO: The given code is incomplete.
        // You need to solve other return cases (e.g. return an integer).
        ASTAssignExpression *AE = nullptr;
        ASTSimpleExpression *SE = nullptr;
        if (node.expression)
        {
            if (AE = dynamic_cast<ASTAssignExpression *>(node.expression.get()))
            {
                AE->accept(*this);
            }
            else if (SE = dynamic_cast<ASTSimpleExpression *>(node.expression.get()))
            {
                SE->accept(*this);
            }
        }
        builder->create_ret(context.Num);
    }
    scope.exit();
    return nullptr;
}

Value *CminusfBuilder::visit(ASTVar &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    if (node.expression == nullptr)
    {
        context.varAddr = scope.find(node.id);
        if (context.varAddr->get_type()->get_pointer_element_type()->is_array_type())
        {
            context.varAddr = builder->create_gep(context.varAddr, {CONST_INT(0), CONST_INT(0)});
        }
        else
        {
            if (context.varAddr->get_type()->get_pointer_element_type()->is_int32_type())
            {
                context.Num = builder->create_load(context.varAddr);
                context.NumType = TYPE_INT;
            }
            else if (context.varAddr->get_type()->get_pointer_element_type()->is_float_type())
            {
                context.Num = builder->create_load(context.varAddr);
                context.NumType = TYPE_FLOAT;
            }
        }
    }
    else
    {
        ASTAssignExpression *AE = nullptr;
        ASTSimpleExpression *SE = nullptr;
        if (node.expression)
        {
            if (AE = dynamic_cast<ASTAssignExpression *>(node.expression.get()))
            {
                AE->accept(*this);
            }
            else if (SE = dynamic_cast<ASTSimpleExpression *>(node.expression.get()))
            {
                SE->accept(*this);
            }
        }
        Value *baseAddr = scope.find(node.id);
        auto nextBB = BasicBlock::create(builder->get_module(), "nextBB" + std::to_string(context.count++), context.func);
        auto negBB = BasicBlock::create(builder->get_module(), "negBB" + std::to_string(context.count++), context.func);
        if (context.NumType == TYPE_FLOAT)
        {
            FCmpInst *Fcmp = builder->create_fcmp_ge(context.Num, CONST_FP(0));
            builder->create_cond_br(Fcmp, nextBB, negBB);
        }
        if (context.NumType == TYPE_INT)
        {
            ICmpInst *Icmp = builder->create_icmp_ge(context.Num, CONST_INT(0));
            builder->create_cond_br(Icmp, nextBB, negBB);
        }
        builder->set_insert_point(negBB);
        builder->create_call(scope.find("neg_idx_except"), std::vector<Value *>{});
        builder->create_br(nextBB);
        builder->set_insert_point(nextBB);
        if (context.NumType == TYPE_FLOAT)
        {
            context.Num = builder->create_fptosi(context.Num, INT32_T);
            context.NumType = TYPE_INT;
        }

        context.varAddr = builder->create_gep(baseAddr, {CONST_INT(0), context.Num});
        if (context.varAddr->get_type()->get_pointer_element_type()->is_int32_type())
        {
            context.Num = builder->create_load(context.varAddr);
            context.NumType = TYPE_INT;
        }
        else if (context.varAddr->get_type()->get_pointer_element_type()->is_float_type())
        {
            context.Num = builder->create_load(context.varAddr);
            context.NumType = TYPE_FLOAT;
        }
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTAssignExpression &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    node.var->accept(*this);
    ASTAssignExpression *AE = nullptr;
    ASTSimpleExpression *SE = nullptr;
    if (node.expression)
    {
        if (AE = dynamic_cast<ASTAssignExpression *>(node.expression.get()))
        {
            AE->accept(*this);
        }
        else if (SE = dynamic_cast<ASTSimpleExpression *>(node.expression.get()))
        {
            SE->accept(*this);
        }
    }
    Type *eleType = context.varAddr->get_type()->get_pointer_element_type();
    if (eleType->is_int32_type() && context.NumType != TYPE_INT)
    {
        context.Num = builder->create_fptosi(context.Num, INT32_T);
        context.NumType = TYPE_INT;
        builder->create_store(context.Num, context.varAddr);
    }
    else if (eleType->is_float_type() && context.NumType != TYPE_FLOAT)
    {
        context.Num = builder->create_sitofp(context.Num, FLOAT_T);
        context.NumType = TYPE_FLOAT;
        builder->create_store(context.Num, context.varAddr);
    }
    else
    {
        builder->create_store(context.Num, context.varAddr);
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTSimpleExpression &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    Value *lvalue = nullptr, *rvalue = nullptr, *expCmp = nullptr;
    bool ltype = 0, rtype = 0;
    if (node.additive_expression_r != nullptr)
    {
        node.additive_expression_l->accept(*this);
        lvalue = context.Num;
        if (context.NumType == TYPE_INT)
        {
            ltype = 0;
        }
        else if (context.NumType == TYPE_FLOAT)
        {
            ltype = 1;
        }
        context.NumType = TYPE_VOID;
        node.additive_expression_r->accept(*this);
        rvalue = context.Num;
        if (context.NumType == TYPE_INT)
        {
            rtype = 0;
        }
        else if (context.NumType == TYPE_FLOAT)
        {
            rtype = 1;
        }
        context.NumType = TYPE_INT;
        if (ltype == false && rtype == false)
        {
            switch (node.op)
            {
            case OP_LE:
            {
                expCmp = builder->create_icmp_le(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_LT:
            {
                expCmp = builder->create_icmp_lt(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_GT:
            {
                expCmp = builder->create_icmp_gt(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_GE:
            {
                expCmp = builder->create_icmp_ge(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_EQ:
            {
                expCmp = builder->create_icmp_eq(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_NEQ:
            {
                expCmp = builder->create_icmp_ne(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            default:
            {
                break;
            }
            }
        }
        else
        {
            lvalue = (ltype == false) ? builder->create_sitofp(lvalue, FLOAT_T) : lvalue;
            rvalue = (rtype == false) ? builder->create_sitofp(rvalue, FLOAT_T) : rvalue;
            switch (node.op)
            {
            case OP_LE:
            {
                expCmp = builder->create_fcmp_le(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_LT:
            {
                expCmp = builder->create_fcmp_lt(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_GT:
            {
                expCmp = builder->create_fcmp_gt(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_GE:
            {
                expCmp = builder->create_fcmp_ge(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_EQ:
            {
                expCmp = builder->create_fcmp_eq(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            case OP_NEQ:
            {
                expCmp = builder->create_fcmp_ne(lvalue, rvalue);
                context.Num = builder->create_zext(expCmp, INT32_T);
                break;
            }
            default:
            {
                break;
            }
            }
        }
    }
    else
    {
        node.additive_expression_l->accept(*this);
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTAdditiveExpression &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    Value *lvalue = nullptr, *rvalue = nullptr;
    bool ltype = 0, rtype = 0;
    if (node.additive_expression != nullptr)
    {
        node.additive_expression->accept(*this);
        lvalue = context.Num;
        if (context.NumType == TYPE_INT)
        {
            ltype = 0;
        }
        else if (context.NumType == TYPE_FLOAT)
        {
            ltype = 1;
        }
        context.NumType = TYPE_VOID;
        node.term->accept(*this);
        rvalue = context.Num;
        if (context.NumType == TYPE_INT)
        {
            rtype = 0;
        }
        else if (context.NumType == TYPE_FLOAT)
        {
            rtype = 1;
        }
        context.NumType = TYPE_VOID;
        if (ltype == false && rtype == false)
        {
            switch (node.op)
            {
            case OP_PLUS:
            {
                context.Num = builder->create_iadd(lvalue, rvalue);
                break;
            }
            case OP_MINUS:
            {
                context.Num = builder->create_isub(lvalue, rvalue);
                break;
            }
            }
            context.NumType = TYPE_INT;
        }
        else
        {
            lvalue = (ltype == false) ? builder->create_sitofp(lvalue, FLOAT_T) : lvalue;
            rvalue = (rtype == false) ? builder->create_sitofp(rvalue, FLOAT_T) : rvalue;
            switch (node.op)
            {
            case OP_PLUS:
            {
                context.Num = builder->create_fadd(lvalue, rvalue);
                break;
            }
            case OP_MINUS:
            {
                context.Num = builder->create_fsub(lvalue, rvalue);
                break;
            }
            }
            context.NumType = TYPE_FLOAT;
        }
    }
    else
    {
        node.term->accept(*this);
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTTerm &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    Value *lvalue = nullptr, *rvalue = nullptr;
    bool ltype = 0, rtype = 0;
    if (node.term != nullptr)
    {
        node.term->accept(*this);
        lvalue = context.Num;
        if (context.NumType == TYPE_INT)
        {
            ltype = 0;
        }
        else if (context.NumType == TYPE_FLOAT)
        {
            ltype = 1;
        }
        context.NumType = TYPE_VOID;
        node.factor->accept(*this);
        rvalue = context.Num;
        if (context.NumType == TYPE_INT)
        {
            rtype = 0;
        }
        else if (context.NumType == TYPE_FLOAT)
        {
            rtype = 1;
        }
        context.NumType = TYPE_VOID;
        if (ltype == false && rtype == false)
        {
            switch (node.op)
            {
            case OP_MUL:
            {
                context.Num = builder->create_imul(lvalue, rvalue);
                break;
            }
            case OP_DIV:
            {
                context.Num = builder->create_isdiv(lvalue, rvalue);
                break;
            }
            }
            context.NumType = TYPE_INT;
        }
        else
        {
            lvalue = (ltype == false) ? builder->create_sitofp(lvalue, FLOAT_T) : lvalue;
            rvalue = (rtype == false) ? builder->create_sitofp(rvalue, FLOAT_T) : rvalue;
            switch (node.op)
            {
            case OP_MUL:
            {
                context.Num = builder->create_fmul(lvalue, rvalue);
                break;
            }
            case OP_DIV:
            {
                context.Num = builder->create_fdiv(lvalue, rvalue);
                break;
            }
            }
            context.NumType = TYPE_FLOAT;
        }
    }
    else
    {
        ASTNum *Num = nullptr;
        ASTExpression *Exp = nullptr;
        ASTVar *Var = nullptr;
        ASTCall *Call = nullptr;
        if (Num = dynamic_cast<ASTNum *>(node.factor.get()))
        {
            Num->accept(*this);
        }
        else if (Exp = dynamic_cast<ASTExpression *>(node.factor.get()))
        {
            Exp->accept(*this);
        }
        else if (Var = dynamic_cast<ASTVar *>(node.factor.get()))
        {
            Var->accept(*this);
        }
        else if (Call = dynamic_cast<ASTCall *>(node.factor.get()))
        {
            Call->accept(*this);
        }
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTCall &node)
{
    // TODO: This function is empty now.
    // Add some code here.
    std::vector<Value *> fun_args;
    Function *func = dynamic_cast<Function *>(scope.find(node.id));
    Type *argType = nullptr;
    int i = 0;
    for (auto &arg : node.args)
    {
        ASTAssignExpression *AE = nullptr;
        ASTSimpleExpression *SE = nullptr;
        if (AE = dynamic_cast<ASTAssignExpression *>(arg.get()))
        {
            AE->accept(*this);
        }
        else if (SE = dynamic_cast<ASTSimpleExpression *>(arg.get()))
        {
            SE->accept(*this);
        }
        argType = func->get_function_type()->get_param_type(i);
        if (argType->is_pointer_type())
        {
            fun_args.push_back(context.varAddr);
        }
        else
        {
            if (argType->is_float_type() && context.NumType != TYPE_FLOAT)
            {
                auto temp = builder->create_sitofp(context.Num, FLOAT_T);
                fun_args.push_back(temp);
            }
            else if (argType->is_integer_type() && context.NumType != TYPE_INT)
            {
                auto temp = builder->create_fptosi(context.Num, INT32_T);
                fun_args.push_back(temp);
            }
            else
            {
                fun_args.push_back(context.Num);
            }
        }
        i++;
    }
    context.Num = builder->create_call(func, fun_args);
    return nullptr;
}
