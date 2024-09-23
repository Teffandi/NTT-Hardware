import numpy as np
import math
from colorama import Fore
from colorama import Style 

def primitive_search(prime, N) :
    # Function to find all possible n-th root of unity
    possible_primitive = []
    for i in range(2,prime):
        if(pow(i,N,prime) == 1):
            possible_primitive.append(i)

    return possible_primitive

def primitive_verification(prime,N):
    # Function to verify possible n-th root of unity
    possible_primitive = primitive_search(prime,N)
    verified_primitive = []

    for scan in possible_primitive:
        existance = False
        for root_iterate in range(1,N):
            temp_pow = pow(scan,root_iterate,prime)
            existance |= (temp_pow == 1)
            if existance:
                break
    
        if not existance:
            verified_primitive.append(scan)

    return verified_primitive

def primitive_search_negative(prime,selected_primitive_positive) :
    # Function to find possible 2n-th root of unity
    possible_primitive_negative = []

    for i in range(2,prime):
        if(pow(i,2,prime)==selected_primitive_positive):
            possible_primitive_negative.append(i)

    return possible_primitive_negative

def bare_matrix(N, prime):
    # Function to generate twiddle factor matrix
    matrix = [[0]*N for i in range(N)]
    inv_matrix = [[0]*N for i in range(N)]
    power = [[0]*N for i in range(N)]
    inv_power = [[0]*N for i in range(N)]
    inv_N = pow(N,-1,prime)

    matrix = [[0]*N for i in range(N)]
    inv_matrix = [[0]*N for i in range(N)]
    for row in range(0,N):
        for col in range(0,N):
            # Periodicity
            power[row][col] = ( (2*(row*col)+col) % (2*N) )
            inv_power[col][row] = -1*( (2*(row*col)+col) % (2*N) )

            if (power[row][col]//N) % 2 == 1: # Symmetricity
                power[row][col] = power[row][col] % N
                inv_power[col][row] = ( inv_power[col][row] % N ) - N
                matrix[row][col] = -1
                inv_matrix[col][row] = -1
            else:
                matrix[row][col] = 1
                inv_matrix[col][row] = 1

    return matrix, power, inv_matrix, inv_power

def single_radix(N,prime, radix, root_2nth, print_stat):

    if not math.log(N,2).is_integer() or N > 131072:
        print(f'{Fore.RED}[ERROR] {Style.RESET_ALL}N is not a power of 2.')
        exit()

    if N > 131072:
        print(f'{Fore.RED}[ERROR] {Style.RESET_ALL}N maxed out.')
        exit()

    matrix, power, inv_matrix, inv_power = bare_matrix(N, prime)
    stage = int(math.log(N,radix))
    temp_pow = [[[0 for i in range(radix)] for j in range(stage)] for k in range(N)]
    temp_mat = [[[0 for i in range(radix)] for j in range(stage)] for k in range(N)]

    temp_inv_pow = [[[0 for i in range(radix)] for j in range(stage)] for k in range(N)]
    temp_inv_mat = [[[0 for i in range(radix)] for j in range(stage)] for k in range(N)]

    for i in range(N):
        for j in range(stage):
            rate = N // (radix**(j+1))
            for k in range(radix):
                temp_pow[i][j][k] = power[i][k*rate]
                temp_mat[i][j][k] = matrix[i][k*rate] * pow(root_2nth,temp_pow[i][j][k],prime)

                # temp_inv_pow[i][j][k] = inv_power[i][k*rate] - 

        for j in range(radix):
            for k in range(stage):
                temp_inv_pow[i][k][j] = inv_power[i][k*rate]
                temp_inv_mat[i][k][j] = inv_matrix[i*rate][k] * pow(root_2nth,temp_inv_pow[i][j][k],prime)

    if print_stat == 1:
        print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Printing Twiddle Factor Matrix NTT and INTT using Single radix-{radix}:')
        print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Twiddle Factor Matrix NTT:')
        for i in range(N):
            print(temp_mat[i])

        print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Twiddle Factor Matrix INTT:')
        for i in range(N):
            print(temp_inv_pow[i])

        print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}===Printing Finished===')

    return temp_mat, temp_inv_mat


