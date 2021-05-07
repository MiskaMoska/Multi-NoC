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

y1 = [400,396,398,410,440,522,655]
y2 = [294,287,283,278,273,276,267]
y3 = [578,584,598,636,711,905,1226]
y4 = [691,682,698,765,918,1255,1885]


plt.xlabel(r"$FIFO\ Depth(Injecting\ Rate=0.2,Cycle\ Ratio = 2)$",fontsize="14")
plt.ylabel(r"$Average\ Latency$",fontsize="14")
plt.plot(x,y1,'*-',color="blue",label=r"$For\ All\ Packets;$")
plt.plot(x,y2,'*-',color="green",label=r"$For\ Packets\ Inside\ A\ NoC;$")
plt.plot(x,y3,'*-',color="darkorange",label=r"$For\ Packets\ That\ Span\ 1\ NoC;$")
plt.plot(x,y4,'*-',color="purple",label=r"$For\ Packets\ That\ Span\ 2\ NoCs;$")
plt.yticks([400,800,1200,1600,2000],
            [r"$400$",r"$800$",r"$1200$",r"$1600$",r"$2000$"])
plt.xticks([1,2,3,4,5,6,7],
            [r"$4$",r"$8$",r"$16$",r"$32$",r"$64$",r"$128$",r"$256$"])
ax.tick_params(axis = 'both', which = 'major', labelsize = 12, width=bwidth)
plt.grid(axis = "y")
plt.legend()
plt.legend(loc='upper left', fontsize=10) 
plt.show()
