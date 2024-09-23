import math

def reverse(n,width): #reversing bits for matrix index
    new_n = 0
    for i in range(width):
        new_n <<= 1
        if n & 1:
            new_n ^= 1
        n >>= 1
    return new_n

def bit_reverse(buffer,N): #reversing the buffer 
    width = int(math.log2(N))
    buffer_temp = []
    for scan in range(0,len(buffer)):
        buffer_temp.append(buffer[reverse(scan,width)])
    return buffer_temp
    

def Radix_2_NTT(A, N, q, psi,stage):
    T = [0]*2
    J = 2**stage
    w = pow(psi, N // (2 * J), q)  # Compute w^(N / (2 * J)) mod q
    for k in range(N //(2 * J)):
        for j in range(0,J):
            
            w_1j1 = pow(w,2*j+1,q)
            idx = 2*k*J + j
            idx_J = idx + J

            T[0] = (A[idx] + A[idx_J]*w_1j1)%q
            T[1] = (A[idx] - A[idx_J]*w_1j1)%q

            A[idx] = T[0]
            A[idx_J] = T[1]
                
    return A


def Radix_2_INTT(A,N,q,psi,stage):
    T = [0]*2
    J = 2**stage
    w = pow(psi, -1*N//(2*J),q)
    for k in range(0, int(N/(2*J))):
        for j in range(J):
            idx = 2*k*J + j
            idx_J = idx + J

            w_1j1 = pow(w, (2*j+1), q)

            T[0] = ((A[idx] + A[idx_J])) % q
            T[1] = ((A[idx] - A[idx_J]) * w_1j1) % q

            A[idx] = T[0]
            A[idx_J]= T[1]


    return A





