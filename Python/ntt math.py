
import Python.matrix_generator as matrix_generator 

n = int(input("Enter N-point: "))
prime = int(input("enter prime number used :"))  # input prime number

temp_val = 0
temp_2 = 0

a_ntt = [0 for i in range(n)]
a_intt = [0 for i in range(n)]

matrix = matrix_generator.generate_matrix(n, prime)
matrix_generator.print_matrix(n)

a = [5, 6, 7, 8]  # Example input 

def ntt(n, a, temp_2, temp_val):
    for row in range(0, n):
        for col in range(0, n):
            temp_val = int(matrix[row][col]) * a[col] % prime
            temp_2 = (temp_2 + temp_val) % prime  
        a_ntt[row] = temp_2
        temp_2 = 0
    return a_ntt

print("NTT: ")
for i in range(0, n):
    print(a_ntt[i])
