
pragma circom 2.1.5;
include "key_schedule.circom";
include "utils.circom";
include "E.circom";
include "X.circom";

template g() {
    
    signal input N[64];
    signal input m[64];
    signal input h[64];
    signal output out[64];
    component x = X();
    x.a <== h;
    x.b <== N;
    

    component s = S();
    s.a <== x.out;

    component p = P();
    p.a <== s.out;

    component l = L();
    l.a <== p.out;

    var K[64] = l.out;
    
    var t[64] = E()(K, m);

    t = X()(h,t);
      

    out <== X()(t,m);
}