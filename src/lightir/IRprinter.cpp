#include "IRprinter.hpp"
#include "Instruction.hpp"
#include <cassert>
#include <type_traits>

std::string print_as_op(Value *v, bool print_ty) {
    std::string op_ir;
    if (print_ty) {
        op_ir += v->get_type()->print();
        op_ir += " ";
    }

    if (dynamic_cast<GlobalVariable *>(v)) {
        op_ir += "@" + v->get_name();
    } else if (dynamic_cast<Function *>(v)) {
        op_ir += "@" + v->get_name();
    } else if (dynamic_cast<Constant *>(v)) {
        op_ir += v->print();
    } else {
        op_ir += "%" + v->get_name();
    }

    return op_ir;
}

std::string print_instr_op_name(Instruction::OpID id) {
    switch (id) {
    case Instruction::ret:
        return "ret";
    case Instruction::br:
        return "br";
    case Instruction::add:
        return "add";
    case Instruction::sub:
        return "sub";
    case Instruction::mul:
        return "mul";
    case Instruction::sdiv:
        return "sdiv";
    case Instruction::fadd:
        return "fadd";
    case Instruction::fsub:
        return "fsub";
    case Instruction::fmul:
        return "fmul";
    case Instruction::fdiv:
        return "fdiv";
    case Instruction::alloca:
        return "alloca";
    case Instruction::load:
        return "load";
    case Instruction::store:
        return "store";
    case Instruction::ge:
        return "sge";
    case Instruction::gt:
        return "sgt";
    case Instruction::le:
        return "sle";
    case Instruction::lt:
        return "slt";
    case Instruction::eq:
        return "eq";
    case Instruction::ne:
        return "ne";
    case Instruction::fge:
        return "uge";
    case Instruction::fgt:
        return "ugt";
    case Instruction::fle:
        return "ule";
    case Instruction::flt:
        return "ult";
    case Instruction::feq:
        return "ueq";
    case Instruction::fne:
        return "une";
    case Instruction::phi:
        return "phi";
    case Instruction::call:
        return "call";
    case Instruction::getelementptr:
        return "getelementptr";
    case Instruction::zext:
        return "zext";
    case Instruction::fptosi:
        return "fptosi";
    case Instruction::sitofp:
        return "sitofp";
    }
    assert(false && "Must be bug");
}

template <class BinInst> std::string print_binary_inst(const BinInst &inst) {
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += inst.get_name();
    instr_ir += " = ";
    instr_ir += inst.get_instr_op_name();
    instr_ir += " ";
    instr_ir += inst.get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(inst.get_operand(0), false);
    instr_ir += ", ";
    if (inst.get_operand(0)->get_type() == inst.get_operand(1)->get_type()) {
        instr_ir += print_as_op(inst.get_operand(1), false);
    } else {
        instr_ir += print_as_op(inst.get_operand(1), true);
    }
    return instr_ir;
}
std::string IBinaryInst::print() { return print_binary_inst(*this); }
std::string FBinaryInst::print() { return print_binary_inst(*this); }

template <class CMP> std::string print_cmp_inst(const CMP &inst) {
    std::string cmp_type;
    if (inst.is_cmp())
        cmp_type = "icmp";
    else if (inst.is_fcmp())
        cmp_type = "fcmp";
    else
        assert(false && "Unexpected case");
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += inst.get_name();
    instr_ir += " = " + cmp_type + " ";
    instr_ir += inst.get_instr_op_name();
    instr_ir += " ";
    instr_ir += inst.get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(inst.get_operand(0), false);
    instr_ir += ", ";
    if (inst.get_operand(0)->get_type() == inst.get_operand(1)->get_type()) {
        instr_ir += print_as_op(inst.get_operand(1), false);
    } else {
        instr_ir += print_as_op(inst.get_operand(1), true);
    }
    return instr_ir;
}
std::string ICmpInst::print() { return print_cmp_inst(*this); }
std::string FCmpInst::print() { return print_cmp_inst(*this); }

