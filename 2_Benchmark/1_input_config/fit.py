# -*- coding: utf-8 -*-
"""
Created on Thu Mar 31

@author: Roger Bellido
març 2022
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

folder="/home/usuario/Documentos/Master/2_TFM/2_Benchmark/1_input_config/"

df1=pd.read_csv(folder+'data_261_3429_a.dat',sep='\s+',decimal='.')
df2=pd.read_csv(folder+'data_261_6859_a.dat',sep='\s+',decimal='.')
df3=pd.read_csv(folder+'data_261_8573_a.dat',sep='\s+',decimal='.')
df4=pd.read_csv(folder+'data_261_12346_a.dat',sep='\s+',decimal='.')
df5=pd.read_csv(folder+'data_261_14747_a.dat',sep='\s+',decimal='.')

factor=2.5*10**2

df1['c_1[4]']=df1['c_1[4]']*factor
df1['c_2[4]']=df1['c_2[4]']*factor
df2['c_1[4]']=df2['c_1[4]']*factor
df2['c_2[4]']=df2['c_2[4]']*factor
df3['c_1[4]']=df3['c_1[4]']*factor
df3['c_2[4]']=df3['c_2[4]']*factor
df4['c_1[4]']=df4['c_1[4]']*factor
df4['c_2[4]']=df4['c_2[4]']*factor
df5['c_1[4]']=df5['c_1[4]']*factor
df5['c_2[4]']=df5['c_2[4]']*factor



def func(x, a, b):
    return a*x+b

min=5
max=1000

x1=df1['Step'][min:max]
y11=df1['c_1[4]'][min:max]
y12=df1['c_2[4]'][min:max]

x2=df2['Step'][min:max]
y21=df2['c_1[4]'][min:max]
y22=df2['c_2[4]'][min:max]

x3=df3['Step'][min:max]
y31=df3['c_1[4]'][min:max]
y32=df3['c_2[4]'][min:max]

x4=df4['Step'][min:max]
y41=df4['c_1[4]'][min:max]
y42=df4['c_2[4]'][min:max]

x5=df5['Step'][min:max]
y51=df5['c_1[4]'][min:max]
y52=df5['c_2[4]'][min:max]

popt11,pcov11=curve_fit(func,x1,y11)
popt12,pcov12=curve_fit(func,x1,y12)

popt21,pcov21=curve_fit(func,x2,y21)
popt22,pcov22=curve_fit(func,x2,y22)

popt31,pcov31=curve_fit(func,x3,y31)
popt32,pcov32=curve_fit(func,x3,y32)

popt41,pcov41=curve_fit(func,x4,y41)
popt42,pcov42=curve_fit(func,x4,y42)

popt51,pcov51=curve_fit(func,x5,y51)
popt52,pcov52=curve_fit(func,x5,y52)

p=pd.DataFrame({'p':[0.05,0.1,0.125,0.18,0.215],
                'D_m':[popt11[0],popt21[0],popt31[0],popt41[0],popt51[0]],
                'D_w':[popt12[0],popt22[0],popt32[0],popt42[0],popt52[0]]})

p['D_m']=p['D_m']/6
p['D_w']=p['D_w']/6

f,ax=plt.subplots()
plt.title(r'T$^{*}$=0.52, $\chi$=0.1')
plt.xlabel('P$^{*}$')
plt.ylabel('D')
# plt.xscale('log')
plt.xlim([0.025,0.3])
plt.ylim([0,0.06])
# plt.ticklabel_format(axis="y", style="sci", scilimits=(0,0))
plt.plot(p['p'],p['D_m'],'b.-',label='Methanol')
plt.plot(p['p'],p['D_w'],'k.-',label='Water')
plt.legend(loc='bottom left')

# plt.savefig(folder+'plot_D.png',dpi=220)
plt.show()
