#pragma once

#include "Type.hpp"
#include "User.hpp"

#include <cstdint>
#include <llvm/ADT/ilist_node.h>

class BasicBlock;
class Function;

class Instruction : public User, public llvm::ilist_node<Instruction> {
  public:
    enum OpID : uint32_t {
        // Terminator Instructions
        ret,
        br,
        // Standard binary operators
        add,
        sub,
        mul,
        sdiv,
        // float binary operators
        fadd,
        fsub,
        fmul,
        fdiv,
        // Memory operators
        alloca,
        load,
        store,
        // Int compare operators
        ge,
        gt,
        le,
        lt,
        eq,
        ne,
        // Float compare operators
        fge,
        fgt,
        fle,
        flt,
        feq,
        fne,
        // Other operators
        phi,
        call,
        getelementptr,
        zext, // zero extend
        fptosi,
        sitofp
        // float binary operators Logical operators

    };
    /* @parent: if parent!=nullptr, auto insert to bb
     * @ty: result type */
    Instruction(Type *ty, OpID id, BasicBlock *parent = nullptr);
    Instruction(const Instruction &) = delete;
    virtual ~Instruction() = default;

    BasicBlock *get_parent() { return parent_; }
    const BasicBlock *get_parent() const { return parent_; }
    void set_parent(BasicBlock *parent) { this->parent_ = parent; }

    // Return the function this instruction belongs to.
    Function *get_function();
    Module *get_module();

    OpID get_instr_type() const { return op_id_; }
    std::string get_instr_op_name() const;

    bool is_void() {
        return ((op_id_ == ret) || (op_id_ == br) || (op_id_ == store) ||
                (op_id_ == call && this->get_type()->is_void_type()));
    }

    bool is_phi() const { return op_id_ == phi; }
    bool is_store() const { return op_id_ == store; }
    bool is_alloca() const { return op_id_ == alloca; }
    bool is_ret() const { return op_id_ == ret; }
    bool is_load() const { return op_id_ == load; }
    bool is_br() const { return op_id_ == br; }

    bool is_add() const { return op_id_ == add; }
    bool is_sub() const { return op_id_ == sub; }
    bool is_mul() const { return op_id_ == mul; }
    bool is_div() const { return op_id_ == sdiv; }

    bool is_fadd() const { return op_id_ == fadd; }
    bool is_fsub() const { return op_id_ == fsub; }
    bool is_fmul() const { return op_id_ == fmul; }
    bool is_fdiv() const { return op_id_ == fdiv; }
    bool is_fp2si() const { return op_id_ == fptosi; }
    bool is_si2fp() const { return op_id_ == sitofp; }

    bool is_cmp() const { return ge <= op_id_ and op_id_ <= ne; }
    bool is_fcmp() const { return fge <= op_id_ and op_id_ <= fne; }

    bool is_call() const { return op_id_ == call; }
    bool is_gep() const { return op_id_ == getelementptr; }
    bool is_zext() const { return op_id_ == zext; }

    bool isBinary() const {
        return (is_add() || is_sub() || is_mul() || is_div() || is_fadd() ||
                is_fsub() || is_fmul() || is_fdiv()) &&
               (get_num_operand() == 2);
    }

    bool isTerminator() const { return is_br() || is_ret(); }

  private:
    OpID op_id_;
    BasicBlock *parent_;
};

template <typename Inst> class BaseInst : public Instruction {
  protected:
    template <typename... Args> static Inst *create(Args &&...args) {
        return new Inst(std::forward<Args>(args)...);
    }

    template <typename... Args>
    BaseInst(Args &&...args) : Instruction(std::forward<Args>(args)...) {}
};

class IBinaryInst : public BaseInst<IBinaryInst> {
    friend BaseInst<IBinaryInst>;

  private:
    IBinaryInst(OpID id, Value *v1, Value *v2, BasicBlock *bb);