std::string CallInst::print() {
    std::string instr_ir;
    if (!this->is_void()) {
        instr_ir += "%";
        instr_ir += this->get_name();
        instr_ir += " = ";
    }
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    instr_ir += this->get_function_type()->get_return_type()->print();

    instr_ir += " ";
    assert(dynamic_cast<Function *>(this->get_operand(0)) &&
           "Wrong call operand function");
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += "(";
    for (unsigned i = 1; i < this->get_num_operand(); i++) {
        if (i > 1)
            instr_ir += ", ";
        instr_ir += this->get_operand(i)->get_type()->print();
        instr_ir += " ";
        instr_ir += print_as_op(this->get_operand(i), false);
    }
    instr_ir += ")";
    return instr_ir;
}

std::string BranchInst::print() {
    std::string instr_ir;
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), true);
    if (is_cond_br()) {
        instr_ir += ", ";
        instr_ir += print_as_op(this->get_operand(1), true);
        instr_ir += ", ";
        instr_ir += print_as_op(this->get_operand(2), true);
    }
    return instr_ir;
}

std::string ReturnInst::print() {
    std::string instr_ir;
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    if (!is_void_ret()) {
        instr_ir += this->get_operand(0)->get_type()->print();
        instr_ir += " ";
        instr_ir += print_as_op(this->get_operand(0), false);
    } else {
        instr_ir += "void";
    }

    return instr_ir;
}

std::string GetElementPtrInst::print() {
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    assert(this->get_operand(0)->get_type()->is_pointer_type());
    instr_ir +=
        this->get_operand(0)->get_type()->get_pointer_element_type()->print();
    instr_ir += ", ";
    for (unsigned i = 0; i < this->get_num_operand(); i++) {
        if (i > 0)
            instr_ir += ", ";
        instr_ir += this->get_operand(i)->get_type()->print();
        instr_ir += " ";
        instr_ir += print_as_op(this->get_operand(i), false);
    }
    return instr_ir;
}

std::string StoreInst::print() {
    std::string instr_ir;
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += ", ";
    instr_ir += print_as_op(this->get_operand(1), true);
    return instr_ir;
}

std::string LoadInst::print() {
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    assert(this->get_operand(0)->get_type()->is_pointer_type());
    instr_ir +=
        this->get_operand(0)->get_type()->get_pointer_element_type()->print();
    instr_ir += ",";
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), true);
    return instr_ir;
}

std::string AllocaInst::print() {
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    instr_ir += get_alloca_type()->print();
    return instr_ir;
}

std::string ZextInst::print() {
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += " to ";
    instr_ir += this->get_dest_type()->print();
    return instr_ir;
}

std::string FpToSiInst::print() {
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += " to ";
    instr_ir += this->get_dest_type()->print();
    return instr_ir;
}

std::string SiToFpInst::print() {
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += " to ";
    instr_ir += this->get_dest_type()->print();
    return instr_ir;
}

std::string PhiInst::print() {
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += get_instr_op_name();
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    for (unsigned i = 0; i < this->get_num_operand() / 2; i++) {
        if (i > 0)
            instr_ir += ", ";
        instr_ir += "[ ";
        instr_ir += print_as_op(this->get_operand(2 * i), false);
        instr_ir += ", ";
        instr_ir += print_as_op(this->get_operand(2 * i + 1), false);
        instr_ir += " ]";
    }
    if (this->get_num_operand() / 2 <
        this->get_parent()->get_pre_basic_blocks().size()) {
        for (auto pre_bb : this->get_parent()->get_pre_basic_blocks()) {
            if (std::find(this->get_operands().begin(),
                          this->get_operands().end(),
                          static_cast<Value *>(pre_bb)) ==
                this->get_operands().end()) {
                // find a pre_bb is not in phi
                instr_ir += ", [ undef, " + print_as_op(pre_bb, false) + " ]";
            }
        }
    }
    return instr_ir;
}
