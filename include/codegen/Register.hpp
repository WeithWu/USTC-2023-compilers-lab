#pragma once

#include <cassert>
#include <string>

/* General-purpose Register Convention:
 * Name         Alias       Meaning
 * $r0          $zero       constant 0
 * $r1          $ra         return address
 * $r2          $tp         thread pointer
 * $r3          $sp         stack pointer
 * $r4 - $r5    $a0 - $a1   argument, return value
 * $r6 - $r11   $a2 - $a7   argument
 * $r12 - $r20  $t0 - $t8   temporary
 * $r21                     saved
 * $r22         $fp / $s9   frame pointer
 * $r23 - $r31  $s0 - $s8   static
 *
 * Floating-point Register Convention
 * Name	        Alias	    Meaning
 * $f0-$f1      $fa0-$fa1   argument/return value
 * $f2-$f7      $fa2-$fa7   argument
 * $f8-$f23     $ft0-$ft15  temporary
 * $f24-$f31    $fs0-$fs7   static
 */

struct Reg {
    unsigned id;

    explicit Reg(unsigned i) : id(i) { assert(i <= 31); }
    bool operator==(const Reg &other) { return id == other.id; }

    std::string print() const;

    static Reg zero() { return Reg(0); }
    static Reg ra() { return Reg(1); }
    static Reg sp() { return Reg(3); }
    static Reg fp() { return Reg(22); }
    static Reg a(unsigned i) {
        assert(0 <= i and i <= 7);
        return Reg(i + 4);
    }
    static Reg t(unsigned i) {
        assert(0 <= i and i <= 8);
        return Reg(i + 12);
    }
    static Reg s(unsigned i) {
        assert(0 <= i and i <= 9);
        if (i == 9)
            return Reg(22);
        else
            return Reg(i + 23);
    }
};

struct FReg {
    unsigned id;

    explicit FReg(unsigned i) : id(i) { assert(i <= 31); }
    bool operator==(const FReg &other) { return id == other.id; }

    std::string print() const;

    static FReg fa(unsigned i) {
        assert(0 <= i and i <= 7);
        return FReg(i);
    }
    static FReg ft(unsigned i) {
        assert(0 <= i and i <= 15);
        return FReg(i + 8);
    }
    static FReg fs(unsigned i) {
        assert(0 <= i and i <= 7);
        return FReg(i + 24);
    }
};

struct CFReg {
    unsigned id;

    explicit CFReg(unsigned i) : id(i) { assert(i <= 7); }
    bool operator==(const CFReg &other) { return id == other.id; }

    std::string print() const { return "$fcc" + std::to_string(id); }
};