  public:
    static IBinaryInst *create_add(Value *v1, Value *v2, BasicBlock *bb);
    static IBinaryInst *create_sub(Value *v1, Value *v2, BasicBlock *bb);
    static IBinaryInst *create_mul(Value *v1, Value *v2, BasicBlock *bb);
    static IBinaryInst *create_sdiv(Value *v1, Value *v2, BasicBlock *bb);

    virtual std::string print() override;
};

class FBinaryInst : public BaseInst<FBinaryInst> {
    friend BaseInst<FBinaryInst>;

  private:
    FBinaryInst(OpID id, Value *v1, Value *v2, BasicBlock *bb);

  public:
    static FBinaryInst *create_fadd(Value *v1, Value *v2, BasicBlock *bb);
    static FBinaryInst *create_fsub(Value *v1, Value *v2, BasicBlock *bb);
    static FBinaryInst *create_fmul(Value *v1, Value *v2, BasicBlock *bb);
    static FBinaryInst *create_fdiv(Value *v1, Value *v2, BasicBlock *bb);

    virtual std::string print() override;
};

class ICmpInst : public BaseInst<ICmpInst> {
    friend BaseInst<ICmpInst>;

  private:
    ICmpInst(OpID id, Value *lhs, Value *rhs, BasicBlock *bb);

  public:
    static ICmpInst *create_ge(Value *v1, Value *v2, BasicBlock *bb);
    static ICmpInst *create_gt(Value *v1, Value *v2, BasicBlock *bb);
    static ICmpInst *create_le(Value *v1, Value *v2, BasicBlock *bb);
    static ICmpInst *create_lt(Value *v1, Value *v2, BasicBlock *bb);
    static ICmpInst *create_eq(Value *v1, Value *v2, BasicBlock *bb);
    static ICmpInst *create_ne(Value *v1, Value *v2, BasicBlock *bb);

    virtual std::string print() override;
};

class FCmpInst : public BaseInst<FCmpInst> {
    friend BaseInst<FCmpInst>;

  private:
    FCmpInst(OpID id, Value *lhs, Value *rhs, BasicBlock *bb);

  public:
    static FCmpInst *create_fge(Value *v1, Value *v2, BasicBlock *bb);
    static FCmpInst *create_fgt(Value *v1, Value *v2, BasicBlock *bb);
    static FCmpInst *create_fle(Value *v1, Value *v2, BasicBlock *bb);
    static FCmpInst *create_flt(Value *v1, Value *v2, BasicBlock *bb);
    static FCmpInst *create_feq(Value *v1, Value *v2, BasicBlock *bb);
    static FCmpInst *create_fne(Value *v1, Value *v2, BasicBlock *bb);

    virtual std::string print() override;
};

class CallInst : public BaseInst<CallInst> {
    friend BaseInst<CallInst>;

  protected:
    CallInst(Function *func, std::vector<Value *> args, BasicBlock *bb);

  public:
    static CallInst *create_call(Function *func, std::vector<Value *> args,
                                 BasicBlock *bb);
    FunctionType *get_function_type() const;

    virtual std::string print() override;
};

class BranchInst : public BaseInst<BranchInst> {
    friend BaseInst<BranchInst>;

  private:
    BranchInst(Value *cond, BasicBlock *if_true, BasicBlock *if_false,
               BasicBlock *bb);
    ~BranchInst();

  public:
    static BranchInst *create_cond_br(Value *cond, BasicBlock *if_true,
                                      BasicBlock *if_false, BasicBlock *bb);
    static BranchInst *create_br(BasicBlock *if_true, BasicBlock *bb);

    bool is_cond_br() const { return get_num_operand() == 3; }

    virtual std::string print() override;
};

class ReturnInst : public BaseInst<ReturnInst> {
    friend BaseInst<ReturnInst>;

  private:
    ReturnInst(Value *val, BasicBlock *bb);

