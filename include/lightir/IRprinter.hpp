#pragma once

#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "GlobalVariable.hpp"
#include "Instruction.hpp"
#include "Module.hpp"
#include "Type.hpp"
#include "User.hpp"
#include "Value.hpp"

std::string print_as_op(Value *v, bool print_ty);
std::string print_instr_op_name(Instruction::OpID);
