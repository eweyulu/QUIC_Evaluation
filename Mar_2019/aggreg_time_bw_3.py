#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 26 15:15:12 2019

@author: ndilo
"""
from __future__ import print_function, unicode_literals, division
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
import pandas as pd 
import time
import glob
import sys
import itertools
from matplotlib.lines import Line2D
import matplotlib.ticker as ticker

##Granularity
gran_arg = sys.argv[2] # get granularity from command line
gran_ = pd.to_numeric(gran_arg)

#
#import os
#print(os.listdir( os.path.split(__file__)[0] ))
#print(os.listdir( '/local/home/ndilo/Dropbox/Emily_Dell/QUIC_Evaluation/Mar_2019/' ))


# get default colors & markers 
colors = mpl.rcParams['axes.prop_cycle']
colors = [el['color'] for el in list(colors)]
marker = itertools.cycle((Line2D.filled_markers)) 

def data_aver(time_,bandwidth_, gran_):
    i=0
    int_count = 0

    time_cumsum = np.array(time_).cumsum()
    bw_arr = np.array([])
    tm_arr = np.array([gran_*int(time_[0]/gran_)])
    
    while True: # read through all datapoints
        bw_add = 0
        tm_thresh = (int_count+1)*gran_ + tm_arr[0]
         
        while time_cumsum[i] < tm_thresh: #loop until you reach next time interval
            bw_add += bandwidth_[i]      
            
            i+=1
            if i >= len(time_):
                break
            
        bw_arr = np.append(bw_arr, bw_add)
        tm_arr = np.append(tm_arr,tm_thresh)
        
        int_count+=1
        
        if i >= len(time_):
            break
        
    return tm_arr[:-1], bw_arr
        
        


# prepare figure
fig = plt.figure(1)
fig.clf()
ax = fig.add_subplot(111)
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.spines['bottom'].set_visible(False)
ax.spines['left'].set_visible(False)
ax.grid(True)


##load files
filename_ = sys.argv[1] #Get filenames from command line
filenames = sorted(glob.glob(filename_))
#filenames = sorted(glob.glob('*200-2.txt'))
#filenames = filenames[0:5]
for ii in range(len(filenames)):
    f = filenames[ii]
#    print(f)

    df = pd.read_csv(f, header=None, sep=' ')
    df.rename(columns={df.columns[0]: "0"})
    dataset = df.values
    dataset[0][0]=0
    
    ##Analyse data
    
    #time and bandwidth in datafile
    t = dataset[:,0]
    bw = dataset[:,1]

    #Get averages
#    GRAN = 1
#    t_avg ,bw_avg = data_aver(t, bw, GRAN) 
#    
#    bw_avg = bw_avg*8/1024/GRAN # convert to kb/s
#    ax.plot(t_avg, bw_avg,
#        marker='o', mfc='none',
#        color=colors[ii],
#        linestyle = '--',
#        alpha=0.5, label=f)
    
    GRAN = gran_
    t_avg ,bw_avg = data_aver(t, bw, GRAN) 
    
    bw_avg = bw_avg*8/1024/GRAN # convert to kb/s
    
    ax.plot(t_avg, bw_avg,
        marker=next(marker), mfc=None,
#        linestyle='dashed',
        color=colors[ii],
        zorder=-100,
        alpha=0.5, label=f)
    
    print('Total size: {} MBytes'.format(np.sum(GRAN * bw_avg/8/1024)))

    
    
    #Get averages
#    t_avg ,bw_avg = data_aver(t, bw, 0.001)
#    t_sum = t_avg.cumsum()
#    bw_avg = bw_avg*8/t_avg # convert to kb/s
#    ax.plot(t_sum, bw_avg,
#        marker='o', mfc='none',
#        color=colors[ii],
#        linestyle='--',
#        zorder=-100, # plot it behind the other plots
#        alpha=0.3)
    
    
    #sanity checks
    #print('raw data {} MBytes'.format(np.sum(bw_tcp)/1024**2))
    
#sanity check --- plot data points
#for x,y in zip(t_avg,bw_avg):        
#    ax.annotate('(%s)' %x, xy=(x,y), textcoords='data')

ax.xaxis.set_major_locator(ticker.MultipleLocator(1))
ax.xaxis.set_minor_locator(ticker.MultipleLocator(gran_))
ax.yaxis.set_minor_locator(ticker.MultipleLocator(1000))    
#ax.xaxis.set_major_formatter(mpl.ticker.EngFormatter(sep=''))
#ax.yaxis.set_major_formatter(mpl.ticker.EngFormatter(sep=''))
ax.set_xlabel('time [s]', fontsize=12, fontweight = 'bold')
#ax.set_ylim([0,200])
ax.set_xlim([0,35])
ax.set_ylabel('transmission rate [Kbps]', fontsize=12, fontweight = 'bold')
#    ax.legend()
ax.legend(loc='upper center', bbox_to_anchor=(0.5, 1.05),
      fancybox=True, shadow=True, ncol=5)
plt.show()
plt.grid(b=True, which='major', color='#666666', linestyle='-' )
plt.grid(b=True, which='minor', color='#999999', linestyle='-', alpha=0.2)
#
timestr = time.strftime("%Y%m%d-%H%M%S")
fig.savefig(timestr+'.png')
#    fig = plt.plot(figsize=(10.0, 3.0))

