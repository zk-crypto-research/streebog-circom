pragma circom 2.0.0;
include "g.circom";

template Debug () {  

    signal input N[64];  
    signal input m[64];  
    signal input h[64];  
    signal output out[64];  
    component g = g();

    g.N <== N;
    g.m <== m;
    g.h <== h;
    out <== g.out;
}

 component main = Debug();