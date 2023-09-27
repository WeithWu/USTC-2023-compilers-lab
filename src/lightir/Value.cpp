#include "Value.hpp"
#include "Type.hpp"
#include "User.hpp"

#include <cassert>

bool Value::set_name(std::string name) {
    if (name_ == "") {
        name_ = name;
        return true;
    }
    return false;
}

void Value::add_use(User *user, unsigned arg_no) {
    use_list_.emplace_back(user, arg_no);
};

void Value::remove_use(User *user, unsigned arg_no) {
    auto target_use = Use(user, arg_no);
    use_list_.remove_if([&](const Use &use) { return use == target_use; });
}

void Value::replace_all_use_with(Value *new_val) {
    if (this == new_val)
        return;
    while (use_list_.size()) {
        auto use = use_list_.begin();
        use->val_->set_operand(use->arg_no_, new_val);
    }
}

void Value::replace_use_with_if(Value *new_val,
                                std::function<bool(Use)> should_replace) {
    if (this == new_val)
        return;
    for (auto iter = use_list_.begin(); iter != use_list_.end();) {
        auto use = *iter++;
        if (not should_replace(use))
            continue;
        use.val_->set_operand(use.arg_no_, new_val);
    }
}
