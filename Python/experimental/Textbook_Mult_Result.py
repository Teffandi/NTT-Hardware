import os
from Number_Generator import generate_random_numbers
from Textbook_Mult import *

N = int(input("Enter input (power of 2) : "))


generate_random_numbers(2**N,"input_1.txt")
generate_random_numbers(2**N,"input_2.txt")
Textbook_mult_flow("input_1.txt","input_2.txt","textbook_mult_out.txt")
