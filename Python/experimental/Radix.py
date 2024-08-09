import math

def Core_Radix_2(data_in,twiddle,mode): #behaviour of RTL model of R2

    if (mode=="NTT"):
        data_out[0]= data_in[0]+data_in[1]*twiddle
        data_out[1]= data_in[0]-data_in[1]*twiddle
        return data_out
    else :
        data_out[0]= (data_in[0]+data_in[1])*twiddle
        data_out[1]= (data_in[0]-data_in[1])*twiddle
        return data_out



def Core_Radix_4(data_in,twiddle,mode,w): #behaviour of RTL model of R4

    #calculating internal weights
    
    if (mode=="NTT"):
        data_in[0] = data_in[0]*twiddle[0]
        data_in[1] = data_in[1]*twiddle[1]
        data_in[2] = data_in[2]*twiddle[2]
        data_in[3] = data_in[3]*twiddle[3]

        data_out[0] = data_in[0] + data_in[1]*w[2] + data_in[2]*w[3] + data_in[3]*w[4];
        data_out[1] = data_in[0] - data_in[1]*w[3] - data_in[2]*w[2] + data_in[3]*w[1];
        data_out[2] = data_in[0] - data_in[1]*w[1] + data_in[2]*w[2] - data_in[3]*w[3];
        data_out[3] = data_in[0] + data_in[1]*w[3] - data_in[2]*w[2] - data_in[3]*w[3];

        return data_out
    
    else :
        
        data_out[0] = data_in[0] + data_in[1]*w[2] + data_in[2]*w[3] + data_in[3]*w[4];
        data_out[1] = data_in[0] - data_in[1]*w[3] - data_in[2]*w[2] + data_in[3]*w[1];
        data_out[2] = data_in[0] - data_in[1]*w[1] + data_in[2]*w[2] - data_in[3]*w[3];
        data_out[3] = data_in[0] + data_in[1]*w[3] - data_in[2]*w[2] - data_in[3]*w[3];

        data_out[0] = data_out[0]*twiddle[0]
        data_out[1] = data_out[1]*twiddle[1]
        data_out[2] = data_out[2]*twiddle[2]
        data_out[3] = data_out[3]*twiddle[3]

        return data_out

def Core_Radix_8(data_in,twiddle,mode,w): #behaviour of RTL model of R8

    #calculating internal weights
    
    if (mode=="NTT"):
        data_in[0] = data_in[0]*twiddle[0]
        data_in[1] = data_in[1]*twiddle[1]
        data_in[2] = data_in[2]*twiddle[2]
        data_in[3] = data_in[3]*twiddle[3]
        data_in[4] = data_in[0]*twiddle[4]
        data_in[5] = data_in[1]*twiddle[5]
        data_in[6] = data_in[2]*twiddle[6]
        data_in[7] = data_in[3]*twiddle[7]

        data_out[0] = data_in[0] + w[2]*data_in[1] + w[3]*data_in[2] + w[4]*data_in[3] + w[5]*data_in[4] + w[6]*data_in[5] + w[7]*data_in[6] + w[8]*data_in[7];
        data_out[1] = data_in[0] + w[4]*data_in[1] + w[7]*data_in[2] - w[2]*data_in[3] - w[5]*data_in[4] - w[8]*data_in[5] + w[3]*data_in[6] + w[6]*data_in[7];
        data_out[2] = data_in[0] + w[6]*data_in[1] - w[3]*data_in[2] - w[8]*data_in[3] + w[5]*data_in[4] - w[2]*data_in[5] - w[7]*data_in[6] + w[4]*data_in[7];
        data_out[3] = data_in[0] + w[8]*data_in[1] - w[7]*data_in[2] + w[6]*data_in[3] - w[5]*data_in[4] + w[4]*data_in[5] - w[3]*data_in[6] + w[2]*data_in[7];
        data_out[4] = data_in[0] - w[2]*data_in[1] + w[3]*data_in[2] - w[4]*data_in[3] + w[5]*data_in[4] - w[6]*data_in[5] + w[7]*data_in[6] - w[8]*data_in[7];
        data_out[5] = data_in[0] - w[4]*data_in[1] + w[7]*data_in[2] + w[2]*data_in[3] - w[5]*data_in[4] + w[8]*data_in[5] + w[3]*data_in[6] - w[6]*data_in[7];
        data_out[6] = data_in[0] - w[6]*data_in[1] - w[3]*data_in[2] + w[8]*data_in[3] + w[5]*data_in[4] + w[2]*data_in[5] - w[7]*data_in[6] - w[4]*data_in[7];
        data_out[7] = data_in[0] - w[8]*data_in[1] - w[7]*data_in[2] - w[6]*data_in[3] - w[5]*data_in[4] - w[4]*data_in[5] - w[3]*data_in[6] - w[2]*data_in[7];
        return data_out
    else :
        data_out[0] = data_in[0] + w[2]*data_in[1] + w[3]*data_in[2] + w[4]*data_in[3] + w[5]*data_in[4] + w[6]*data_in[5] + w[7]*data_in[6] + w[8]*data_in[7];
        data_out[1] = data_in[0] + w[4]*data_in[1] + w[7]*data_in[2] - w[2]*data_in[3] - w[5]*data_in[4] - w[8]*data_in[5] + w[3]*data_in[6] + w[6]*data_in[7];
        data_out[2] = data_in[0] + w[6]*data_in[1] - w[3]*data_in[2] - w[8]*data_in[3] + w[5]*data_in[4] - w[2]*data_in[5] - w[7]*data_in[6] + w[4]*data_in[7];
        data_out[3] = data_in[0] + w[8]*data_in[1] - w[7]*data_in[2] + w[6]*data_in[3] - w[5]*data_in[4] + w[4]*data_in[5] - w[3]*data_in[6] + w[2]*data_in[7];
        data_out[4] = data_in[0] - w[2]*data_in[1] + w[3]*data_in[2] - w[4]*data_in[3] + w[5]*data_in[4] - w[6]*data_in[5] + w[7]*data_in[6] - w[8]*data_in[7];
        data_out[5] = data_in[0] - w[4]*data_in[1] + w[7]*data_in[2] + w[2]*data_in[3] - w[5]*data_in[4] + w[8]*data_in[5] + w[3]*data_in[6] - w[6]*data_in[7];
        data_out[6] = data_in[0] - w[6]*data_in[1] - w[3]*data_in[2] + w[8]*data_in[3] + w[5]*data_in[4] + w[2]*data_in[5] - w[7]*data_in[6] - w[4]*data_in[7];
        data_out[7] = data_in[0] - w[8]*data_in[1] - w[7]*data_in[2] - w[6]*data_in[3] - w[5]*data_in[4] - w[4]*data_in[5] - w[3]*data_in[6] - w[2]*data_in[7];

        data_out[0] = data_out[0]*twiddle[0]
        data_out[1] = data_out[1]*twiddle[1]
        data_out[2] = data_out[2]*twiddle[2]
        data_out[3] = data_out[3]*twiddle[3]
        data_out[4] = data_out[4]*twiddle[4]
        data_out[5] = data_out[5]*twiddle[5]
        data_out[6] = data_out[6]*twiddle[6]
        data_out[7] = data_out[7]*twiddle[7]
        
        return data_out




