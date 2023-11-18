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

assert 2 "foo=2;"
assert 1 "ab=2;ab==2;"
assert 1 "ab=2;ab==2;"
assert 1 "foo=2;foo==2;"
assert 5 "foo=3;bar=2;foo+bar;"
assert 35 "pix=5;lax=7;pix*lax;"
assert 27 "temp1=2; temp2=3; temp3=6; (temp1+1)*temp2*temp3/2;"

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