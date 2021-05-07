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

x = [1,2,3,4,5,6,7,8,9,10]

y1 = [208,207,208,230,281,280,326,313,349,381]
y2 = [150,149,150,170,203,203,236,228,253,277]
y3 = [300,299,308,343,408,410,475,457,506,552]
y4 = [376,376,377,422,497,495,574,550,617,673]


plt.xlabel(r"$Pcycle/Dcycle(Injecting\ Rate=0.2)$",fontsize="14")
plt.ylabel(r"$Average\ Latency$",fontsize="14")
plt.plot(x,y1,'*-',color="blue",label=r"$For\ All\ Packets;$")
plt.plot(x,y2,'*-',color="green",label=r"$For\ Packets\ Inside\ A\ NoC;$")
plt.plot(x,y3,'*-',color="darkorange",label=r"$For\ Packets\ That\ Span\ 1\ NoC;$")
plt.plot(x,y4,'*-',color="purple",label=r"$For\ Packets\ That\ Span\ 2\ NoCs;$")
plt.yticks([100,200,300,400,500,600,700],
            [r"$100$",r"$200$",r"$300$",r"$400$",r"$500$",r"$600$",r"$700$"])
plt.xticks([1,2,3,4,5,6,7,8,9,10],
            [r"$0.2$",r"$0.4$",r"$0.6$",r"$0.8$",r"$1.0$",r"$1.2$",r"$1.4$",r"$1.6$",r"$1.8$",r"$2.0$"])
ax.tick_params(axis = 'both', which = 'major', labelsize = 12, width=bwidth)
plt.grid(axis = "y")
plt.legend()
plt.legend(loc='upper left', fontsize=10) 
plt.show()
