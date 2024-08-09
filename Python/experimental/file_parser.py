def parse_file_to_buffer(filename):
    buffer = []
    try:
        with open(filename, 'r') as file:
            # Read each line from the file and add it to the buffer array
            buffer = file.readlines()
    except FileNotFoundError:
        print(f"Error: The file '{filename}' was not found.")
    except IOError:
        print(f"Error: An IO error occurred while accessing the file '{filename}'.")
    
    # Strip newline characters from each line
    buffer = [int(line.strip()) for line in buffer]
    return buffer

