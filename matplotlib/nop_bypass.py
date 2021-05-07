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

y1 = [261,289,296,299,302,303,305,306,307,307]
y2 = [799,836,840,839,835,841,838,838,837,837]
y3 = [242,277,284,292,294,295,298,296,297,297]
y4 = [634,673,690,689,691,692,685,692,699,699]


plt.xlabel(r"$Injecting\ Rate\ (Pcylce = 20,\ Dcycle = 10)$",fontsize="14")
plt.ylabel(r"$Average\ Latency$",fontsize="14")
plt.plot(x,y1,'*-',color="blue",label=r"$Bypass\ Off;\ Packet\ Inside\ NoC;$")
plt.plot(x,y2,'*-',color="blue",label=r"$Bypass\ Off;\ Packet\ Span\ NoC;$")
plt.plot(x,y3,'*-',color="red",label=r"$Bypass\ On;\ Packet\ Inside\ NoC;$")
plt.plot(x,y4,'*-',color="red",label=r"$Bypass\ On;\ Packet\ Span\ NoC;$")
plt.yticks([100,200,300,400,500,600,700,800,900],
            [r"$100$",r"$200$",r"$300$",r"$400$",r"$500$",r"$600$",r"$700$",r"$800$",r"$900$"])
plt.xticks([1,2,3,4,5,6,7,8,9,10],
            [r"$0.1$",r"$0.2$",r"$0.3$",r"$0.4$",r"$0.5$",r"$0.6$",r"$0.7$",r"$0.8$",r"$0.9$",r"$1.0$"])
ax.tick_params(axis = 'both', which = 'major', labelsize = 12, width=bwidth)
plt.grid(axis = "y")
plt.legend()
plt.legend(loc='lower right', fontsize=8) 
plt.show()
