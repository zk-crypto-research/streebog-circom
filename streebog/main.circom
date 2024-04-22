pragma circom 2.0.0;
include "L.circom";

template Debug () {  

    signal input a[64];  
    signal output out[64];  
    component l = L();

    l.a <== a;
    out <== l.out;
}

 component main = Debug();