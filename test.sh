#!/bin/bash
assert() {
    expected="$1"
    input="$2"

    ./9cc "$input" > tmp.s
    cc -o tmp tmp.s
    ./tmp
    actual="$?"

    if [ "$actual" = "$expected" ]; then
      echo "$input => $actual"
    else
      echo "$input => $expected expected, but got $actual"
      exit 1
    fi
}

assert 2 "a=2;"
assert 1 "a=2;a==2;"
assert 5 "a=3;b=2;a+b;"
assert 35 "a=5;b=7;a*b;"
assert 27 "a=2; b=3; c=6; (a+1)*b*6/2;"

assert 1 "1+2==3;"
assert 1 "3+4!=5;"
assert 1 "4*5>12;"
assert 1 "2<=10/2;"
assert 0 "1 != 1;"

assert 0 '0==1;'
assert 1 '42==42;'
assert 1 '0!=1;'
assert 0 '42!=42;'

assert 1 '0<1;'
assert 0 '1<1;'
assert 0 '2<1;'
assert 1 '0<=1;'
assert 1 '1<=1;'
assert 0 '2<=1;'


echo OK