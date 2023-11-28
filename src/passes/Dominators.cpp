#include "Dominators.hpp"

void Dominators::run() {
    for (auto &f1 : m_->get_functions()) {
        auto f = &f1;
        if (f->get_basic_blocks().size() == 0)
            continue;
        for (auto &bb1 : f->get_basic_blocks()) {
            auto bb = &bb1;
            idom_.insert({bb, {}});
            dom_frontier_.insert({bb, {}});
            dom_tree_succ_blocks_.insert({bb, {}});
        }

        create_idom(f);
        create_dominance_frontier(f);
        create_dom_tree_succ(f);
    }
}

void Dominators::create_idom(Function *f) {
    // TODO 分析得到 f 中各个基本块的 idom
}

void Dominators::create_dominance_frontier(Function *f) {
    // TODO 分析得到 f 中各个基本块的支配边界集合
}

void Dominators::create_dom_tree_succ(Function *f) {
    // TODO 分析得到 f 中各个基本块的支配树后继
}
