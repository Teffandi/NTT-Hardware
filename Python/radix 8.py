import numpy as np

possible_primitive = []  
verified_primitive = []
possible_primitive_negative = []

def primitive_search(prime, N):
    for i in range(2, prime):
        if pow(i, N) % prime == 1:
            possible_primitive.append(i)

def primitive_verification(possible_primitive, prime, N):
    for scan in range(0, len(possible_primitive)):
        temp = int(possible_primitive[scan])
        for root_iterate in range(1, N):
            if pow(temp, root_iterate) % prime == 1:
                break
        else:
            verified_primitive.append(temp)

def primitive_search_negative(prime, selected_primitive_positive):
    for i in range(2, prime):
        if pow(i, 2) % prime == selected_primitive_positive:
            possible_primitive_negative.append(i)

def psi(N, prime):
    primitive_search(prime, N)
    print("Possible primitive roots:", possible_primitive)
    primitive_verification(possible_primitive, prime, N)
    print("Verified primitive roots:", verified_primitive)
    selected_primitive_positive = int(input("Enter primitive number selected: "))
    primitive_search_negative(prime, selected_primitive_positive)
    print("Possible negative primitive roots:", possible_primitive_negative)
    selected_primitive_negative = int(input("Enter negative primitive number selected: "))
    return selected_primitive_negative


def radix8_fft(a, N, prime, psi):
    n = int(N / 8) 

    a_ntt = [0 for i in range(N)]

    for j in range(N):
        sum0 = sum1 = sum2 = sum3 = sum4 = sum5 = sum6 = sum7 = 0
        for i in range(n):
            power = 8*i*(2*j+1)
            sum0 += psi**power*a[8*i]
            sum1 += psi**(4*(2*j+1)) * psi**(power)*a[8*i+4] 
            sum2 += psi**(2*(2*j+1)) * psi**(power)*a[8*i+2] 
            sum3 += psi**(6*(2*j+1)) * psi**(power)*a[8*i+6] 
            sum4 += psi**(2*j+1) * psi**(power)*a[8*i+1]
            sum5 += psi**(5*(2*j+1)) * psi**(power)*a[8*i+5] 
            sum6 += psi**(3*(2*j+1)) * psi**(power)*a[8*i+3] 
            sum7 += psi**(7*(2*j+1))  * psi**(power)*a[8*i+7] 
        a_ntt[j] = (sum0+sum1+sum2+sum3+sum4+sum5+sum6+sum7) % prime
        
    return a_ntt

N = int(input("Select N: "))
prime = int(input("Enter prime number used: "))  # input prime number
a = [int(x) for x in input("Enter the list of numbers (space-separated): ").split()]  # Example input
psi = psi(N, prime)
result = radix8_fft(a, N, prime, psi)
print("a_ntt:", result)

   