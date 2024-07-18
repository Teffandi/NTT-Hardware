# Number Theoritic Transform

## Goals
this repo aim to implement NTT algorithm into radix 2,4 and 8 core. The core will be used to proccess N-th point input, where it is expected to support up to 2^18 point. 


## Running Testbench 🚀
Run testbench from this project root directory. Testbench is run using iverilog. The files used in the testbench are inside the txt. To run the testbench for Windows, use the following command:

```
iverilog.exe -c <txt_file.txt>
```

Then to run the program, do the following:

```
vvp a.out
```
