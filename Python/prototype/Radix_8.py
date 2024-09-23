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
    

def Radix_8_NTT(A, N, q, psi, w_8th,stage):
    B = [0]*8 #8 point bit reversed from A
    T = [0]*8
    R = [0]*8    
    J = 8**stage
    w = pow(psi, N // (8*J), q)
    for k in range(N //(8*J)):
        for j in range(0,J):
                

            w_1j1 = pow(w, 2*j+1,q)
            w_2j1 = pow(w, 2*(2*j+1), q)  # Compute w^(2*(2j+1)) mod q
            w_3j1 = pow(w, 3*(2*j+1), q)  # Compute w^(3*(2j+1)) mod q
            w_4j1 = pow(w, 4*(2*j+1), q)  # Compute w^(4*(2j+1)) mod q
            w_5j1 = pow(w, 5*(2*j+1), q)  # Compute w^(5*(2j+1)) mod q
            w_6j1 = pow(w, 6*(2*j+1), q)  # Compute w^(6*(2j+1)) mod q
            w_7j1 = pow(w, 7*(2*j+1), q)  # Compute w^(7*(2j+1)) mod q

            
            idx = 8*k*J + j #0
            idx_J = idx + J #1
            idx_2J = idx + 2*J #2
            idx_3J = idx + 3*J #3
            idx_4J = idx + 4*J #4
            idx_5J = idx + 5*J #5
            idx_6J = idx + 6*J #6
            idx_7J = idx + 7*J #7
            
            B[0] = A[idx]
            B[1] = A[idx_J]
            B[2] = A[idx_2J]
            B[3] = A[idx_3J]
            B[4] = A[idx_4J]
            B[5] = A[idx_5J]
            B[6] = A[idx_6J]
            B[7] = A[idx_7J]

            B = bit_reverse(B,8)

            A[idx] = B[0]
            A[idx_J] = B[1]
            A[idx_2J] = B[2]
            A[idx_3J] = B[3]
            A[idx_4J] = B[4]
            A[idx_5J] = B[5]
            A[idx_6J] = B[6]
            A[idx_7J] = B[7]
            
            #first stage

            T[0] =  (A[idx] + A[idx_4J]*w_4j1)%q
            T[1] =  (A[idx] - A[idx_4J]*w_4j1)%q
                    
            T[2] = (A[idx_2J]*w_2j1 + A[idx_6J]*w_6j1)%q
            T[3] = (A[idx_2J]*w_2j1 - A[idx_6J]*w_6j1)%q

            T[4] = (A[idx_J]*w_1j1 + A[idx_5J]*w_5j1)%q
            T[5] = (A[idx_J]*w_1j1 - A[idx_5J]*w_5j1)%q

            T[6] = (A[idx_3J]*w_3j1 + A[idx_7J]*w_7j1)%q
            T[7] = (A[idx_3J]*w_3j1 - A[idx_7J]*w_7j1)%q

            #second stage

            R[0] = (T[0] + T[2])%q
            R[2] = (T[0] - T[2])%q

            R[1] = (T[1] + T[3]*pow(w_8th,2,q))%q
            R[3] = (T[1] - T[3]*pow(w_8th,2,q))%q

            R[4] = (T[4] + T[6])%q
            R[6] = (T[4] - T[6])%q

            R[5] = (T[5] + T[7]*pow(w_8th,2,q))%q
            R[7] = (T[5] - T[7]*pow(w_8th,2,q))%q

            #third stage
            A[idx] = (R[0] + R[4])%q
            A[idx_4J] = (R[0] - R[4])%q

            A[idx_J] = (R[1] + R[5]*pow(w_8th,1,q))%q
            A[idx_5J] = (R[1] - R[5]*pow(w_8th,1,q))%q

            A[idx_2J] = (R[2] + R[6]*pow(w_8th,2,q))%q
            A[idx_6J] = (R[2] - R[6]*pow(w_8th,2,q))%q

            A[idx_3J] = (R[3] + R[7]*pow(w_8th,3,q))%q
            A[idx_7J] = (R[3] - R[7]*pow(w_8th,3,q))%q
    

    return A


def Radix_8_INTT(A,N,q,psi,w_8th,n_inv,stage):
    B = [0]*8 #8 point bit reversed from A
    T = [0]*8
    R = [0]*8    
    J = 8**p
    w = pow(psi, -1*N // (8*J), q)
    for k in range(0,N //(8*J)):
        for j in range(0,J):

            
            w_1j1 = pow(w, 2*j+1,q)
            w_2j1 = pow(w, 2*(2*j+1), q)  # Compute w^(2*(2j+1)) mod q
            w_3j1 = pow(w, 3*(2*j+1), q)  # Compute w^(3*(2j+1)) mod q
            w_4j1 = pow(w, 4*(2*j+1), q)  # Compute w^(4*(2j+1)) mod q
            w_5j1 = pow(w, 5*(2*j+1), q)  # Compute w^(5*(2j+1)) mod q
            w_6j1 = pow(w, 6*(2*j+1), q)  # Compute w^(6*(2j+1)) mod q
            w_7j1 = pow(w, 7*(2*j+1), q)  # Compute w^(7*(2j+1)) mod q

            idx = 8*k*J + j #0
            idx_J = idx + J #1
            idx_2J = idx + 2*J #2
            idx_3J = idx + 3*J #3
            idx_4J = idx + 4*J #4
            idx_5J = idx + 5*J #5
            idx_6J = idx + 6*J #6
            idx_7J = idx + 7*J #7
            
            
            #first stage

            T[0] =  ((A[idx] + A[idx_4J]))%q
            T[1] =  ((A[idx] - A[idx_4J]))%q
                    
            T[2] = (A[idx_2J] + A[idx_6J])%q
            T[3] = ((A[idx_2J] - A[idx_6J])*pow(w_8th,2,q))%q

            T[4] = (A[idx_J] + A[idx_5J])%q
            T[5] = ((A[idx_J] - A[idx_5J])*pow(w_8th,1,q))%q

            T[6] = (A[idx_3J] + A[idx_7J])%q
            T[7] = ((A[idx_3J] - A[idx_7J])*pow(w_8th,3,q))%q

            #second stage

            R[0] = (T[0] + T[2])%q
            R[2] = ((T[0] - T[2])*pow(w_8th,0,q))%q

            R[1] = (T[1] + T[3])%q
            R[3] = ((T[1] - T[3])*pow(w_8th,0,q))%q

            R[4] = (T[4] + T[6])%q
            R[6] = ((T[4] - T[6])*pow(w_8th,2,q))%q

            R[5] = (T[5] + T[7])%q
            R[7] = ((T[5] - T[7])*pow(w_8th,2,q))%q


            #third stage
            A[idx] = ((R[0] + R[4]))%q
            A[idx_4J] = ((R[0] - R[4])*w_4j1)%q

            A[idx_J] = ((R[1] + R[5])*w_1j1)%q
            A[idx_5J] =((R[1] - R[5])*w_5j1)%q

            A[idx_2J] = ((R[2] + R[6])*w_2j1)%q
            A[idx_6J] = ((R[2] - R[6])*w_6j1)%q

            A[idx_3J] = ((R[3] + R[7])*w_3j1)%q
            A[idx_7J] = ((R[3] - R[7])*w_7j1)%q


            
            B[0] = A[idx]
            B[1] = A[idx_J]
            B[2] = A[idx_2J]
            B[3] = A[idx_3J]
            B[4] = A[idx_4J]
            B[5] = A[idx_5J]
            B[6] = A[idx_6J]
            B[7] = A[idx_7J]

            B = bit_reverse(B,8)

            A[idx] = B[0]
            A[idx_J] = B[1]
            A[idx_2J] = B[2]
            A[idx_3J] = B[3]
            A[idx_4J] = B[4]
            A[idx_5J] = B[5]
            A[idx_6J] = B[6]
            A[idx_7J] = B[7]



    return A

