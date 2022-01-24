import csv
import subprocess, os

benchmarks = os.listdir('benchmarks')
args = ["python3", "pyres-fof.py", "-tifbp", "-H", "-n", "benchmarks/"]
clauses = ["PickGiven2_FIFO", "PickGiven2_FILO", "PickGiven2_Horn", "PickGiven2_Unit"]
n = ["smallest", "largest"]


with open('file.csv', 'w', encoding='UTF8') as f:
    writer = csv.writer(f)
    for i in benchmarks:
        for j in clauses:
            for k in n:
                args[3] += j
                args[4] += k
                args[5] += i
                
                print(args)
                temp = None
                with open('file.txt', 'w+') as fh:
                    subprocess.Popen(args=args, stdout=fh).wait()
                    fh.seek(0)
                    temp = fh.readlines()[-11:]
                    temp = [s.strip() for s in temp]
                    temp = [s.strip('# ') for s in temp]

                args = ["python3", "pyres-fof.py", "-tifbp", "-H", "-n", "benchmarks/"]
                writer.writerow([i, j, k, temp])