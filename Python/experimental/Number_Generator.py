import random
import os

def generate_random_numbers(N, filename):
    # Generate N random numbers
    random_numbers = [random.randint(0,999) for _ in range(N)]
    
    # Write the numbers to a text file
    with open(os.path.join("./temp",filename), 'w') as file:
        for number in random_numbers:
            file.write(f"{number}\n")

    print(f"Generated {N} random numbers and saved to {filename}")
