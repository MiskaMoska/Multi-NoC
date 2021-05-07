import matplotlib as mpl
import matplotlib.pyplot as plt
import math

# mpl.rcParams['text.usetex'] = True

plt.figure(figsize=(6,4),dpi=180)
bwidth = 1.5
# plt.style.use('ggplot')

weights = [3090,3072,3082,3058,1496]
label = [r'$Inside\ NoC0$', r'$Inside\ NoC1$',r'$Inside\ NoC2$', r'$Span\ 1\ NoC$', r'$Span\ 2\ NoCs$']
explode = (0.005,0.005,0.005,.1,.2)
color = ["lightslategrey","lightslategrey","lightslategrey","seagreen","coral"]

# plt.axis("off")
plt.title(r'$Transaction\ composition\ ratio$')
plt.pie(weights, labels=label,colors=color,explode=explode, pctdistance=0.7,autopct='%1.2f%%',startangle=50)
plt.show()
