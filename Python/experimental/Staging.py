import math


N = int(input("enter N point (power of 2) : "))

point = 2**N
stage_info = [[0,0],[0,0],[0,0]]
print("each radix 2 stage cycle : "+ str(point/2))
print("each radix 4 stage cycle : "+ str(point/4))
print("each radix 8 stage cycle : "+ str(point/8))

print("total ram used : "+str(point*32/8000)+" kb")

def staging(point,stage,N,stage_info):
    if (point == 1):
        print("done")
        return stage_info
    else :
        if (math.log2(point)%3==0):
            point = point/8
            stage = stage+1
            print("Radix 8 stage : "+ str(stage))

            if (stage_info[2][0]==0):
                stage_info[2][0] = stage
                staging(point,stage,N,stage_info)
            else :
                stage_info[2][1] = stage
                staging(point,stage,N,stage_info)
            
        elif (math.log2(point)%2==0):
            point = point/4
            stage = stage+1
            print("Radix 4 stage : "+ str(stage))

            if(stage_info[1][0]==0):
                stage_info[1][0] = stage
                staging(point,stage,N,stage_info)
            else :
                stage_info[1][1] = stage
                staging(point,stage,N,stage_info)
           
        else:
            point = point/2
            stage = stage+1
            print("Radix 2 stage : "+ str(stage))

            if(stage_info[0][0]==0):
                stage_info[0][0]= stage
                staging(point,stage,N,stage_info)
            else :
                stage_info[0][1] = stage
                staging(point,stage,N,stage_info)

staging(point,0,N,stage_info)
print(stage_info)
