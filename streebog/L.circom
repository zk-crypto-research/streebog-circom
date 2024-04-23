pragma circom 2.1.5;

include "../bitify.circom";
include "utils.circom";


template Adder(n) {
  signal input in[n];
  signal output out;

  var lc = 0;
  for (var i = 0; i < n; i++) {
    lc += in[i];
  }
  out <== lc;
}


template GetA(){
    signal input index; 
    signal output out;

    var A[64] = [
        0x8e20faa72ba0b470, 0x47107ddd9b505a38, 0xad08b0e0c3282d1c, 0xd8045870ef14980e,
        0x6c022c38f90a4c07, 0x3601161cf205268d, 0x1b8e0b0e798c13c8, 0x83478b07b2468764,
        0xa011d380818e8f40, 0x5086e740ce47c920, 0x2843fd2067adea10, 0x14aff010bdd87508,
        0x0ad97808d06cb404, 0x05e23c0468365a02, 0x8c711e02341b2d01, 0x46b60f011a83988e,
        0x90dab52a387ae76f, 0x486dd4151c3dfdb9, 0x24b86a840e90f0d2, 0x125c354207487869,
        0x092e94218d243cba, 0x8a174a9ec8121e5d, 0x4585254f64090fa0, 0xaccc9ca9328a8950,
        0x9d4df05d5f661451, 0xc0a878a0a1330aa6, 0x60543c50de970553, 0x302a1e286fc58ca7,
        0x18150f14b9ec46dd, 0x0c84890ad27623e0, 0x0642ca05693b9f70, 0x0321658cba93c138,
        0x86275df09ce8aaa8, 0x439da0784e745554, 0xafc0503c273aa42a, 0xd960281e9d1d5215,
        0xe230140fc0802984, 0x71180a8960409a42, 0xb60c05ca30204d21, 0x5b068c651810a89e,
        0x456c34887a3805b9, 0xac361a443d1c8cd2, 0x561b0d22900e4669, 0x2b838811480723ba,
        0x9bcf4486248d9f5d, 0xc3e9224312c8c1a0, 0xeffa11af0964ee50, 0xf97d86d98a327728,
        0xe4fa2054a80b329c, 0x727d102a548b194e, 0x39b008152acb8227, 0x9258048415eb419d,
        0x492c024284fbaec0, 0xaa16012142f35760, 0x550b8e9e21f7a530, 0xa48b474f9ef5dc18,
        0x70a6a56e2440598e, 0x3853dc371220a247, 0x1ca76e95091051ad, 0x0edd37c48a08a6d8,
        0x07e095624504536c, 0x8d70c431ac02a736, 0xc83862965601dd1b, 0x641c314b2b8ee083
    ];

    signal intermediate[64];
    for (var i = 0; i < 64; i++) {
        var isIndex = IsEqual()([index, i]);
        intermediate[i] <== isIndex * A[i];
    }

    out <== Adder(64)(intermediate);
}

template L() {
    signal input a[64];
    signal output out[64];
    var indexByte = 0;
    component bytes_as_bits[64];
    var matrix_sum[8] = [0,0,0,0,0,0,0,0];
    for (var i = 0; i < 64; i++){
        bytes_as_bits[i] = Num2Bits(8);
        bytes_as_bits[i].in <== a[i];
    }

    for (var i = 0; i < 8; i++){ //Перебор строк 8-байтовых слов
        for (var j = 0; j < 8; j++){ //Перебор байтов в строке
            for (var k = 0; k < 8; k++){ //Перебор бит в байте
                var isZeroBit = IsZero()(bytes_as_bits[i * 8 + j].out[k]); //Проверка значения бита
                var matrix_tmp = GetA()(j*8+k); //безусловное получение значения из матрицы
                var isIndex = IsEqual()([isZeroBit, 1]) ; //проверка значения бита
                matrix_sum[i] = BitwiseXOR(64)(matrix_tmp * isIndex, matrix_sum[i]); //если бит равен единице то строка матрицы будет сксорена 
                                                      // а если равен нулю то она станет нулевой и XOR ни к чему не приведет
            }
        }
    }
    
    for (var i = 0; i < 8; i++){
        var matrix_sum_as_bits[64] = Num2Bits(64)(matrix_sum[i]);
        out[8*i]   <== matrix_sum_as_bits[0] * 1 + matrix_sum_as_bits[1] * 2 + matrix_sum_as_bits[2] * 4 
                            + matrix_sum_as_bits[3] * 8+ matrix_sum_as_bits[4] * 16+ matrix_sum_as_bits[5] * 32 
                            + matrix_sum_as_bits[6] * 64+ matrix_sum_as_bits[7] * 128;
        
        out[8*i+1] <== matrix_sum_as_bits[8] * 1 + matrix_sum_as_bits[9] * 2 + matrix_sum_as_bits[10] * 4 
                            + matrix_sum_as_bits[11] * 8+ matrix_sum_as_bits[12] * 16+ matrix_sum_as_bits[13] * 32 
                            + matrix_sum_as_bits[14] * 64+ matrix_sum_as_bits[15] * 128;

        out[8*i+2] <== matrix_sum_as_bits[16] * 1 + matrix_sum_as_bits[17] * 2 + matrix_sum_as_bits[18] * 4 
                            + matrix_sum_as_bits[19] * 8+ matrix_sum_as_bits[20] * 16+ matrix_sum_as_bits[21] * 32 
                            + matrix_sum_as_bits[22] * 64+ matrix_sum_as_bits[23] * 128;
        out[8*i+3] <== matrix_sum_as_bits[24] * 1 + matrix_sum_as_bits[25] * 2 + matrix_sum_as_bits[26] * 4 
                            + matrix_sum_as_bits[27] * 8+ matrix_sum_as_bits[28] * 16+ matrix_sum_as_bits[29] * 32 
                            + matrix_sum_as_bits[30] * 64+ matrix_sum_as_bits[31] * 128;
        out[8*i+4] <== matrix_sum_as_bits[32] * 1 + matrix_sum_as_bits[33] * 2 + matrix_sum_as_bits[34] * 4 
                            + matrix_sum_as_bits[35] * 8+ matrix_sum_as_bits[36] * 16+ matrix_sum_as_bits[37] * 32 
                            + matrix_sum_as_bits[38] * 64+ matrix_sum_as_bits[39] * 128;
        out[8*i+5] <== matrix_sum_as_bits[40] * 1 + matrix_sum_as_bits[41] * 2 + matrix_sum_as_bits[42] * 4 
                            + matrix_sum_as_bits[43] * 8+ matrix_sum_as_bits[44] * 16+ matrix_sum_as_bits[45] * 32 
                            + matrix_sum_as_bits[46] * 64+ matrix_sum_as_bits[47] * 128;
        out[8*i+6] <== matrix_sum_as_bits[48] * 1 + matrix_sum_as_bits[49] * 2 + matrix_sum_as_bits[50] * 4 
                            + matrix_sum_as_bits[51] * 8+ matrix_sum_as_bits[52] * 16+ matrix_sum_as_bits[53] * 32 
                            + matrix_sum_as_bits[54] * 64+ matrix_sum_as_bits[55] * 128;
        out[8*i+7] <== matrix_sum_as_bits[56] * 1 + matrix_sum_as_bits[57] * 2 + matrix_sum_as_bits[58] * 4 
                            + matrix_sum_as_bits[59] * 8+ matrix_sum_as_bits[60] * 16+ matrix_sum_as_bits[61] * 32 
                            + matrix_sum_as_bits[62] * 64+ matrix_sum_as_bits[63] * 128;
    }

}
