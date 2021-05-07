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
y1 = [25.8966,24.875000,23.737400,23.118200,23.118200,23.118200,23.118200]
y2 = [31.770000,33.073600,30.592000,30.072000,30.213200,30.213200,31.208200]
y3 = [39.332400,46.992800,54.521200,49.099200,46.144400,46.104400,46.104400]
y4 = [58.201400,67.237400,83.426600,93.042200,93.248600,88.290600,88.966600]
y5 = [91.142200,104.367400,122.460600,149.483400,179.856600,179.068600,165.666600]
y6 = [154.090200,173.017800,186.453400,216.322600,281.456200,309.458600,305.413800]
y7 = [309.120200,301.562600,329.479400,352.968600,428.621800,534.392200,628.186200]
line = [25.8966,33.073600,54.521200,93.042200,179.856600,309.458600,628.186200]

y1_log = []
y2_log = []
y3_log = []
y4_log = []
y5_log = []
y6_log = []
y7_log = []
line_log = []

for i in range(len(y1)):
    y1_log.append(math.log2(y1[i]))
    y2_log.append(math.log2(y2[i]))
    y3_log.append(math.log2(y3[i]))
    y4_log.append(math.log2(y4[i]))
    y5_log.append(math.log2(y5[i]))
    y6_log.append(math.log2(y6[i]))
    y7_log.append(math.log2(y7[i]))
    line_log.append(math.log2(line[i]))

plt.xlabel(r"$Buffer\ Size\ (injecting\ rate=0.5)$",fontsize="14")
plt.ylabel(r"$Average\ Latency$",fontsize="14")
plt.plot(x,y1_log,'^--',color="blue",label=r"$PML=4$")
plt.plot(x,y2_log,'^--',color="green",label=r"$PML=8$")
plt.plot(x,y3_log,'^--',color="darkorange",label=r"$PML=16$")
plt.plot(x,y4_log,'^--',color="purple",label=r"$PML=32$")
plt.plot(x,y5_log,'^--',color="red",label=r"$PML=64$")
plt.plot(x,y6_log,'^--',color="olivedrab",label=r"$PML=128$")
plt.plot(x,y7_log,'^--',color="mediumvioletred",label=r"$PML=256$")
plt.plot(x,line_log,color = "black",linewidth=0.5,linestyle="--",label=r"$Divide\ Line$")
plt.yticks([5,6,7,8,9],
            [r"$32$",r"$64$",r"$128$",r"$256$",r"$512$"])
plt.xticks([1,2,3,4,5,6,7],
            [r"$4$",r"$8$",r"$16$",r"$32$",r"$64$",r"$128$",r"$256$"])
ax.tick_params(axis = 'both', which = 'major', labelsize = 12, width=bwidth)
plt.grid(axis = "y")
plt.legend()
plt.legend(loc='upper left', fontsize=8) # 标签位置
plt.show()
