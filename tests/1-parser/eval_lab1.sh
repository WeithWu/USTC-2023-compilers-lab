#!/bin/bash

# DO NOT MODIFY!
# If you need customized behavior, please create your own script.

if [[ $# -lt 1 ]]; then
    echo "usage: ./eval_lab1.sh   <input> [<summary>]"
    echo "       <input> can be one of 'easy', 'normal', 'hard', and 'testcases_general'."
    echo "       <summary> can be one of 'no', 'yes', and 'verbose'. the default value is 'no'"
    exit 1
fi
CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TESTCASE="${1:-testcase}"
if [[ $TESTCASE == 'easy' || $TESTCASE == 'normal' || $TESTCASE == 'hard' ]]; then
    TESTCASE_DIR="$CUR_DIR/input/$TESTCASE"
elif [[ $TESTCASE == 'testcases_general' ]]; then
    TESTCASE_DIR="$CUR_DIR/../$TESTCASE"
fi
OUTPUT_DIR="$CUR_DIR/output_student/$TESTCASE"
OUTPUT_STD_DIR="$CUR_DIR/output_standard/$TESTCASE"
BUILD_DIR="$CUR_DIR/../../build"

# Make sure $OUTPUT_DIR exists.
mkdir -p "$OUTPUT_DIR"

# Generate a .syntax_tree file for all .cminus files in the testcase dir.
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for testcase in "$TESTCASE_DIR"/*.cminus
do
    filename="$(basename $testcase)"
    echo "[info] Analyzing $filename"
    "$BUILD_DIR"/parser "$testcase" > "$OUTPUT_DIR/${filename%.cminus}.syntax_tree"
done

# Output a summary when requested.
if [[ ${2:-no} != "no" ]]; then
    echo "[info] Comparing..."
    if [[ ${2:-no} == "verbose" ]]; then
        diff "$OUTPUT_DIR" "$OUTPUT_STD_DIR"
    else
        diff -qr "$OUTPUT_DIR" "$OUTPUT_STD_DIR"
    fi
    if [ $? -eq 0 ]; then
        echo "[info] No difference! Congratulations!"
    fi
fi

IFS=$SAVEIFS
