pragma circom 2.1.5;



template PermutateTau(){
    signal input index; 
    signal output out;

    var Tau[64] = [
        0, 8, 16, 24, 32, 40, 48, 56,
        1, 9, 17, 25, 33, 41, 49, 57,
        2, 10, 18, 26, 34, 42, 50, 58,
        3, 11, 19, 27, 35, 43, 51, 59,
        4, 12, 20, 28, 36, 44, 52, 60,
        5, 13, 21, 29, 37, 45, 53, 61,
        6, 14, 22, 30, 38, 46, 54, 62,
        7, 15, 23, 31, 39, 47, 55, 63
    ];

    signal intermediate[64];
    for (var i = 0; i < 64; i++) {
        var isIndex = IsEqual()([index, i]);
        intermediate[i] <== isIndex * Tau[i];
    }

    out <== Adder(64)(intermediate);
}

template PermutateState(){
    signal input in[64];
    signal input index;
    signal output out;

    signal intermediate[64];
    for (var i = 0; i < 64; i++) {
        var isIndex = IsEqual()([index, i]);
        intermediate[i] <== isIndex * in[i];
    }

    out <== Adder(64)(intermediate);
}

template P() {
    signal input a[64];
    signal output out[64];
    component permutationsTau[64];
    component permutations[64];
 
    for (var i = 0; i < 64; i++) {
        permutationsTau[i] = PermutateTau();
        permutationsTau[i].index <== i;
    }

    for (var i = 0; i < 64; i++) {
        permutations[i] = PermutateState();
        permutations[i].in <== a;
        permutations[i].index <== permutationsTau[i].out;
    }

    for (var i = 0; i < 64; i++) {
        out[i] <== permutations[i].out;
    }

}