  public:
    static ReturnInst *create_ret(Value *val, BasicBlock *bb);
    static ReturnInst *create_void_ret(BasicBlock *bb);
    bool is_void_ret() const;

    virtual std::string print() override;
};

class GetElementPtrInst : public BaseInst<GetElementPtrInst> {
    friend BaseInst<GetElementPtrInst>;

  private:
    GetElementPtrInst(Value *ptr, std::vector<Value *> idxs, BasicBlock *bb);

  public:
    static Type *get_element_type(Value *ptr, std::vector<Value *> idxs);
    static GetElementPtrInst *create_gep(Value *ptr, std::vector<Value *> idxs,
                                         BasicBlock *bb);
    Type *get_element_type() const;

    virtual std::string print() override;
};

class StoreInst : public BaseInst<StoreInst> {
    friend BaseInst<StoreInst>;

  private:
    StoreInst(Value *val, Value *ptr, BasicBlock *bb);

  public:
    static StoreInst *create_store(Value *val, Value *ptr, BasicBlock *bb);

    Value *get_rval() { return this->get_operand(0); }
    Value *get_lval() { return this->get_operand(1); }

    virtual std::string print() override;
};

class LoadInst : public BaseInst<LoadInst> {
    friend BaseInst<LoadInst>;

  private:
    LoadInst(Value *ptr, BasicBlock *bb);

  public:
    static LoadInst *create_load(Value *ptr, BasicBlock *bb);

    Value *get_lval() const { return this->get_operand(0); }
    Type *get_load_type() const { return get_type(); };

    virtual std::string print() override;
};

class AllocaInst : public BaseInst<AllocaInst> {
    friend BaseInst<AllocaInst>;

  private:
    AllocaInst(Type *ty, BasicBlock *bb);

  public:
    static AllocaInst *create_alloca(Type *ty, BasicBlock *bb);

    Type *get_alloca_type() const {
        return get_type()->get_pointer_element_type();
    };

    virtual std::string print() override;
};

class ZextInst : public BaseInst<ZextInst> {
    friend BaseInst<ZextInst>;

  private:
    ZextInst(Value *val, Type *ty, BasicBlock *bb);

  public:
    static ZextInst *create_zext(Value *val, Type *ty, BasicBlock *bb);
    static ZextInst *create_zext_to_i32(Value *val, BasicBlock *bb);

    Type *get_dest_type() const { return get_type(); };

    virtual std::string print() override;
};

class FpToSiInst : public BaseInst<FpToSiInst> {
    friend BaseInst<FpToSiInst>;

  private:
    FpToSiInst(Value *val, Type *ty, BasicBlock *bb);

  public:
    static FpToSiInst *create_fptosi(Value *val, Type *ty, BasicBlock *bb);
    static FpToSiInst *create_fptosi_to_i32(Value *val, BasicBlock *bb);

    Type *get_dest_type() const { return get_type(); };

    virtual std::string print() override;
};

class SiToFpInst : public BaseInst<SiToFpInst> {
    friend BaseInst<SiToFpInst>;

  private:
    SiToFpInst(Value *val, Type *ty, BasicBlock *bb);

  public:
    static SiToFpInst *create_sitofp(Value *val, BasicBlock *bb);

    Type *get_dest_type() const { return get_type(); };

    virtual std::string print() override;
};

class PhiInst : public BaseInst<PhiInst> {
    friend BaseInst<PhiInst>;

  private:
    PhiInst(Type *ty, std::vector<Value *> vals,
            std::vector<BasicBlock *> val_bbs, BasicBlock *bb);

  public:
    static PhiInst *create_phi(Type *ty, BasicBlock *bb,
                               std::vector<Value *> vals = {},
                               std::vector<BasicBlock *> val_bbs = {});

    void add_phi_pair_operand(Value *val, Value *pre_bb) {
        this->add_operand(val);
        this->add_operand(pre_bb);
    }
    virtual std::string print() override;
};
