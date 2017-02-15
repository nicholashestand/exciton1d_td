# script to show animation of exciton dynamics
import sys
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np

# get number of input files, can be either 1 or 2
numf = len(sys.argv[1:])
if numf < 1:
    print('No trajectory file was given. Aborting.')
    exit()
elif numf > 2:
    print('Too many trajectory files were given. Can only take a maximum of 2. Aborting.')
    exit()

# read in the data file(s) and store in a dictionary
task_titles = sys.argv[1:]
data_dict = {}
for task_title in task_titles:
    data = np.genfromtxt(task_title+'_traj.csv', delimiter=',')
    data_dict[task_title+'_xs'] = data[0,1:]
    data_dict[task_title+'_ys'] = data[1:,1:]

# setup the figure and add axis labels
fig = plt.figure(1,figsize=(numf*6,4))
time = [] # list to keep track of time text
bars = [] # list to keep track of bar heights
colors = ['b','r'] # list to assign different bar colors to the plots
                   # if more than one

# setup a bar plot for each data set
for task_title in task_titles:
    xs = data_dict[task_title+'_xs']        # current x data
    ys = data_dict[task_title+'_ys'][0,:]   # current y data
    curnx = task_titles.index(task_title)   # current index for task_title
    plt.subplot(1,numf,curnx+1)             # select subplot
    # set graph labels
    plt.title('Exciton dynamics for '+task_title)
    plt.xlabel('Site')
    plt.ylabel('Frenkel Exciton Population')
    plt.xticks(range(len(xs)+1))
    # create text instance to keep track of the time later on
    time.append(plt.text(len(xs)-3,1,'',horizontalalignment='left',verticalalignment='top'))
    # make the bar plots and store in bars list
    bars.append(plt.bar( xs, ys, color=colors[curnx]))


# function to update the plot with data for the input frame
def update_plot(num):
    for task_title in task_titles:
        curnx = task_titles.index(task_title) # current index for task_title
        y = data_dict[task_title+'_ys'][num,:]# current y data
        # set the new bar height for the current frame
        for bar, h in zip( bars[ curnx ], y ):
            bar.set_height(h)
        # update the time text
        time[ task_titles.index(task_title) ].set_text('time= %i units' %num)
    return bars, time

# create the animation and show it
ani = animation.FuncAnimation(fig, update_plot, frames=range(len(data_dict[task_title+'_ys'])),interval=50,repeat=False)
plt.show()
