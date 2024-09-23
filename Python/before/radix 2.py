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
    print(possible_primitive)
    primitive_verification(possible_primitive, prime, N)
    print(verified_primitive)
    selected_primitive_positive = int(input("enter primitive number selected :"))
    primitive_search_negative(prime,selected_primitive_positive)
    print(possible_primitive_negative)
    selected_primitive_negative = int(input("enter negative primitive number selected :"))
    return selected_primitive_negative

# CT algorithm for radix 2
N = int(input("Select N: "))
prime = int(input("Enter prime number used: "))  # input prime number
a = [1, 2, 3, 4]  # Example input 

# matrix = matrix_generator.generate_matrix(N, prime)
# matrix_generator.print_matrix(n)
n = int(N / 2 - 1)
psi = psi(N, prime)

# Initialize arrays 
a_even = [0 for i in range(n+1)]
a_odd = [0 for i in range(n+1)]
a_temp = [0 for i in range(N)]
a_ntt = [0 for i in range(N)]

# Separate the input into even and odd parts
for j in range(len(a)):
    for i in range(n+1):
        a_even[i] = (psi**((2*i)*(2*j+1)))*a[2*i] % prime
        a_odd[i] = (psi**((2*i+1)*(2*j+1)))*a[2*i+1] % prime
        a_temp[j] = a_even[i] + a_odd[i]
        a_ntt[j] = (a_ntt[j] + a_temp[j]) % prime
    

# Output the result
print("a_ntt:", a_ntt)
