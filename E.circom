
pragma circom 2.1.5;
include "key_schedule.circom";
include "utils.circom";

template E() {
    
    signal input K[64];
    signal input a[64];
    signal output out[64];
    component xors[64];
    var state[64];

    component x = X();
    x.a <== a;
    x.b <== K;
    
    state = x.out;
    
    var K_state[64];

    component s1 = S();
    component p1 = P();
    component l1 = L();
    component x1 = X();

    s1.a <== state;
    p1.a <== s1.out;
    l1.a <== p1.out;
    K_state = Key_schedule()(K, 0);
    x1.a <== l1.out;
    x1.b <== K;
    state = x1.out;

    component s2 = S();
    component p2 = P();
    component l2 = L();
    component x2 = X();
    s2.a <== state;
    p2.a <== s2.out;
    l2.a <== p2.out;
    K_state = Key_schedule()(K, 1);
    x2.a <== l2.out;
    x2.b <== K;
    state = x2.out;

    component s3 = S();
    component p3 = P();
    component l3 = L();
    component x3 = X();
    s3.a <== state;
    p3.a <== s3.out;
    l3.a <== p3.out;
    K_state = Key_schedule()(K_state, 2);
    x3.a <== l3.out;
    x3.b <== K;
    state = x3.out;

    component s4 = S();
    component p4 = P();
    component l4 = L();
    component x4 = X();
    s4.a <== state;
    p4.a <== s4.out;
    l4.a <== p4.out;
    K_state = Key_schedule()(K_state, 3);
    x4.a <== l4.out;
    x4.b <== K;
    state = x4.out;

    component s5 = S();
    component p5 = P();
    component l5 = L();
    component x5 = X();
    s5.a <== state;
    p5.a <== s5.out;
    l5.a <== p5.out;
    K_state = Key_schedule()(K_state, 4);
    x5.a <== l5.out;
    x5.b <== K;
    state = x5.out;

    component s6 = S();
    component p6 = P();
    component l6 = L();
    component x6 = X();
    s6.a <== state;
    p6.a <== s6.out;
    l6.a <== p6.out;
    K_state = Key_schedule()(K_state, 5);
    x6.a <== l6.out;
    x6.b <== K;
    state = x6.out;

    component s7 = S();
    component p7 = P();
    component l7 = L();
    component x7 = X();
    s7.a <== state;
    p7.a <== s7.out;
    l7.a <== p7.out;
    K_state = Key_schedule()(K_state, 6);
    x7.a <== l7.out;
    x7.b <== K;
    state = x7.out;

    component s8 = S();
    component p8 = P();
    component l8 = L();
    component x8 = X();
    s8.a <== state;
    p8.a <== s8.out;
    l8.a <== p8.out;
    K_state = Key_schedule()(K_state, 7);
    x8.a <== l8.out;
    x8.b <== K;
    state = x8.out;

    component s9 = S();
    component p9 = P();
    component l9 = L();
    component x9 = X();
    s9.a <== state;
    p9.a <== s9.out;
    l9.a <== p9.out;
    K_state = Key_schedule()(K_state, 8);
    x9.a <== l9.out;
    x9.b <== K;
    state = x9.out;

    component s10 = S();
    component p10 = P();
    component l10 = L();
    component x10 = X();
    s10.a <== state;
    p10.a <== s10.out;
    l10.a <== p10.out;
    K_state = Key_schedule()(K_state, 9);
    x10.a <== l10.out;
    x10.b <== K;
    state = x10.out;

    component s11 = S();
    component p11 = P();
    component l11 = L();
    component x11 = X();
    s11.a <== state;
    p11.a <== s11.out;
    l11.a <== p11.out;
    K_state = Key_schedule()(K_state, 110);
    x11.a <== l11.out;
    x11.b <== K;
    state = x11.out;

    component s12 = S();
    component p12 = P();
    component l12 = L();
    component x12 = X();
    s12.a <== state;
    p12.a <== s12.out;
    l12.a <== p12.out;
    K_state = Key_schedule()(K_state, 1212);
    x12.a <== l12.out;
    x12.b <== K;
    state = x12.out;

    
    out <== state;
}