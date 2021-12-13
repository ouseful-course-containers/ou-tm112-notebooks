---
jupyter:
  jupytext:
    formats: ipynb,.md//md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.11.5
  kernelspec:
    display_name: Python 3
    language: python
    name: python3
---

# Trilateration Demo

This notebook provides a simple interactive example of how the location and signal strength of three base stations can affect the amount of uncertainty associated with locating a receiver based on its relative distance from each of them.


## Trilateration Demo


When you run the following cell you will be presented with several interactive sliders that let you set the *x, y* coordinates that define the location of three separate base stations.

The *r* value sets the distance over which the cell tower can be detected, modeled as the radius of a circle drawn around the corresponding cell tower.

The location of a target receiver is identified as a red dot. The dark blue area represents the uncertainty in locating the receiver based on its ability to see two or more of the cell towers.

__Move the sliders to change the relative locations and ranges of each of the cell towers. See how it affects the uncertainty in determining location based on the ability to detect two or more cell towers and a knowledge of their locations.__

```python extensions={"jupyter_dashboards": {"version": 1, "views": {"grid_default": {"hidden": true}, "report_default": {"hidden": true}}}}
# NOTE THAT THE WIDGETS USED IN THIS DEMO DO NOW TOWK IN THE INTERACTIVE TEXTBOOK VIEW
%matplotlib inline
import tridash
```

You can look at the python code used to generate the interactive here: [tridash.py](tridash.py)
