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
    



def Radix_4_NTT(A, N, q, psi, w_4th,stage):
    T = [0]*4    
    J = int(4**stage)
    w = pow(psi, N // (4 * J), q)  # Compute w^(N / (4 * J)) mod q
    for k in range(N //(4 * J)):
        for j in range(0,J):
                
            w_1j1 = pow(w, (2*j+1), q)  # Compute w^((2j+1)) mod q
            w_2j1 = pow(w, 2*(2*j+1), q)  # Compute w^(2*(2j+1)) mod q
            w_3j1 = pow(w, 3*(2*j+1), q)  # Compute w^(3*(2j+1)) mod q
                
            idx = 4*k*J + j
            idx_J = idx + J
            idx_2J = idx + 2*J
            idx_3J = idx + 3*J

            # print(f'Radix 4--Stage {stage}  Idx: {idx,idx_J,idx_2J,idx_3J} | power: {(2*j+1),2*(2*j+1),3*(2*j+1)}')

            temp_0 = A[idx_J]
            temp_1 = A[idx_2J]
            A[idx_J] = temp_1
            A[idx_2J] = temp_0
 
                
            T[0] = (A[idx] + A[idx_2J] * w_2j1)%q
            T[1] = (A[idx] - A[idx_2J] * w_2j1)%q
            T[2] = (A[idx_J] * w_1j1 + A[idx_3J] * w_3j1)%q
            T[3] = (A[idx_J] * w_1j1 - A[idx_3J] * w_3j1)%q

            A[idx] = (T[0] + T[2])%q
            A[idx_J] = (T[1] + T[3] * w_4th)%q
            A[idx_2J] = (T[0] - T[2])%q
            A[idx_3J] = (T[1] - T[3] * w_4th)%q

    return A

def Radix_4_INTT(A,N,q,psi,w_4th,stage): # Radix 4 for INTT (w and psi is inverse)
    T = [0]*4           
    J = int(4**stage)
    w = pow(psi, -1*N // (4 * J), q)  # Compute w^(N / (4 * J)) mod q
    for k in range(0,int((N/(4*J)))):
        for j in range(0,J):

            idx = 4*k*J + j
            idx_J = idx + J
            idx_2J = idx + 2*J
            idx_3J = idx + 3*J



            w_1j1 = pow(w, 2*j+1, q)
            w_2j1 = pow(w, 2*(2*j+1), q)
            w_3j1 = pow(w, 3*(2*j+1), q)

            T[0] = ((( A[idx] + A[idx_2J] ))%q)
            T[1] = ((( A[idx] - A[idx_2J] ))%q)
            T[2] = ((( A[idx_J] + A[idx_3J]))%q)
            T[3] = (((( A[idx_J]- A[idx_3J])*w_4th))%q)
            A[idx] = ((((T[0]+T[2]))%q))
            A[idx_J] = ((((T[1]+T[3])*w_1j1))%q)
            A[idx_2J] =((((T[0]-T[2])*w_2j1))%q)
            A[idx_3J] = ((((T[1]-T[3])*w_3j1))%q)

            temp_0 = A[idx_J]
            temp_1 = A[idx_2J]
            A[idx_J] = temp_1
            A[idx_2J] = temp_0
  

    
    return A