import csv
import subprocess, os



benchmarks = os.listdir('benchmarks')
args = ["python3", "pyres-fof.py", "-tifbp", "-H", "-n", "benchmarks/"]
clauses = ["PickGiven2_FIFO", "PickGiven2_FILO", "PickGiven2_Horn", "PickGiven2_Unit"]
# clauses = ["PickGiven2_Horn", "PickGiven2_Unit"]
# clauses = ["PickGiven2_FILO"]
n = ["smallest", "largest"]

for i in benchmarks:
    # if i == "ITP018+1.p":
    #     continue
    for j in clauses:
        for k in n:
            args[3] += j
            args[4] += k
            args[5] += i
            
            print(args)
            temp = None
            with open('file.txt', 'w+') as fh:
                try:
                    x = subprocess.Popen(args=args, stdout=fh).wait()
                except:
                    pass
                finally:
                    fh.seek(0)
                    temp = fh.readlines()[-11:]
                    temp = [s.strip() for s in temp]
                    temp = [s.strip('# ') for s in temp]

            args = ["python3", "pyres-fof.py", "-tifbp", "-H", "-n", "benchmarks/"]
            with open('all_approaches.csv', 'a', encoding='UTF8') as f:
                if temp is not None:
                    for t in temp:
                        if "Initial clauses    :" in t:
                            writer = csv.writer(f)
                            writer.writerow([i, j, k, temp])
                        else:
                            break