pragma circom 2.0.0;
include "../gates.circom";
include "utils.circom";
template X() {
    signal input a[64];
    signal input b[64];
    signal output out[64];
    component xors[64];
    for (var k=0; k<64; k++) {
        xors[k] = BitwiseXOR(8);
        xors[k].a <== a[k];
        xors[k].b <== b[k];
    }
    for (var k=0; k<64; k++) {
        out[k] <== xors[k].out;
    }
}
