import random

def generate_ALU_tracefile(file_name, num_tests):
    with open(file_name, "w") as file:
        for _ in range(num_tests):
            opcode = format(random.randint(0, 6), '03b')  # Generate a random 3-bit opcode
            A = format(random.randint(0, 65535), '016b')  # Generate random 16-bit binary for A
            B = format(random.randint(0, 65535), '016b')  # Generate random 16-bit binary for B

            # Simulate ALU operation based on opcode
            if opcode == '000':
                result = format((int(A, 2) + int(B, 2)) & 0xFFFF, '016b')
            elif opcode == '001':
                result = format((int(A, 2) - int(B, 2)) & 0xFFFF, '016b')
            elif opcode == '011':
                result = format((int(A, 2) * int(B, 2)) & 0xFFFF, '016b')
            elif opcode == '100':
                result = format((int(A, 2) & int(B, 2)) & 0xFFFF, '016b')
            elif opcode == '101':
                result = format((int(A, 2) | int(B, 2)) & 0xFFFF, '016b')
            elif opcode == '110':
                result = format(((~int(A, 2)) | int(B, 2)) & 0xFFFF, '016b')
            else:
                continue

            file.write(f"{opcode}{A}{B} ")
            z_flag = '1' if result == '0000000000000000' else '0'  # Set z_flag based on result

            file.write(f"{z_flag}{result}\n")

# Generating a trace file named "ALU_tracefile.txt" with 100 test cases
generate_ALU_tracefile("TRACEFILE.txt", 300)

