import os
from colorama import Fore
from colorama import Style

def modulo_65537(num):
    if num < 0:
        temp_in = -num
        sel_1 = 1
    else:
        temp_in = num
        sel_1 = 0

    msb = (temp_in >> 16) & 0xffff
    lsb = temp_in & 0xffff

    temp_sub = lsb - msb

    sel_2 = ((temp_sub >> 16) & 0b1) & (temp_sub & 0b0)
    
    sel_0 = 0
    for i in range(0,32):
        sel_0 |= ((temp_sub >> i) & 0b1)
    # print(f'{Fore.GREEN}[INFO] Temporary result: {temp}{Style.RESET_ALL}')
    # print(f'{temp_sub}\t{(temp_sub >> 16)}')
    # print(f'{Fore.CYAN}[INFO] sel_0: {sel_0} \tsel_1: {sel_1} \tsel_2: {sel_2}{Style.RESET_ALL}')

    if sel_0:
        temp_neg = 65537 - temp_sub
    else:
        temp_neg = 0

    if sel_2:
        if sel_1:
            result = 1
        else:
            result = 0x10000
    else:
        if sel_1:
            result = temp_neg
        else:
            result = temp_sub
    
    return result

def testing_printing_value():
    print(f'{Fore.GREEN}[INFO] Testing value < 65537{Style.RESET_ALL}')
    flag_match = 1
    i = 7
    while i < 65537:
        function_result = modulo_65537(i)
        operator_result = i%65537

        flag_match &= function_result == operator_result

        modulo_65537(i)
        print(f'{i} mod 65537  \tFunction result: {function_result} \tActual value: {operator_result}')
        if function_result != operator_result:
            print(f'{Fore.RED}[ERROR] Result does not match {Style.RESET_ALL}')

        i *= 3
    if flag_match:
        print(f'{Fore.GREEN}[INFO] Results match uniquely for value < 65537{Style.RESET_ALL}\n')
    else:
        print(f'{Fore.RED}[ERROR] Result does not match uniquely for value < 65537{Style.RESET_ALL}\n')


    print(f'{Fore.GREEN}[INFO] Testing value > 65537{Style.RESET_ALL}')
    flag_match = 1
    i = 65546
    while i < 65636:
        function_result = modulo_65537(i)
        operator_result = i%65537

        flag_match &= function_result == operator_result

        print(f'{i} mod 65537  \tFunction result: {function_result} \tActual value: {operator_result}')
        if function_result != operator_result:
            print(f'{Fore.RED}[ERROR] Result does not match {Style.RESET_ALL}')

        i += 4
    if flag_match:
        print(f'{Fore.GREEN}[INFO] Results match uniquely for value < 65537{Style.RESET_ALL}\n')
    else:
        print(f'{Fore.RED}[ERROR] Result does not match uniquely for value < 65537{Style.RESET_ALL}\n')


    print(f'{Fore.GREEN}[INFO] Testing negative values{Style.RESET_ALL}')
    flag_match = 1
    i = 0
    while i > -10:
        function_result = modulo_65537(i)
        operator_result = i%65537

        flag_match &= function_result == operator_result

        print(f'{i} mod 65537  \tFunction result: {function_result} \tActual value: {operator_result}')
        if function_result != operator_result:
            print(f'{Fore.RED}[ERROR] Result does not match {Style.RESET_ALL}')

        i -= 1
    i = -65537
    while i > -65547:
        function_result = modulo_65537(i)
        operator_result = i%65537

        flag_match &= function_result == operator_result

        print(f'{i} mod 65537  \tFunction result: {function_result} \tActual value: {operator_result}')
        if function_result != operator_result:
            print(f'{Fore.RED}[ERROR] Result does not match {Style.RESET_ALL}')

        i -= 1
    if flag_match:
        print(f'{Fore.GREEN}[INFO] Results match uniquely for negative values{Style.RESET_ALL}\n')
    else:
        print(f'{Fore.RED}[ERROR] Result does not match uniquely for negative values{Style.RESET_ALL}\n')

def testing_all_values():
    print(f'{Fore.GREEN}[INFO] Opening File for Test Cases Input{Style.RESET_ALL}')
    file_name_in = os.getcwd().replace('\\','\\\\') + '\\\\testbench\\\\' + 'all_32bit_values_input' + '.txt'
    f_input = open(file_name_in,'w')

    print(f'{Fore.GREEN}[INFO] Opening File for Test Cases Result{Style.RESET_ALL}')
    file_name_out = os.getcwd().replace('\\','\\\\') + '\\\\testbench\\\\' + 'all_32bit_values_output' + '.txt'
    f_out = open(file_name_out,'w')

    content_in = ''
    content_out = ''
    bound = 0x10000 * 3
    for i in range (-bound,bound,301):
        content_in += str(i) + '\n' 
        content_out += str(i%65537) + '\n'
        if i % 100 <= 5:
            print(f'{Fore.GREEN}[INFO] {i} \tfrom {bound} \t({round((i+bound)/(2*bound) * 100,2)} \t%) \tLines have been generated {Style.RESET_ALL}')

    print(f'{Fore.GREEN}[INFO] Writing Test Cases Input and Result{Style.RESET_ALL}')
    f_input.write(content_in)
    f_out.write(content_out)

    print(f'{Fore.GREEN}[INFO] Writing finished. Closing File{Style.RESET_ALL}')
    f_input.close()
    f_out.close()

    
try:
    testing_printing_value()
    # testing_all_values()

    

    # min_val = -pow(2,17)
    # max_val = -min_val - 1
    # print(f'{Fore.GREEN}[INFO] Testing values from {min_val} to {max_val}{Style.RESET_ALL}')
    # flag_match = 1
    # i = min_val
    # while i <= max_val:
    #     function_result = modulo_65537(i)
    #     operator_result = i%65537

    #     flag_match &= function_result == operator_result

    #     if function_result != operator_result:
    #         print(f'{i} mod 65537  \tFunction result: {function_result} \tActual value: {operator_result}')
    #         print(f'{Fore.RED}[ERROR] Above Result does not match {Style.RESET_ALL}')

    #     i += 1
    # if flag_match:
    #     print(f'{Fore.GREEN}[INFO] Results match uniquely for negative values{Style.RESET_ALL}\n')
    # else:
    #     print(f'{Fore.RED}[ERROR] Result does not match uniquely for negative values{Style.RESET_ALL}\n')
except KeyboardInterrupt:
    print(f'{Fore.YELLOW}[WARNING] System interrupted!!{Style.RESET_ALL}')