def combine_radix(N, prime,root_2nth, print_stat):

    if not math.log(N,2).is_integer() or N > 131072:
        print(f'{Fore.RED}[ERROR] {Style.RESET_ALL}N is not a power of 2.')
        exit()

    if N > 131072:
        print(f'{Fore.RED}[ERROR] {Style.RESET_ALL}N maxed out.')
        exit()
    
    matrix, power, inv_matrix, inv_power = bare_matrix(N, prime)
    exp = int(math.log(N,2))

    max_r8 = 0; max_r4 = 10; max_r2 = 0
    use_r8 = 0; use_r4 = 0; use_r2 = 0

    use_r8 = min(max_r8, exp//3); exp -= use_r8*3
    use_r4 = min(max_r4, exp//2); exp -= use_r4*2
    use_r2 = min(max_r2, exp//1); exp -= use_r2*1

    stage = use_r8 + use_r4 + use_r2
    temp_pow = [[[] for j in range(stage)] for k in range(N)]; temp_mat = [[[] for j in range(stage)] for k in range(N)];

    for i in range(N):
        if use_r8 > 0:
            for j in range(use_r8):
                rate = N // (8**(j+1))
                for k in range(8):
                    val_pow = power[i][k*rate]
                    temp_pow[i][j].append(val_pow)
                    temp_mat[i][j].append(matrix[i][k*rate] * pow(root_2nth,val_pow,prime))
            new_N = N // (8*use_r8)
            new_stage = use_r8
        else:
            new_N = N
            new_stage = 0

        if use_r4 > 0:
            for j in range(use_r4):
                rate = new_N // (4**(j+1))
                for k in range(4):
                    val_pow = power[i][k*rate]
                    temp_pow[i][j].append(val_pow)
                    temp_mat[i][j].append(matrix[i][k*rate] * pow(root_2nth,val_pow,prime))
            new_N = new_N // (4*use_r4)
            new_stage += use_r4

        if use_r2 > 0:
            for j in range(use_r2):
                rate = new_N // (2**(j+1))
                for k in range(2):
                    val_pow = power[i][k*rate]
                    temp_pow[i][j].append(val_pow)
                    temp_mat[i][j].append(matrix[i][k*rate] * pow(root_2nth,val_pow,prime))
                

    if print_stat == 1:
        print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Printing Value and Power Matrix using Radix Combination:')
        # print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Value Matrix:')
        # for i in range(N):
        #     print(temp_mat[i])

        print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Power Matrix:')
        for i in range(N):
            print(temp_pow[i])

        print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}===Printing Finished===')

    return temp_mat 

N = 16
moduli_prime = 7681

# w = primitive_verification(moduli_prime,N)
# print(w)
# print(primitive_search_negative(moduli_prime,w[0]))

# for i in range(1,4):
#     N = 2**i
#     print(f'=========N = {N}')
#     print(primitive_search(moduli_prime, N))
#     print(primitive_verification(moduli_prime,N))
        

# for i in range(1, 5):
#     N = 2**i

# print(f'{Fore.CYAN}[INFO] {Style.RESET_ALL}All possible value of primitive n-th root for {Fore.GREEN}n={N} {Style.RESET_ALL}and {Fore.GREEN}moduli prime={moduli_prime}:{Style.RESET_ALL}',end='\t')
# print(primitive_search(moduli_prime,N))

# for i in range(1,18):
#     N = 2**i
#     print(f'{Fore.YELLOW}[INFO] {Style.RESET_ALL}All verified value of primitive n-th root for {Fore.GREEN}n={N} {Style.RESET_ALL}and {Fore.GREEN}moduli prime={moduli_prime}:{Style.RESET_ALL}',end='\t')
#     temp = primitive_verification(moduli_prime,N)
#     print(temp)

# for elem in temp:
#     print(f'{Fore.CYAN}[INFO] {Style.RESET_ALL}All verified value of primitive 2n-th root for n-th root = {elem}:',end='\t')
#     print(primitive_search_negative(moduli_prime,elem))


# twid_gen(10,moduli_prime)
np.set_printoptions(threshold=np.inf)
matrix, power, inv_matrix, inv_power = bare_matrix(N, moduli_prime)
print(f'{Fore.CYAN}[INFO] {Style.RESET_ALL}Original Value:')
print(np.matrix(matrix))
print(f'{Fore.CYAN}[INFO] {Style.RESET_ALL}Original Power:')
print(np.matrix(power))

# single_radix(N,moduli_prime,2,1925,1)
combine_radix(N,moduli_prime,1925,1)