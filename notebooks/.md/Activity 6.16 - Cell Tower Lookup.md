---
jupyter:
  jupytext:
    formats: ipynb,.md//md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.13.8
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

<a name="cellTowers"></a>
# Activity 6.16 - Cell Tower Lookup

Online web applications such as [OpenCelliD](https://www.opencellid.org/) allow users to enter uniquely identifying information for a cell tower and in return display the location of the corresponding cell tower on an interactive map.

For example, use the above service to identify the location of the cell tower with details:

- MCC: 234
- MNC: 15
- LAC: 24708
- CID: 2561566

Services such as OpenCellID typically obtain the location data by calling a remote geolocation web service via an API. With access to such an API, we can create our own equivalent service.

In this activity you will see how to call the API services *in principle*, if not in fact.


### Walk-through of How to Call the API

If you use your browser developer tools to monitor your browser's network activity as you lookup a cell tower ID using the OpenCellID webservice, you might notice a request is made to a webservice that is used to lookup the location of the cell tower :

![image.png](attachment:image.png)

The request URL has the form:

`https://opencellid.org/ajax/searchCell.php?mcc=234&mnc=15&lac=24708&cell_id=2561566`

The location information is then used by calls to other services that can render the map, along with the location of cell towers in that general area.


The following walk through demonstrates the steps used to make a request to that API.

*Note that the following activity cannot be guaranteed to work. Webservices and APIs often use cookies and other techniques to block requests that are not made by an authorised user from an appropriate client (such as a web browser).*


To call the API, or look up a cell tower location using a third party web app with its own API access, we need four pieces of data:

- the network operator mobile country code (MCC): for example, the UK MCC code is 234
- the mobile network code (MNC): for example, the Vodafone UK MNC is 15
- the cell tower location area code (LAC): for example, 24708
- the cell tower cell ID (CellID): for example, 2561566

To call the service, we construct a URL as defined for a particular API and make a request to that URL using the *python* `requests` package.

```python
#The requests library makes it easy to call URLs using Python
import requests
```

To pass the data to the API, we need to create a Python `dict` that describes the data in a formally structured way:

```python
params = {"mcc": 234, #mobileCountryCode
          "mnc": 15, #mobileNetworkCode
          "lac": 24708, #locationAreaCode
          "cell_id": 2561566 #CellId
         }

params
```

This parameter data is passed, as part of an HTTP/POST request, to the API endpoint URL using the `requests` package.

The `requests` package also allows us parse any valid response as a JSON object and cast it to a Python dictionary:

```python
import requests

#Set the url to the appropriate API endpoint location
url = "https://opencellid.org/ajax/searchCell.php"

r = requests.get(url, params=params)
if not r.ok:
    # display the response if something went wrong...
    print('Error: '+r.text)
    
# Display the response
r.json()
```

A typical response looks something like this:

```json
{'lon': '-1.145837', 'lat': '50.657593', 'range': '1000'}
 ```

If the location of the devices with the specified MAC addresses are known, a location is determined and returned .

The latitude / longitude pair can then be used to identify the approximate location on a map.

For example, let's extract out the latitude and longitude into some correspondingly named variables:

```python
lon = r.json()["lon"]
lat = r.json()["lat"]

lon, lat
```

## So Where is That Location Exactly?


Armed with the latitude and longitude of a location, we can use those co-ordinates to place a marker on a map to reveal that location in more human understandable terms.

A quick way of doing that is to use some magic, literally, using some IPython magic known as `ipython_folium_magic` [[docs](https://github.com/psychemedia/ipython_magic_folium)]...

The following code cell loads in some IPython magic that supports the creation of embedded Google Maps in a Jupyter notebook. This cell only needs to be run once in any given notebook. Typically, magics are loaded at the start of a notebook, along with required Python packages. 

```python
%load_ext folium_magic
```

Now we can call on the magic as `%folium_map`. The `-l` parameter lets us pass in comma separated latitude and longitude (no spaces between them) and the `-m` parameter lets us create a marker by passing in a comma separated latitude, longitude and marker label (the latter in quotes). The `-z` parameter sets the zoom level (by default it is set to 10).

As well as using literal values, we can pass in values referenced via a variable we have already defined by prefixing the variable name with a `$`.

So for example, the following are all valid `folium_magic` commands. 

- `%folium_map -l 52.0370037,-0.7098603`
- `%folium_map -l $lat,$lon -z 14` (referencing the `lat` and `lon` variables defined above and increasing the zoom level)
- `%folium_map -m 52.0370037,-0.7098603,"My Marker"`

```python
%folium_map -m $lat,$lon -z 14
```

## Try it Yourself

Modify the `params` definition above to use following cell tower data:

- MCC: 234
- MNC: 10
- LAC: 1120
- CID: 133246578

Where is the cell tower located?
