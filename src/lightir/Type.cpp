#include "Type.hpp"
#include "Module.hpp"

#include <array>
#include <cassert>
#include <stdexcept>

Type::Type(TypeID tid, Module *m) {
    tid_ = tid;
    m_ = m;
}

bool Type::is_int1_type() const {
    return is_integer_type() and
           static_cast<const IntegerType *>(this)->get_num_bits() == 1;
}
bool Type::is_int32_type() const {
    return is_integer_type() and
           static_cast<const IntegerType *>(this)->get_num_bits() == 32;
}

Type *Type::get_pointer_element_type() const {
    if (this->is_pointer_type())
        return static_cast<const PointerType *>(this)->get_element_type();
    assert(false and "get_pointer_element_type() called on non-pointer type");
}

Type *Type::get_array_element_type() const {
    if (this->is_array_type())
        return static_cast<const ArrayType *>(this)->get_element_type();
    assert(false and "get_array_element_type() called on non-array type");
}

unsigned Type::get_size() const {
    switch (get_type_id()) {
    case IntegerTyID: {
        if (is_int1_type())
            return 1;
        else if (is_int32_type())
            return 4;
        else
            assert(false && "Type::get_size(): unexpected int type bits");
    }
    case ArrayTyID: {
        auto array_type = static_cast<const ArrayType *>(this);
        auto element_size = array_type->get_element_type()->get_size();
        auto num_elements = array_type->get_num_of_elements();
        return element_size * num_elements;
    }
    case PointerTyID:
        return 8;
    case FloatTyID:
        return 4;
    case VoidTyID:
    case LabelTyID:
    case FunctionTyID:
        assert(false && "bad use on get_size()");
    }
    assert(false && "unreachable");
}

std::string Type::print() const {
    std::string type_ir;
    switch (this->get_type_id()) {
    case VoidTyID:
        type_ir += "void";
        break;
    case LabelTyID:
        type_ir += "label";
        break;
    case IntegerTyID:
        type_ir += "i";
        type_ir += std::to_string(
            static_cast<const IntegerType *>(this)->get_num_bits());
        break;
    case FunctionTyID:
        type_ir +=
            static_cast<const FunctionType *>(this)->get_return_type()->print();
        type_ir += " (";
        for (unsigned i = 0;
             i < static_cast<const FunctionType *>(this)->get_num_of_args();
             i++) {
            if (i)
                type_ir += ", ";
            type_ir += static_cast<const FunctionType *>(this)
                           ->get_param_type(i)
                           ->print();
        }
        type_ir += ")";
        break;
    case PointerTyID:
        type_ir += this->get_pointer_element_type()->print();
        type_ir += "*";
        break;
    case ArrayTyID:
        type_ir += "[";
        type_ir += std::to_string(
            static_cast<const ArrayType *>(this)->get_num_of_elements());
        type_ir += " x ";
        type_ir +=
            static_cast<const ArrayType *>(this)->get_element_type()->print();
        type_ir += "]";
        break;
    case FloatTyID:
        type_ir += "float";
        break;
    default:
        break;
    }
    return type_ir;
}

IntegerType::IntegerType(unsigned num_bits, Module *m)
    : Type(Type::IntegerTyID, m), num_bits_(num_bits) {}

unsigned IntegerType::get_num_bits() const { return num_bits_; }

FunctionType::FunctionType(Type *result, std::vector<Type *> params)
    : Type(Type::FunctionTyID, nullptr) {
    assert(is_valid_return_type(result) && "Invalid return type for function!");
    result_ = result;

    for (auto p : params) {
        assert(is_valid_argument_type(p) &&
               "Not a valid type for function argument!");
        args_.push_back(p);
    }
}

bool FunctionType::is_valid_return_type(Type *ty) {
    return ty->is_integer_type() || ty->is_void_type() || ty->is_float_type();
}

bool FunctionType::is_valid_argument_type(Type *ty) {
    return ty->is_integer_type() || ty->is_pointer_type() ||
           ty->is_float_type();
}

FunctionType *FunctionType::get(Type *result, std::vector<Type *> params) {
    return result->get_module()->get_function_type(result, params);
}

unsigned FunctionType::get_num_of_args() const { return args_.size(); }

Type *FunctionType::get_param_type(unsigned i) const { return args_[i]; }

Type *FunctionType::get_return_type() const { return result_; }

ArrayType::ArrayType(Type *contained, unsigned num_elements)
    : Type(Type::ArrayTyID, contained->get_module()),
      num_elements_(num_elements) {
    assert(is_valid_element_type(contained) &&
           "Not a valid type for array element!");
    contained_ = contained;
}

bool ArrayType::is_valid_element_type(Type *ty) {
    return ty->is_integer_type() || ty->is_array_type() || ty->is_float_type();
}

ArrayType *ArrayType::get(Type *contained, unsigned num_elements) {
    return contained->get_module()->get_array_type(contained, num_elements);
}

PointerType::PointerType(Type *contained)
    : Type(Type::PointerTyID, contained->get_module()), contained_(contained) {
    static const std::array allowed_elem_type = {
        Type::IntegerTyID, Type::FloatTyID, Type::ArrayTyID, Type::PointerTyID};
    auto elem_type_id = contained->get_type_id();
    assert(std::find(allowed_elem_type.begin(), allowed_elem_type.end(),
                     elem_type_id) != allowed_elem_type.end() &&
           "Not allowed type for pointer");
}

PointerType *PointerType::get(Type *contained) {
    return contained->get_module()->get_pointer_type(contained);
}

FloatType::FloatType(Module *m) : Type(Type::FloatTyID, m) {}

FloatType *FloatType::get(Module *m) { return m->get_float_type(); }
