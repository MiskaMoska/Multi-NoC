import matplotlib as mpl
import matplotlib.pyplot as plt
import math
import numpy as np

mpl.rcParams['text.usetex'] = True
plt.figure(dpi=180)
bwidth = 1.5
ax = plt.gca()
ax.spines['top'].set_linewidth(bwidth)
ax.spines['right'].set_linewidth(bwidth)
ax.spines['bottom'].set_linewidth(bwidth)
ax.spines['left'].set_linewidth(bwidth)
ax.spines['top'].set_linewidth(bwidth)
ax.spines['right'].set_linewidth(bwidth)

y1 = [22.671000,24.919000,28.290600,34.605400,54.521200,75.901000,84.558600,94.045000,96.587400,103.172600]
x = []
print(len(y1))
for i in range(len(y1)):
    x.append(i)

plt.gcf().subplots_adjust(bottom=0.2)
plt.xlabel(r"$Injecting\ Rate(Buffer\ Size=16,PML=16)$",fontsize="14")
plt.ylabel(r"$Average\ Latency$",fontsize="14")
plt.plot(x,y1,'-',color="red",linewidth=3)
plt.xlim([0,9])
plt.ylim([20,120])
plt.yticks([20,40,60,80,100,120],
            [r"$20$",r"$40$",r"$60$",r"$80$",r"$100$",r"$120$"])
plt.xticks([0,1,2,3,4,5,6,7,8,9],
            [r"$0.1$",r"$0.2$",r"$0.3$",r"$0.4$",r"$0.5$",r"$0.6$",r"$0.7$",r"$0.8$",r"$0.9$",r"$1.0$",])

ax.tick_params(axis = 'both', which = 'major', labelsize = 12, width=bwidth)
plt.grid(axis = "y")
# plt.legend()
# plt.legend(loc='upper left', fontsize=8) 
plt.show()
