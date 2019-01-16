#!/usr/bin/env bash

format_reset="\e[0m"
format_reset_bold="\e[21m"
format_bold="\e[1m"
format_red="\e[91m"
format_invert="\e[7m"
format_green="\e[32m"
format_yellow="\e[33m"

function invert() {
    echo -e `echo -e "${format_invert}$1${format_reset}${format_reset_bold}"`
}

function yellow() {
    echo -e `echo -e "${format_bold}${format_yellow}$1${format_reset}${format_reset_bold}"`
}

function green() {
    echo -e `echo -e "${format_bold}${format_green}$1${format_reset}${format_reset_bold}"`
}

function red() {
    echo -e `echo -e "${format_bold}${format_red}$1${format_reset}${format_reset_bold}"`
}

function bold() {
    echo -e "${format_bold}$1${format_reset}${format_reset_bold}"
}

function trim() {
    echo "$(echo -e "$1" | tr -d '[:space:]')"
}

function explode() {
    echo $(echo $1| cut -d "$2" -f $3)
}

function MD5() {
    md5=`md5sum $1`
    md5=`trim $md5`
    echo "${md5}"
}

function nvl() {
    if [ -z "$2" ]; then fallback=""; else fallback=$2; fi
    if [ -z "$1" ]; then input=fallback; else input=$1; fi
    echo "${input}"
}

function assert_equal() {
    given="$1"
    expected="$2"
    message="$3"
    flag=""
    out=""
    if [ "$given" != "$expected" ]
    then
        flag=`invert " FAIL: "`
        flag=`red "$flag"`
        out="${flag} ${message}"
    else
        flag=`invert " PASS: "`
        flag=`green "$flag"`
        out="${flag} ${message}"
        let "tests++"
    fi
    echo -e "$out"
}

function is_fail() {
    status=$1
    fail=$2
    if echo "$status" | grep ' FAIL'
    then
        let "fail++"
    fi
    echo "$fail"
}

tests=0
failed=0

echo "------------------------------------------------"
echo "|     Unit tests reporter                      |"
echo "------------------------------------------------"
echo ""

# ------------------------------------------------------------------------
let "tests++" # increments the test value
assertion=`assert_equal "given" "expected" "Comparing given with expected"`
echo $assertion
failed=`is_fail "$assertion" "$failed"`


# ------------------------------------------------------------------------
let "tests++" # increments the test value
echo -e `assert_equal "given" "expected" "Comparing given with expected"`
failed=`is_fail "$assertion" "$failed"`





echo -e "$reporter"


