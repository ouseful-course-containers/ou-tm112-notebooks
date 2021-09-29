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

# Location Based Computing

Welcome to this collection of practical activities. The materials are presented as an online interactive Jupyter Book textbook, although you can can also work through them as live interactive Jupyter notebooks if you prefer.


```{note}
Launching the execution environments that support the live interactive textbook activities or the live notebooks may take some time. We are freeloading on a community project that provides the computing backend — [MyBinder.org](https://mybinder.readthedocs.io/en/latest/) — and its available resources may be limited at any particular time.
```


## Running the Interactive Textbook Activities

To run interactive notebooks, from the top menu bar, clcik the rocket icon in the inteactive textbook toolbar at the top of the page and select the *Live Code* option.

A connection will be made a live code execution environment and the environment started up:

![](images/launch_thebe.gif)

When the environment is ready, that status notice will change:

![](images/thebe_ready.png)

When the environment is enabled, each code cell in the interactive textbook will be "activated" and include a *Run* button. Clicking he *Run* button in a cell will execute the code in that cell.

![](images/hello_world.gif)

Clicking *Restart* will reset the code execution environment. Following a restart, if a code cell requires an precursor code cell to have been run previously, you will need to make sure that cell is run again even if it was run prior to the restart.

```{warning}
The contents of code cells may be edited, which means you can change the contents of a code cell and run your own code. However, there is currently no way to save any code changes you may make.
```

<!-- #region -->
## Launching the Live Jupyter Notebooks

Jupyter notebooks are a widely used environment for working with executable documents that incorporate text, rich media assets (images, videos, auto players), executable code and the outputs of executed code.


```{note}
See the section [](using-jupyter-notebooks) if you are unfamiliar with how to work with Jupyter noteboks.
```

To launch the live Jupyter notebook, click on the rocker button in the toolbar at the top of the interactive textbook page and select the *Binder* option.

![](images/launch_binder.gif)

This will launch a MyBinder session and open a notebook equivalent of the current textbook page.

![](images/mybinder_nb.png)

```{warning}
If you edit the contents of the noteobok and you want to save them, you can either download the notebook or save it to browser storage ([*how to save notebooks to browser local storage*](https://github.com/manics/jupyter-offlinenotebook)).
```
<!-- #endregion -->
