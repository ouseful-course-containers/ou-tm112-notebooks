---
jupyter:
  jupytext:
    formats: ipynb,.md//md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.11.4
  kernelspec:
    display_name: Python 3
    language: python
    name: python3
---

# Sonification demo

This notebook demonstrates how to "sonify" a simple dataset, converting the data to an audio form to help us try to perceive patterns within that data.


The notebook makes use of the Python `pandas` package to represent and *visualise* a dataset, as well as packages associated with the Jupyter notebook environment that support audio playback as well as the embedding of interactive widgets that allow us to explore a dataset interactively.


### Setting up the notebook

Run the following code cells to set up the notebook environment.

```python
#IPython package for embedding an audio player in a notebook
from IPython.display import Audio

#The ipwidgets.interact package supports interactive widget creation
from ipywidgets import interact

#Configure the notebook to display charts inline
%matplotlib inline

#Import a routine to plot simple datasets
from matplotlib.pyplot import plot
```

```python
#Import the pandas package for working with tabular datasets
import pandas as pd

#Various packages that provide access to maths functions
import random
import numpy as np
import math
```

## Working with audio

The following examples are based on a [sonification notebook](https://jupyter.brynmawr.edu/services/public/dblank/jupyter.cs/Sonification.ipynb) published by Doug Blank at Bryn Mawr College.

Let's start with a simple demonstration of how to create and play a simple tone (a sine wave). You do not need to understand how the code works in order to run the code cell.

If you want the audio player to play the tone automatically when the code cell is run, change the setting from `autoplay=False` to `autoplay=True`.

__Run the code cells below now.__

```python
duration = 2 # duration of the tone in seconds
rate = 44100 # sampling rate of the tone
```

```python
#https://jupyter.brynmawr.edu/services/public/dblank/jupyter.cs/Sonification.ipynb
#This rather complicated-looking function creates a function
#It allows us to retrieve the value of a sine wave of a particular frequency at a particular time.
#The frequency is the frequency of the tone in hertz (Hz)
def make_tone(frequency):
    def f(t):
        return math.sin(2 * math.pi * frequency * t)
    return f

tone440 = make_tone(440) 

#Visualise the tone over a short period (0.1s)
plot([tone440(t) for t in np.arange(0, .01, 1/rate)]);

#Generate the tone and play it through a notebook embedded audio player
Audio([tone440(t) for t in np.arange(0, duration, 1/rate)], rate=rate, autoplay=False)
```

## Sonifying data

As well as playing simple tones, we can also generate audio signals of varying frequencies based on data values contained within a dataset.

We will create a couple of helper functions to generate an "audio" dataset from a numerical dataset.

```python
# Function to find the value of a sine wave of a given frequency at a particular time
def make_tone2(t, frequency):
    return math.sin(2 * math.pi * frequency * t)
```

```python
#Grab a list of frequency values from a dataset for playback over a given period at a given sampling rate
def makeAudio(data, duration, rate, minf=200, maxf=5000):
    audiodata=[]
    for t in np.arange(0, duration, 1/rate):
        data_index = math.floor(t/duration * len(data))
        ratio = (data[data_index] - min(data))/(max(data) - min(data))            
        audiodata.append(make_tone2(t, ratio * (maxf - minf) + minf)) 
    return audiodata
```

The `makeAudio()` function may take some time to run, so it makes sense to provide a means for saving and loading the data. 

```python
def saveAudioData(data, outfile = "audiodata.txt"):
    ''' Function to save the audiodata list'''
    with open(outfile, "w") as f:
        for s in data:
            f.write(str(s) +"\n")

def loadAudioData(infile = "audiodata.txt"):
    readback = []
    with open(infile, "r") as f:
        for line in f:
            readback.append(line.strip())
    return readback
```

## Now it's time to sonify

Generate a sample dataset with several columns, each representing a set frequencies over time:

- a set of values that increase proportionally (linearly) over time
- a set of values that decrease proportionally (linearly) over time
- a set of values that increase proportionally (linearly) over time with the addition of random noise.

```python
#Generate the dataset and preview it as a chart
numpoints = 50

df = pd.DataFrame({'x':np.arange(0, numpoints)})

#Generate a column with values proportional to time
df['y'] =  df['x'] / numpoints

#Generate a column with values inversely proportional to time
df['y2'] = 1 - df['y']

#Generate a column with values proportional to time with the addition of random noise
df['y3'] = df.apply(lambda x: x['y']+((random.random()/5) - 0.1), axis=1)

ax = df.plot(kind='scatter', x='x', y='y', color='grey')
df.plot(kind='scatter', x='x', y='y2', color='green', ax=ax)
df.plot(kind='scatter', x='x', y='y3', color='red', ax=ax)

ax.set_xlabel('Sample number')
ax.set_ylabel('Value');
```

```python
minf=200 #Minimum frequency
maxf=4000 #Maximum frequency
duration = 2
```

Change the `col = ` setting to one of the other columns (`y`, `y2`, `y3`) to choose which set of data valus to visualise and sonify.

```python
#Select a column to visualise and sonify
col = 'y'

df.plot(kind='scatter', x= 'x', y=col);
Audio(makeAudio(df[col], duration, rate, minf, maxf), rate=rate, autoplay=False)
```

## Visualising a more random scatterplot

```python
#Example of reordering a list of numbers in a random order
nums = list(range(0,10))
random.shuffle(nums)
nums
```

```python
samples = 100

df = pd.DataFrame({'x':np.arange(0,samples)})
nums=list(range(0,samples))

random.shuffle(nums)
df['y'] = nums
df.plot(kind='scatter',x= 'x',y='y');
```

```python
df.plot(kind='scatter',x= 'x',y='y');
Audio(makeAudio(df['y'], duration, rate), rate=rate, autoplay=False)
```

## Generating scatterplots with a specified correlation

We can create a function that will generate scatterplots with a specified correlation.

We can then create an interactive scatterplot explorer that allows us to both visualise and sonify scatterplots with different correlations.

```python
#ish via https://stackoverflow.com/a/18684433/454773

#If the correlation is set to 1 we sometimes get a warning that we can ignore...
np.warnings.filterwarnings('ignore', r'covariance')

def generateCorrelatedData(correlation):
    ''' Function to create a two-dimensional dataset with a specified correlation between values '''
    
    xmin=0
    xmax=100

    ymin=0
    ymax=1

    xx = np.array([xmin, xmax])
    yy = np.array([ymin, ymax])
    means = [xx.mean(), yy.mean()]

    #Set up the standard deviations so the half-interval corresponds to 3 standard deviations
    #This means ~99% of the generated points will be inside the interval
    stds = [xx.std() / 3, yy.std() / 3]

    #Create the correlated data
    covariances = [[stds[0]**2, stds[0]*stds[1]*correlation], [stds[0]*stds[1]*correlation, stds[1]**2]]
    m = np.random.multivariate_normal(means, covariances, 50)
    
    #Represent the data as a dataframe
    df = pd.DataFrame(m, columns=['x','y'])
    
    #Sort the dataframe by increasing x
    df = df.sort_values('x').reset_index()
    
    return df
```

We can now use that function as part of an interactive scatterplot explorer.

```python
@interact(correlation=(0,1,0.05))
def correlatedScatter(correlation=1.0):
    df=generateCorrelatedData(correlation)
    df.plot(kind='scatter', x='x', y='y', title='Correlation: {}'.format(correlation));
    
    display(Audio(makeAudio(df['y'], duration, rate), rate=rate, autoplay=False))
```

## Saving the audio file

As well as playing the audio file, we can also save it.

```python
data=makeAudio(df['y'], duration, rate)
```

```python
#Wav file generator based on the Jupyter notebook Audio._make_wav() component

import struct
from io import BytesIO
import wave

def saveWav(audio_data, filename='sonified.wav', returner=False):
    nchan = 1

    fp = BytesIO()

    maxvalue = np.max(np.abs(audio_data))
    scaled = np.int16(audio_data/maxvalue * 32767).tolist()

    waveobj = wave.open(fp, mode='wb')
    waveobj.setnchannels(nchan)
    waveobj.setframerate(rate)
    waveobj.setsampwidth(2)
    waveobj.setcomptype('NONE','NONE')
    waveobj.writeframes(b''.join([struct.pack('<h',x) for x in scaled]))
    
    val = fp.getvalue()
    
    waveobj.close()
    
    with open(filename,'wb') as out:
        out.write(val)
        
    if returner: return val
```

## Summary

This notebook has demonstrated how simple datasets can be "visualised" in an audible way using a technique referred to as a *sonification*.
