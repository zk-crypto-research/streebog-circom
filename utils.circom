pragma circom 2.0.0;
include "circomlib/circuits/gates.circom";
include "circomlib/circuits/bitify.circom";

template BitwiseXOR(n) {
    signal input a;
    signal input b;
    signal tmp_out[n];
    signal output out;
    component xors[n];
    component a_as_bits;
    a_as_bits = Num2Bits(n);
    a_as_bits.in <== a;

    component b_as_bits;
    b_as_bits = Num2Bits(n);
    b_as_bits.in <== b;

    
    for (var k=0; k<n; k++) {
        xors[k] = XOR();
        xors[k].a <== a_as_bits.out[k];
        xors[k].b <== b_as_bits.out[k];
    }

    for (var k=0; k<n; k++) {
        tmp_out[k] <== xors[k].out;
    }
    out <== Bits2Num(n)(tmp_out);
}
