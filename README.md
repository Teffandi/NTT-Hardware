# Number Theoritic Transform
this repo aim to implement NTT algorithm into radix 2,4 and 16 core


## Running Testbench
Run testbench from this project root directory. Testbench is run using iverilog. The files used in the testbench are inside the txt. To run the testbench for Windows, use the following command:

```
iverilog.exe -c <txt_file.txt>
```

Then to run the program, do the following:

```
vvp a.out
```