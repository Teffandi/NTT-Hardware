


def bit_reverse(value, bit_size):
    reversed_value = 0
    for i in range(bit_size):
        if (value >> i) & 1:
            reversed_value |= 1 << (bit_size - 1 - i)
    return reversed_value

def ntt(a, n, q, w):
    # Bit-reversal permutation
    bit_size = n.bit_length() - 1
    a = [a[bit_reverse(i, bit_size)] for i in range(n)]
    
    # NTT transformation
    length = 2
    while length <= n:
        half_length = length // 2
        root = pow(w, n // length, q)
        
        for i in range(0, n, length):
            current_root = 1
            for j in range(half_length):
                u = a[i + j]
                v = a[i + j + half_length] * current_root % q
                a[i + j] = (u + v) % q
                a[i + j + half_length] = (u - v) % q
                current_root = current_root * root % q
                
        length *= 2
    
    return a

def inverse_ntt(a, n, q, w):
    inv_n = pow(n, q - 2, q)
    w_inv = pow(w, q - 2, q)
    a = ntt(a, n, q, w_inv)
    return [(x * inv_n) % q for x in a]

# Example usage
q = 7681  # Example prime p = k * 2^n + 1
n = 4     # Length of the input, must be a power of 2

# Directly specify the primitive n-th root of unity
w = 3383  # Example primitive n-th root of unity modulo p

a = [1, 2, 3, 4]  # Example input array
ntt_result = ntt(a.copy(), n, q, w)
inverse_ntt_result = inverse_ntt(ntt_result.copy(), n, q, w)

print("NTT result:", ntt_result)
print("Inverse NTT result:", inverse_ntt_result)
