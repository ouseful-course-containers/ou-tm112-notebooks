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

# Playing with `dict`s – geolocation API data

In this notebook, you will have a chance to explore how Python `dict`s can be used to represent hierarchically structured data.


Python `dict`s are *associative arrays* that use *key: value* pairs. Data *value*s are associated with unique *key*s and retrieved by referencing the key you are interested in.

In a Python `dict`, the value associated with a particular key may itself be a `dict` structure, which gives us the notion of `nested dicts`.

Although the data provided by the `postcodes.io` service is returned as a JSON data structure, it can be re-representd (*sic*) as a nested Python `dict`, as modelled below.

```python
postcode_dict = {'result': {'admin_county': None,
                            'admin_district': 'Milton Keynes',
                            'admin_ward': 'Monkston',
                            'ccg': 'NHS Milton Keynes',
                            'codes': {'admin_county': 'E99999999',
                                      'admin_district': 'E06000042',
                                      'admin_ward': 'E05009415',
                                      'ccg': 'E38000107',
                                      'nuts': 'UKJ12',
                                      'parish': 'E04001275'},
                            'country': 'England',
                            'eastings': 488625,
                            'european_electoral_region': 'South East',
                            'incode': '6AA',
                            'latitude': 52.0249147315159,
                            'longitude': -0.709747474196332,
                            'lsoa': 'Milton Keynes 017C',
                            'msoa': 'Milton Keynes 017',
                            'nhs_ha': 'South Central',
                            'northings': 237063,
                            'nuts': 'Milton Keynes',
                            'outcode': 'MK7',
                            'parish': 'Walton',
                            'parliamentary_constituency': 'Milton Keynes South',
                            'postcode': 'MK7 6AA',
                            'primary_care_trust': 'Milton Keynes',
                            'quality': 1,
                            'region': 'South East'},
                 'status': 200}
```

We can access the body of the result by calling the `dict` using the `result` key value:

```python
#You can use single or double quotes when passing the key
postcode_dict['result']
```

```python
#Keys can also be passed as string variables
key="result"

postcode_dict[ key ]
```

You may notice that the value associated with the *"result"* key in the *postcode_dict* `dict` is another dict:

```python
type( postcode_dict[ 'result' ] )
```

To find the values of nested elements in the original data structure, we request a key from the currently selected `dict`:

```python
postcode_dict_result = postcode_dict[ 'result' ]
postcode_dict_result['parliamentary_constituency']
```

#### Exercise

Try to pull out the value of the *European electoral region* from the `postcode_dict` variable.

```python
#And the European electoral region is....

#YOUR CODE HERE
```

Which parish is the postcode associated with...?

```python
#YOUR CODE HERE

```

...and what postcode does the data refer to?

```python
#YOUR CODE HERE

```

### Referencing deep into a nested `dict`

To reference items in one `dict` nested inside another, we can "chain" together the keys for the nested `dict`s, one inside the other, defining a path that essentially walks through each `dict` in turn:

```python
postcode_dict[ 'result' ][ 'parliamentary_constituency' ]
```

#### Exercise

By referencing directly into the `postcode_dict` variable, what CCG (Clinical Commissioning Group) is the location in?

```python
#YOUR CODE HERE

```

What *code* does this CCG have? (Again, your answer should reference directly into the `postcode_dict` variable.)

```python
#YOUR CODE HERE

```

## Unique keys in nested `dict`s
In the sense that a `nested dict` is itself a `dict`, the unique key to a deeply nested element is then the complete path to the element. For example, when finding the Parliamentary Constituency in the result returned from the `postcodes.io` data, the unique key on the `postcode_dict` `dict` would be `[ 'result' ][ 'parliamentary_constituency' ]`.

Sometimes, you might notice that the same key may appear multiple times in a nested Python `dict`. This does not break the requirement that keys are unique, because the keys are each keys in a *different* parent `dict`.

For example, consider the data we might get back from a request made on the Google geolocation API: 

```python
postcode_dict2 = {'results': [{'address_components': [{'long_name': 'Walton Hall',
                                                       'short_name': 'Walton Hall',
                                                       'types': ['establishment', 'point_of_interest']},
                                                      {'long_name': 'Kents Hill',
                                                       'short_name': 'Kents Hill',
                                                       'types': ['locality', 'political']},
                                                      {'long_name': 'Milton Keynes',
                                                       'short_name': 'Milton Keynes',
                                                       'types': ['postal_town']},
                                                      {'long_name': 'Milton Keynes',
                                                       'short_name': 'Milton Keynes',
                                                       'types': ['administrative_area_level_2', 'political']},
                                                      {'long_name': 'England',
                                                       'short_name': 'England',
                                                       'types': ['administrative_area_level_1', 'political']},
                                                      {'long_name': 'United Kingdom',
                                                       'short_name': 'GB',
                                                       'types': ['country', 'political']},
                                                      {'long_name': 'MK7 6BH',
                                                       'short_name': 'MK7 6BH',
                                                       'types': ['postal_code']}],
                               'formatted_address': 'Walton Hall, Kents Hill, Milton Keynes MK7 6BH, UK',
                               'geometry': {'location': {'lat': 52.02462269999999, 'lng': -0.7107079},
                                            'location_type': 'APPROXIMATE',
                                            'viewport': {'northeast': {'lat': 52.02597168029149,
                                                                       'lng': -0.709358919708498},
                                                         'southwest': {'lat': 52.02327371970849,
                                                                       'lng': -0.712056880291502}}},
                               'place_id': 'ChIJW3FMFVuhd0gRVUSpS2HG-ps',
                               'types': ['establishment', 'point_of_interest']}],
                  'status': 'OK'}
```

Here, we see that there are several instances of `lat` and `lng` keys. The important thing to note is that the *path* to each of them is different:

```python
print(postcode_dict2['results'][0]['geometry']['location']['lat'],
      postcode_dict2['results'][0]['geometry']['viewport']['northeast']['lat'],
      postcode_dict2['results'][0]['geometry']['viewport']['southwest']['lat'],
      sep='\n')
```

Also note that we used a numerical index – `[0]` – to access the first (zero-indexed) `dict` in the Python `list` typed value associated with the `results` key in the original `postcode_dict2` `dict`.

```python
type(postcode_dict2['results'])
```

So what is it that makes the various `lat` keys unique? The answer is that they uniquely reference a different parent `dict` in each case:

```python
print(postcode_dict2['results'][0]['geometry']['location'], 
      postcode_dict2['results'][0]['geometry']['viewport']['northeast'],
      postcode_dict2['results'][0]['geometry']['viewport']['southwest'],
      sep='\n')
```

<!-- TODO: JD: is the following Python cell needed? -->

```python

```
