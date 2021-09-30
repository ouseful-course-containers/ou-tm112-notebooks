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

# Activity 6.27 - Creating annotated interactive maps with Python 

This notebook demonstrates how to create a simple, interactive, embedded map using the Python `folium` package. You will also have an opportunity to create and save your own interactive map.

The package uses predefined templates to generate HTML and JavaScript code to render the map using the JavaScript `leaflet` library. The `ipython_folium_magic` magic is built on top of `folium`.

```python
#Run this cell first to import the folium package to access the maps
import folium
```

## Creating a map of the OU campus
We can create a `folium` map object by calling the `folium.Map()` function.

The map is centred on a particular location specified by using its latitude and longitude, using an optionally declared zoom level.

Any output from the command on the last line of a cell will be displayed as the cell's output.

Stating just a variable name returns the value of the object – in this case, an HTML page that implements our interactive map.

```python
#Run this cell to create the map object
mymap = folium.Map(location=[52.0236, -0.7088], zoom_start=15)

#Display the map
mymap
```

### Dynamically add markers to the map

The `folium.ClickForMarker()` function adds an interactive function to a map that allows you to click on the map at a particular location and add a marker to it.

Add the `folium.ClickForMarker()` function to the map and then add one or more markers to the map. Click on a marker to display a popup containing the latitude and longitude of the location the marker is placed at.

```python
#Add the ClickForMarker() functionality to the map
folium.ClickForMarker().add_to(mymap)

#Display the map
mymap
```

You can save a copy of the HTML file that implements the map using the `folium` map object's `.save('MY_MAP_FILENAME.html')` method.

```python
mymap.save('OUcampusMap.html')
```

Look at the directory this notebook is in – you should see the newly created `OUcampusMap.html` file there.

You can also view the file in your browser: [OUcampusMap.html](OUcampusMap.html).

One thing you may notice is that the markers you added to the map do not appear in the *saved* version of the map. This is because they are added to the interactive `leaflet` (JavaScript) map object, *not* your `folium` map object.

So how can we add more permanent markers to the map?


### Programmatically add markers to the folium map object

The `folium.Marker()` method creates a marker object with a particular location and popup label that can then be added to your `folium` map object.

```python
#Run this cell to add the markers to the map object...
folium.Marker([52.0239, -0.7072], popup='OU Library').add_to(mymap)
folium.Marker([52.0242, -0.7112], popup='Jennie Lee Building').add_to(mymap)

#Save the map
mymap.save('OUcampusMap-annotated.html')

#...and display the map in the notebook
mymap
```

What happens if you view the HTML file in your browser now? The markers should be there: [OUcampusMap-annotated.html](OUcampusMap-annotated.html).


## Popping up the latitude and longitude of a location

As well as the `folium` `ClickForMarker()` tool, there is another function we can add to the map: `LatLngPopup()`.

Rather than placing a marker, this simply displays a popup revealing the latitude and longitude of the location clicked on.

Zoom in to a particular location on the map using the map's +/- options, dragging the map with your mouse cursor to recentre it and find the coordinates of two or three locations on it.

```python
#Create a new map...
myNewMap=folium.Map()

#...within which you can interactively display the latitude and longitude of clicked-on locations
folium.LatLngPopup().add_to(myNewMap)

#Display the map
myNewMap
```

## Exercise

Using the recipe for creating a map and placing markers on it described above, create a map centred on your home location and two or three appropriately labelled markers identifying nearby points of interest.

Use the `LatLngPopup()` tool to find any latitude and longitude coordinates you need.

```python
#Create a map object, centred on your home, and at an appropriate zoom level

```

```python
#Programmatically add two or three markers, with appropriate labels, locating nearby points of interest

```

```python
#Render the map in the notebook

```

```python
#Save the map e.g. as myHomeMap.html

```

View the HTML version of your map directly in a new browser tab.

If you have the `LatLngPopup()` tool attached to your saved map, you may want to comment out where you added it and then recreate and save a version of the map without this click behavior added to it.


### Sharing your map
If you want to share your map, open the HTML file in a text editor, copy the HTML, and paste it into a gist at `https://gist.github.com` with the filename `index.html`. Save the gist as a *public* gist and in the URL replace the `gist.github.com` domain with `bl.ocks.org`. You should now be able to see your map published on the web.


## Summary

In this notebook, you have learned how to create a simple interactive map using the Python `folium` library and place markers on it.

You also learned how to fashion your own "location coordinates lookup" tool using the `folium LatLngPopup()` method.
