import random

def generate_RF_tracefile(file_name, num_tests):
    a1 = 0
    a2 = 0
    a3 = 0
    d_in = 0
    internal_d = [0,0,0,0,0,0,0,0]
    with open(file_name, "w") as file:
        for i in range(8):
            internal_d_new = internal_d[:] 
            w_en = 0
            B = random.randint(0, 65535)
            a3 = i
            file.write(f"0{w_en}{format(a1,'03b')}{format(a2,'03b')}{format(a3,'03b')}{format(B,'016b')} {format(internal_d[a1],'016b')}{format(internal_d[a2],'016b')}\n")
            internal_d = internal_d_new
            file.write(f"1{w_en}{format(a1,'03b')}{format(a2,'03b')}{format(a3,'03b')}{format(B,'016b')} {format(internal_d[a1],'016b')}{format(internal_d[a2],'016b')}\n")
        for _ in range(num_tests):
            internal_d_new = internal_d[:] 
            w_en = 0
            A = random.randint(0, 7) 
            B = random.randint(0, 65535)

            decision_f = random.randint(0,15)
            if decision_f == 0:
                while a1 == A:
                    A = random.randint(0, 7)
                a1 = A
            elif decision_f == 1:
                while a2 == A:
                    A = random.randint(0, 7)
                a2 = A
            elif decision_f == 15:
                while a3 == A:
                    A = random.randint(0, 7)
                a3 = A
            else:
                while a3 == A:
                    A = random.randint(0, 7)
                a3 = A
                internal_d_new[A] = B
                w_en = 1

            file.write(f"0{w_en}{format(a1,'03b')}{format(a2,'03b')}{format(a3,'03b')}{format(B,'016b')} {format(internal_d[a1],'016b')}{format(internal_d[a2],'016b')}\n")
            internal_d = internal_d_new
            file.write(f"1{w_en}{format(a1,'03b')}{format(a2,'03b')}{format(a3,'03b')}{format(B,'016b')} {format(internal_d[a1],'016b')}{format(internal_d[a2],'016b')}\n")

generate_RF_tracefile("TRACEFILE_RF.txt", 40)

