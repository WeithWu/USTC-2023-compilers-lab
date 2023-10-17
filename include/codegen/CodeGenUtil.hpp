#pragma once

#include <stdexcept>

/* 关于位宽 */
#define IMM_12_MAX 0x7FF
#define IMM_12_MIN -0x800

#define LOW_12_MASK 0x00000FFF
#define LOW_20_MASK 0x000FFFFF
#define LOW_32_MASK 0xFFFFFFFF

inline unsigned ALIGN(unsigned x, unsigned alignment) {
    return ((x + (alignment - 1)) & ~(alignment - 1));
}

inline bool IS_IMM_12(int x) { return x <= IMM_12_MAX and x >= IMM_12_MIN; }

/* 栈帧相关 */
#define PROLOGUE_OFFSET_BASE 16 // $ra $fp
#define PROLOGUE_ALIGN 16

/* 龙芯指令 */
// Arithmetic
#define ADD "add"
#define SUB "sub"
#define MUL "mul"
#define DIV "div"

#define ADDI "addi"

#define FADD "fadd"
#define FSUB "fsub"
#define FMUL "fmul"
#define FDIV "fdiv"

#define ORI "ori"

#define LU12I_W "lu12i.w"
#define LU32I_D "lu32i.d"
#define LU52I_D "lu52i.d"

// Data transfer (greg <-> freg)
#define GR2FR "movgr2fr"
#define FR2GR "movfr2gr"

// Memory access
#define LOAD "ld"
#define STORE "st"
#define FLOAD "fld"
#define FSTORE "fst"

#define BYTE ".b"
#define HALF_WORD ".h"
#define WORD ".w"
#define DOUBLE ".d"

#define SINGLE ".s" // float
#define LONG ".l"

// ASM syntax sugar
#define LOAD_ADDR "la.local"

// errors
class not_implemented_error : public std::logic_error {
  public:
    explicit not_implemented_error(std::string &&err_msg = "")
        : std::logic_error(err_msg){};
};

class unreachable_error : public std::logic_error {
  public:
    explicit unreachable_error(std::string &&err_msg = "")
        : std::logic_error(err_msg){};
};
