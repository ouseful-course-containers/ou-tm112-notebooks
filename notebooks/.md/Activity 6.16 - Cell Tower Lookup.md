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

<!-- #region -->
<a name="cellTowers"></a>
# Activity 6.16 - Cell Tower Lookup

Online web applications such as [OpenCelliD](https://www.opencellid.org/) allow users to enter uniquely identifying information for a cell tower and in return display the location of the corresponding cell tower on an interactive map.

For example, use the above service to identify the location of the cell tower with details:

- `MCC`: 234, `MNC`: 15, `LAC`: 714, `CellID`: 1671


Services such as OpenCellID typically obtain the location data by calling a remote geolocation web service via an API. With access to such an API, we can create our own equivalent service.

Geolocation APIs such as the Google geolocation API, or the [`openbmap API`](https://radiocells.org/geolocation), which is compatible with the Google geolocation API, allow look-ups of the geographical location (latitude and longitude co-ordinates) of cell towers and wifi hotspots based on their unique IDs.

In mid-2018, the Google geolocation API changed from a free service to a pay-as-you-go service requiring API key access. The `openbmap` API is compatible with the Google geolocation API — that is, it uses the same data format when making a request to the API and when receiving a data response from it — but it's availability cannot be guaranteed.


In this activity you will see how to call the API services *in principle*, if not in fact.
<!-- #endregion -->

### Walk-through of How to Call the API

The following walk through demonstrates how to call the API. If you have a Google geolocation API key (you are not required to have one, and you are not expected to sign up for one), set the value of the `APIkey` variable below using it. If you want to try to use the `openbmap` API, set the APIkey value to an empty string (`APIkey=''`). To just work through the activity without calling either API, set `APIkey=None`.

```python
# APIkey='YOUR GOOGLE LOCATION API ENABLED KEY' #Insert your API key if you already have one & want to use it
# APIkey='' #Set the key value to an empty string if you want to try to use the openbmap service
APIkey=None #Set the value to None to skip trying to call either API
```

To call the API, or look up a cell tower location using a third party web app with its own API access, we need four pieces of data:

    - the network operator mobile country code (MCC): for example, the UK MCC code is 234
    - the mobile network code (MNC): for example, the Vodafone UK MNC is 15
    - the cell tower location area code (LAC): for example, 714
    - the cell tower cell ID (CellID): for example, 1671


If you have set your Google API key, or want to try the `openbmap` service, run the following cell to look up the details of a particular cell tower. (Alternatively, use one of the third party web app services linked to above.)

```python
#Add your cell tower details here.
#You can find them using an app such as the OpenSignal app

postjson = {
  "cellTowers": [
    {
        "mobileCountryCode": 234, #MCC
        "mobileNetworkCode": 15, #MNC
        "locationAreaCode": 979, #LAC
        "cellId": 42333969 #CellId
    }
  ]
}
```

To call the service, we construct a URL as defined for a particular API and make a request to that URL using the *python* `requests` package.

```python
#The requests library makes it easy to call URLs using Python
import requests
```

To pass the data to the API, we need to create a Python `dict` that describes the data in a formally structured way:

```python
postjson = {"cellTowers": [{"cellId": 21532831, "locationAreaCode": 2862, 
                            "mobileCountryCode": 214, "mobileNetworkCode": 7}]}

postjson
```

This parameter data is passed, as part of an HTTP/POST request, to the API endpoint URL, if one is specified:

```python
#Set the url to the appropriate API endpoint location
url=None

if APIkey:
    url='https://www.googleapis.com/geolocation/v1/geolocate?key={}'.format(APIkey)
elif APIkey is not None:
    url="https://radiocells.org/backend/geolocate"
    
    
if url:
    #Make the request
    r = requests.post(url, json=postjson)
    if not r.ok:
        # display the response if something went wrong...
        print('Error: '+r.text)
```

The `requests` package allows us parse any valid response as a JSON object and cast it to a Python dictionary:

```python
#If we get a valid response
if APIkey is not None and r.ok:
    #Obtain the JSON response to a Python dict object
    r.json()
```

A typical response looks something like this:

```json
{'location': {'lat': 52.0370316, 'lng': -0.7098534999999999},
 'accuracy': 1391.0}
 ```

If the location of the devices with the specified MAC addresses are known, a location is determined and returned as a latitude / longitude pair and a specified accuracy.

```python
if APIkey is None or not r.ok:
    #Here's one I prepared earlier
    jsondata={'location': {'lat':50.659079, 'lng':-1.149397}}

lat = jsondata['location']['lat']
lon = jsondata['location']['lng']

print('JSON: {}\nlat,lon = ({}, {})'.format(jsondata, lat, lon))
```

The latitude / longitude pair can the be used to identify the approximate location on a map.


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

Modify the `postjson` definition above to use the same network settings but location area code 714 and cell tower ID    1671. Run the code cells again. Where is the cell tower located?
