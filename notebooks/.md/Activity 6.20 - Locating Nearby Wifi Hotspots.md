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

# Activity 6.20 - Locating Nearby WiFi Hotspots

As well as looking up cell tower locations, we can also use third party services (with varying degrees of success!) to look up the location of WiFi hotspots from uniquely identifying information that is disclosed by every single WiFi router.

For example, [WiGLE: Wireless Network Mapping](https://wigle.net/) allows you to see the location of the millions of router locations in its database via an interactive map. The locations are collected by wardriving - driving along public roads, listening out for WiFi hotspots, grabbing their name (SSID) and unique identfier (BSSID) and associating them with your current location. That's why the locations on the WiGLE interactive map typically appear by the roadside. (Zoom the map to show your location to see how many hotspots have been identifed near it.)

In the same way that we could in principle use a service such as the Google geolocation or `openbmap` APIs to look up the location of a mobile phone cell tower ([Activity 6.16 - Cell Tower Lookup.ipynb](Activity%206.16%20-%20Cell%20Tower%20Lookup.ipynb)), we can also use them to look up the location of a WiFi hotspot from its BSSID (*Basic Service Set IDentifier*).

If your computer has wifi access and is in range of one or more WiFi hostpots, you should be able to identify the MAC addresses of them using the following commands. The name of each hotspot in range should be given as the SSID, and the code you need for the lookup as the BSSID.

On your computer, run the appropriate command depending on the operating system you are using. *In order to detect nearby Wifi hostspots, you will need to ensure that your computer's WiFi is turned on.* The BSSID and SSID values should be displayed in the output report.


### Notebook Terminal

If you are running the notebook from a notebook server installed directly on your own computer, you should be able to run the following commands in a [Jupyter terminal launched from here](/j/terminals/1). If you are using an online hosted notebook, or a virtualised notebook server running in a virtual machine or Docker container running on your computer, you will need to run the following commands using a terminal/command prompt launched from your host desktop.


### Mac

From a terminal, run the command:

`/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -s`


### Windows

From a command prompt, run the command:

`netsh wlan show network mode=bssid`




### Linux

From a terminal, run the command:

`iwlist wlan0 scan`


## Checking the Location Using WiGLE

If you zoom in to you location on the WiGLE map, you can see if any of the nearby routers you have identifed are in its database by filtering on the SSID or BSSID.

Note that if you enabled location services in your browser when visiting the WiGLE page, it has access to your current location. If you are also searching for particular SSIDs or BSSIDs, it may loosely associate those IDs with your location (I don't know if it actually does... But it could...)


## Looking Up the Location of Hotspot MAC Addresses / BSSIDs

The Google Geolocation API and the `openbmap` API are both capable of looking up the geographical locations of cell towers or WiFi hotspots from their IDs and both called, and respond, in the same way.

The `openbmap` service also publishes the data that is exposed via its API as [free to download open data](https://radiocells.org/downloads/raw_data) (the files are quite large though!).


### Walk-through of How to Call the API

The following walk through demonstrates how to call the API. If you have a Google geolocation API key (you are not required to have one, and you are not expected to sign up for one), set the value of the `APIkey` variable below using it. If you want to try to use the `openbmap` API, set the APIkey value to an empty string (`APIkey=''`). To just work through the activity without calling either API, set `APIkey=None`.

```python
# APIkey='YOUR GOOGLE LOCATION API ENABLED KEY' #Insert your API key if you already have one & want to use it
# APIkey='' #Set the key value to an empty string if you want to try to use the openbmap service
APIkey=None #Set the value to None to skip trying to call either API
```

Add the BSSID / MAC address of *two* or more hotspots to the following Python list (if there is only one in range, try with that):

```python
hotspots = [  'one:of:your:hotspot:mac:addresses', 'another:of:your:hotspot:mac:addresses'] 
```

To make a request to the geolocation service, we need to post a correctly configured object to it. The message format is described in the [Google geolocation service documententation](https://developers.google.com/maps/documentation/geolocation/intro#wifi_access_point_object) and in a simpler way by the [`openbmap` API docs](https://radiocells.org/geolocation).

Specifically, we need to pass a list of wifi access point objects as part of a `wifiAccessPoints` list. The minimal definition of a wifi access point object takes the form: `{'macAddress': 'A:VALID:MAC:ADDRESS'}`.

```python
postjson={'wifiAccessPoints':[]}

for h in hotspots:
    postjson['wifiAccessPoints'].append({'macAddress':h})

#Preview the arguments
postjson
```

```python
import requests

#Set the url to the appropriate API endpoint location
url=None

if APIkey:
    url='https://www.googleapis.com/geolocation/v1/geolocate?key={}'.format(APIkey)
elif APIkey is not None:
    url="https://radiocells.org/backend/geolocate"
    
    
if url:
    #Make the request
    r = requests.post(url, headers=header,json=postjson)
    
    if not r.ok:
        # display the response if something went wrong...
        r.text
```

If the location of the devices with the specified MAC addresses are known, a location is determined and returned as a latitude / longitude pair and a specified accuracy.

```python
#If we get a valid response
if APIkey is not None and r.ok:
    #Obtain the JSON response to a Python dict object
    r.json()
```

A typical response would be of the form:

```json
{'location': {'lat': 50.659079, 'lng': -1.149397}, 'accuracy': 6664.0}
```

Extract the latitude and longitude values:

```python
if APIkey is None or not r.ok:
    #Here's one I prepared earlier
    jsondata={'location': {'lat':50.659079, 'lng':-1.149397}}

lat = jsondata['location']['lat']
lon = jsondata['location']['lng']

print('JSON: {}\nlat,lon = ({}, {})'.format(jsondata, lat, lon))
```

The latitude / longitude pair can the be used to identify the approximate location on a map.

Once again, we can use the `ipython_magic_folium` magic to help us create a quick map:

```python
%load_ext folium_magic
```

```python
%folium_map -m $lat,$lon,"Wifi hotspot location" -z 14
```

The first time I tried this activity, I have to admit it felt a little bit creepy knowing that I could detect the physical location of my home location from the MAC addresses of my neighbours' routers.

(Note — the dummy location selected above corresponds to an arbitrarily selected location and not my home location! If it corresponds to your house, or the house of someone you know, yes, that would be *really* creepy, but purely down to a chance occurrence!)
