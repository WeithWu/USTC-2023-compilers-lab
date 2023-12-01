#include "Dominators.hpp"

void Dominators::run() {
    for (auto& f1 : m_->get_functions()) {
        auto f = &f1;
        if (f->get_basic_blocks().size() == 0)
            continue;
        for (auto& bb1 : f->get_basic_blocks()) {
            auto bb = &bb1;
            idom_.insert({ bb, {} });
            dom_frontier_.insert({ bb, {} });
            dom_tree_succ_blocks_.insert({ bb, {} });
        }

        create_idom(f);
        create_dominance_frontier(f);
        create_dom_tree_succ(f);
    }
}

void Dominators::create_idom(Function* f) {
    // TODO 分析得到 f 中各个基本块的 idom
    bool changed = true;BasicBlock* new_idom = nullptr;
    idom_[f->get_entry_block()] = f->get_entry_block();
    std::list<BasicBlock*> queue;
    BBSet bb_processed;
    while (changed) {
        changed = false;
        queue.push_back(f->get_entry_block());
        bb_processed.clear();
        while (!queue.empty()) {
            auto it = queue.front();
            queue.pop_front();
            if (bb_processed.insert(it).second)
            {
                for (auto t : it->get_succ_basic_blocks()) {
                    if (t != nullptr) queue.push_back(t);
                }
                if (it != f->get_entry_block()) {
                    new_idom = first_processed_pred(it, bb_processed);
                    for (auto pred : it->get_pre_basic_blocks()) {
                        if (idom_[pred] != nullptr) {
                            new_idom = intersect(pred, new_idom);
                        }
                    }
                    if (idom_[it] != new_idom) {
                        idom_[it] = new_idom;
                        changed = true;
                    }
                }
            }
        }
    }
}

void Dominators::create_dominance_frontier(Function* f) {
    // TODO 分析得到 f 中各个基本块的支配边界集合
    BasicBlock* runner = nullptr;
    for (auto it = f->get_basic_blocks().begin();it != f->get_basic_blocks().end();it++) {
        if ((&*it)->get_pre_basic_blocks().size() >= 2) {
            for (auto pred : (&*it)->get_pre_basic_blocks()) {
                runner = pred;
                while (runner != idom_[&*it]) {
                    dom_frontier_[runner].insert(&*it);
                    runner = idom_[runner];
                }
            }
        }
    }
}

void Dominators::create_dom_tree_succ(Function* f) {
    // TODO 分析得到 f 中各个基本块的支配树后继
    for (auto it = f->get_basic_blocks().begin();it != f->get_basic_blocks().end();it++) {
        if (&*it != f->get_entry_block())dom_tree_succ_blocks_[idom_[&*it]].insert(&*it);
    }
}

BasicBlock* Dominators::intersect(BasicBlock* b1, BasicBlock* b2) {
    BasicBlock* finger1 = b1;
    BasicBlock* finger2 = b2;
    while (finger1 != finger2) {
        if (cmp_bb_eq(finger1, finger2)) finger1 = get_idom(finger1);
        while (cmp_bb_slt(finger1, finger2)) {
            finger1 = get_idom(finger1);
        }
        while (cmp_bb_slt(finger2, finger1)) {
            finger2 = get_idom(finger2);
        }
    }
    return finger1;
}

bool Dominators::cmp_bb_slt(BasicBlock* b1, BasicBlock* b2) {
    if (b1 == nullptr) return false;
    if (b2 == nullptr) return true;
    BasicBlock* finger1 = b1;
    BasicBlock* finger2 = b2;
    while (!finger1->get_pre_basic_blocks().empty() && !finger2->get_pre_basic_blocks().empty()) {
        finger1 = finger1->get_pre_basic_blocks().front();
        finger2 = finger2->get_pre_basic_blocks().front();
    }
    return !finger1->get_pre_basic_blocks().empty();
}
bool Dominators::cmp_bb_eq(BasicBlock* b1, BasicBlock* b2) {
    if (b2 == nullptr && b2 == nullptr) return true;
    if (b1 == nullptr || b2 == nullptr) return false;
    BasicBlock* finger1 = b1;
    BasicBlock* finger2 = b2;
    while (!finger1->get_pre_basic_blocks().empty() && !finger2->get_pre_basic_blocks().empty()) {
        finger1 = finger1->get_pre_basic_blocks().front();
        finger2 = finger2->get_pre_basic_blocks().front();
    }
    return finger1->get_pre_basic_blocks().empty() && finger2->get_pre_basic_blocks().empty();
}

BasicBlock* Dominators::first_processed_pred(BasicBlock* bb, BBSet& processed) {
    for (auto preb : bb->get_pre_basic_blocks()) {
        if (processed.find(preb) != processed.end()) {
            return preb;
        }

    }
    return nullptr;
}