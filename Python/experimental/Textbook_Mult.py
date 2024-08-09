import os

def read_coefficients(filename):
    with open(os.path.join("./temp",filename), 'r') as file:
        coefficients = file.read().strip().split()
    return [int(coef) for coef in coefficients]

def write_coefficients(filename, coefficients):
    with open(os.path.join("./temp",filename), 'w') as file:
        file.write('\n'.join(map(str, coefficients)))

def multiply_polynomials(coeffs1, coeffs2):
    # Lengths of coefficient lists
    len1 = len(coeffs1)
    len2 = len(coeffs2)
    
    # Initialize result polynomial coefficients
    result = [0] * (len1 + len2 - 1)
    
    # Multiply the polynomials
    for i in range(len1):
        for j in range(len2):
            result[i + j] += coeffs1[i] * coeffs2[j]
    
    return result

def Textbook_mult_flow(file1,file2,output_file):

    # Read coefficients from files
    coeffs1 = read_coefficients(file1)
    coeffs2 = read_coefficients(file2)
    # Multiply the polynomials
    result_coeffs = multiply_polynomials(coeffs1, coeffs2)
    # Write the result to a file
    write_coefficients(output_file, result_coeffs)

    print(f"Multiplication result saved to {output_file}")
