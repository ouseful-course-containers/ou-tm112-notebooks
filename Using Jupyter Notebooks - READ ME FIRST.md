
# Using Jupyter notebooks

Welcome to the world of Jupyter notebooks.

Jupyter notebooks provide a literate programming, browser-based interface and interactive development environment for a wide range of computer languages.

This notebook – and the notebooks you will be using in TM112 – are designed to be used with a Python 3 environment. The Python environment is created by a Jupyter notebook server. The server manages the environment and communication between the environment and the notebook interface.

Your Python code *does not* execute in the browser: it runs in the Python environment managed by the notebook server. If you check the URL you are viewing this notebook from, the domain part of the URL broadly identifies the location the server is running from.

As you can probably tell, Jupyter notebooks can include text, like this.

If you click once within this block of text, you should notice that the *cell* containing this text becomes selected.

If you *double-click* the cell, which happens to be a *markdown* cell, as identified in the notebook toolbar at top of the notebook, it becomes editable.

Try and type something...

To return the rendered view of the cell, click the `Run` button in the toolbar, or use the keyboard shortcut: `Shift-Enter`.

## Markdown
Markdown cells contain *markdown*, which is a simplified markup language. Double-click this cell again to enter the edit mode to see the raw markdown. You may notice it reads sensibly as "annotated" text – *emphasised* elements, __strongly emphasised__ elements, as well as when rendered as HTML.

### Nesting
Markdown also lets you create lists:

- item 1
- item 2
  - subitem 1
  
Remember: to get out of markdown cell edit mode, `Run` the cell (or `Shift-Enter`).

As well as markdown cells, Jupyter notebooks also contain code cells. By default, when you create a new cell (click the `+` button in the toolbar), it is created as a code cell. To change the type of a cell, click on it once to highlight it and then set the cell type from the toolbar menu. (There are keyboard shortcuts to do this too: `Esc-M` converts a code cell to a markdown cell.)

See if you can create a new cell, convert it to a markdown cell, and create some of your own text, starting with a heading. If you make a mistake, `Ctrl-Z` will undo the change.

## Code cells

So what are code cells? You may notice that the cell directly below this one looks different. That's because it's a *code* cell. Code cells contain executable code – Python in the case of the TM112 notebooks.

To execute the code, click on the cell to select it and click the run button (or `Shift-Enter`).


```python
print('hello world')
```

Click in a code cell to edit it. See if you can change the message in the cell above and then run it to print out your own message.

Click on this cell to highlight it and then create a new code cell (the `+` button in the toolbar). You can also delete a cell using the scissors. There is an *Undo Delete Cells* option in the *Edit* menu if you make a mistake.

The new cell should be created directly below this one. Click in the code area to raise an edit cursor and see if you can print out another message from that cell.

## Using Python in a code cell

You can include one or more lines of any valid python code in a code cell, including comments. When you run the code cell, the code is executed and the state is updated in the normal way.

Run the following code cell – does it behave as you expect?


```python
#Create a variable
a = 1
#Add to it
a = a + 1
print(a)
```

The Python environment behind the notebook is actually an IPython environment. One of the handy features about it is that the value of a variable that is on the last line of the code cell is displayed when you run the cell.

*(By now you're hopefully getting the idea that when you get to a code cell whilst reading the notebook, you should run it. I'm going to assume that from now on and stop prompting you... except for this one last time: run the code cell below.)*


```python
a = a + 1
a
```

Did that cell behave as you expected?

One thing to notice is that the notebook output is preserved and does not update to show the *current state* of a variable. (In the same way, the history of executed statements in IDLE doesn't magically update when you update the value of a variable.)

So if you run the code cell below, the output displayed by the code cell above could be misleading...


```python
a = a + 1
a
```

One way to keep track of things is to look at the index number that appears to the left of a code cell (and its output) when you run the cell. The number is incremental and keeps track of the order in which you have run the cells.

If you want to run a notebook from scratch, as a blank slate, you can kill the current Python process and create a new one. From the *Kernel* menu, select one of the *Restart* options. This will throw away all state you have set and give you a completely fresh Python environment to work with. The ease with which Python kernels can be restarted from scratch is useful when testing notebooks that embody a process you want to be repeatable, such as a piece of scientific analysis. This is one of the major use cases for Jupyter notebooks. 

## So what next?

That's about all you need to know in order to use the notebooks as part of TM112.

For the most part, the TM112 notebook activities just require you to run the provided code cells, with some minor edits or contributions (for example, providing a postcode for the geocoding activities). If you do update or make edits to a notebook, it will autosave regularly; but you can also force a save using the *Save and Checkpoint* toolbar button. You can also download a notebook as an *.ipynb* file or export an HTML rendering of it from the *File* menu. (The HTML version of the page is not interactive: you will not be able to run the code from it.)

You are welcome to create your own Jupyter notebooks and use them for your own work. If you prefer a more traditional code development environment, you may be interested in checking out the [JupyterLab environment](https://blog.jupyter.org/jupyterlab-is-ready-for-users-5a6f039b8906).
