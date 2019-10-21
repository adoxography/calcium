#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"
DATA_DIR="$SCRIPT_DIR/data"
CALC="$1"

if [ -z $CALC ]; then
    make --file="$SCRIPT_DIR/../Makefile"
    CALC="$SCRIPT_DIR/../bin/calcium"
fi

total_tests=0
total_right=0

function join_by { local IFS="$1"; shift; echo "$*"; }

function test_file {
    num_right=0
    num_tests=0
    first_time=

    echo "Running $1 tests..."

    while IFS= read -r line; do
        if [ -z $first_time ]; then
            first_time=1
            continue
        fi

        if [ $(echo $line | wc -c) -eq 1 ]; then
            continue
        fi

        num_tests=$((num_tests + 1))

        input=$(echo "$line" | cut -f1 -d'	')
        target=$(echo "$line" | cut -f2 -d'	')
        issue=$(echo "$line" | cut -f3 -d'	')

        result=$($CALC "$input")

        if [ "$result" == "$target" ]; then
            num_right=$((num_right + 1))
        else
            echo "ERROR: '$input' expected to be '$target'; got '$result'"
            echo "This test checked '$issue'"
        fi
    done < $2

    total_tests=$((total_tests + num_tests))
    total_right=$((total_right + num_right))

    echo "$num_right/$num_tests correct."
}

for f in $DATA_DIR/*; do
    full_file_name=$(basename $f)
    file_name=${full_file_name%.*}

    if [ "$file_name" == 'basic' ] || [[ " $@ " =~ ' all ' ]] || [[ " $@ " =~ " $file_name " ]]; then
        test_file "$file_name" "$f"
    fi
done

echo "Tests complete. $total_right/$total_tests correct."
