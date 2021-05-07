import matplotlib as mpl
import matplotlib.pyplot as plt
import math

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

x = [1,2,3,4,5,6,7]

y1 = [16.415400,16.405400,16.405400,16.405400,16.405400,16.405400,16.405400]
y2 = [19.454200,19.443000,19.425000,19.425000,19.425000,19.425000,19.425000]
y3 = [24.907400,25.053000,24.919000,24.909400,24.909400,24.909400,24.909400]
y4 = [36.698600,36.542200,36.087800,35.951400,35.951400,35.951400,35.951400]
y5 = [59.924600,59.282600,58.952200,59.512600,59.490200,59.490200,59.490200]
y6 = [104.960200,103.550200,103.335400,102.991400,102.118600,101.939000,101.939000]
y7 = [193.194200,190.958200,193.683800,194.767400,196.275800,197.992600,193.382200]

y1_log = []
y2_log = []
y3_log = []
y4_log = []
y5_log = []
y6_log = []
y7_log = []

for i in range(len(y1)):
    y1_log.append(math.log2(y1[i]))
    y2_log.append(math.log2(y2[i]))
    y3_log.append(math.log2(y3[i]))
    y4_log.append(math.log2(y4[i]))
    y5_log.append(math.log2(y5[i]))
    y6_log.append(math.log2(y6[i]))
    y7_log.append(math.log2(y7[i]))

plt.xlabel(r"$Buffer\ Size\ (injecting\ rate=0.2)$",fontsize="14")
plt.ylabel(r"$Average\ Latency$",fontsize="14")
plt.plot(x,y1_log,'^--',color="blue",label=r"$PML=4$")
plt.plot(x,y2_log,'^--',color="green",label=r"$PML=8$")
plt.plot(x,y3_log,'^--',color="darkorange",label=r"$PML=16$")
plt.plot(x,y4_log,'^--',color="purple",label=r"$PML=32$")
plt.plot(x,y5_log,'^--',color="red",label=r"$PML=64$")
plt.plot(x,y6_log,'^--',color="olivedrab",label=r"$PML=128$")
plt.plot(x,y7_log,'^--',color="mediumvioletred",label=r"$PML=256$")
plt.yticks([4,5,6,7,8],
            [r"$16$",r"$32$",r"$64$",r"$128$",r"$256$"])
plt.xticks([1,2,3,4,5,6,7],
            [r"$4$",r"$8$",r"$16$",r"$32$",r"$64$",r"$128$",r"$256$"])
ax.tick_params(axis = 'both', which = 'major', labelsize = 12, width=bwidth)
plt.grid(axis = "y")
plt.legend()
plt.legend(loc='upper left', fontsize=8) 
plt.show()
