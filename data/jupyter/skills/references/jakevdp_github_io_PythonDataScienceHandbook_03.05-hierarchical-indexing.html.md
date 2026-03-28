[Python Data Science Handbook](/PythonDataScienceHandbook/ "Home")

* [About](/pages/about.html "About")
* [Archive](/archives.html "Archive")

![](/PythonDataScienceHandbook/figures/PDSH-cover-small.png)
*This is an excerpt from the [Python Data Science Handbook](http://shop.oreilly.com/product/0636920034919.do) by Jake VanderPlas; Jupyter notebooks are available [on GitHub](https://github.com/jakevdp/PythonDataScienceHandbook).*

*The text is released under the [CC-BY-NC-ND license](https://creativecommons.org/licenses/by-nc-nd/3.0/us/legalcode), and code is released under the [MIT license](https://opensource.org/licenses/MIT). If you find this content useful, please consider supporting the work by [buying the book](http://shop.oreilly.com/product/0636920034919.do)!*

# Hierarchical Indexing

< [Handling Missing Data](03.04-missing-values.html) | [Contents](index.html) | [Combining Datasets: Concat and Append](03.06-concat-and-append.html) >

[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg "Open and Execute in Google Colaboratory")](https://colab.research.google.com/github/jakevdp/PythonDataScienceHandbook/blob/master/notebooks/03.05-Hierarchical-Indexing.ipynb)

Up to this point we've been focused primarily on one-dimensional and two-dimensional data, stored in Pandas `Series` and `DataFrame` objects, respectively.
Often it is useful to go beyond this and store higher-dimensional data–that is, data indexed by more than one or two keys.
While Pandas does provide `Panel` and `Panel4D` objects that natively handle three-dimensional and four-dimensional data (see [Aside: Panel Data](#Aside:-Panel-Data)), a far more common pattern in practice is to make use of *hierarchical indexing* (also known as *multi-indexing*) to incorporate multiple index *levels* within a single index.
In this way, higher-dimensional data can be compactly represented within the familiar one-dimensional `Series` and two-dimensional `DataFrame` objects.

In this section, we'll explore the direct creation of `MultiIndex` objects, considerations when indexing, slicing, and computing statistics across multiply indexed data, and useful routines for converting between simple and hierarchically indexed representations of your data.

We begin with the standard imports:

In [1]:

```
import pandas as pd
import numpy as np
```

## A Multiply Indexed Series[¶](#A-Multiply-Indexed-Series)

Let's start by considering how we might represent two-dimensional data within a one-dimensional `Series`.
For concreteness, we will consider a series of data where each point has a character and numerical key.

### The bad way[¶](#The-bad-way)

Suppose you would like to track data about states from two different years.
Using the Pandas tools we've already covered, you might be tempted to simply use Python tuples as keys:

In [2]:

```
index = [('California', 2000), ('California', 2010),
         ('New York', 2000), ('New York', 2010),
         ('Texas', 2000), ('Texas', 2010)]
populations = [33871648, 37253956,
               18976457, 19378102,
               20851820, 25145561]
pop = pd.Series(populations, index=index)
pop
```

Out[2]:

```
(California, 2000)    33871648
(California, 2010)    37253956
(New York, 2000)      18976457
(New York, 2010)      19378102
(Texas, 2000)         20851820
(Texas, 2010)         25145561
dtype: int64
```

With this indexing scheme, you can straightforwardly index or slice the series based on this multiple index:

In [3]:

```
pop[('California', 2010):('Texas', 2000)]
```

Out[3]:

```
(California, 2010)    37253956
(New York, 2000)      18976457
(New York, 2010)      19378102
(Texas, 2000)         20851820
dtype: int64
```

But the convenience ends there. For example, if you need to select all values from 2010, you'll need to do some messy (and potentially slow) munging to make it happen:

In [4]:

```
pop[[i for i in pop.index if i[1] == 2010]]
```

Out[4]:

```
(California, 2010)    37253956
(New York, 2010)      19378102
(Texas, 2010)         25145561
dtype: int64
```

This produces the desired result, but is not as clean (or as efficient for large datasets) as the slicing syntax we've grown to love in Pandas.

### The Better Way: Pandas MultiIndex[¶](#The-Better-Way:-Pandas-MultiIndex)

Fortunately, Pandas provides a better way.
Our tuple-based indexing is essentially a rudimentary multi-index, and the Pandas `MultiIndex` type gives us the type of operations we wish to have.
We can create a multi-index from the tuples as follows:

In [5]:

```
index = pd.MultiIndex.from_tuples(index)
index
```

Out[5]:

```
MultiIndex(levels=[['California', 'New York', 'Texas'], [2000, 2010]],
           labels=[[0, 0, 1, 1, 2, 2], [0, 1, 0, 1, 0, 1]])
```

Notice that the `MultiIndex` contains multiple *levels* of indexing–in this case, the state names and the years, as well as multiple *labels* for each data point which encode these levels.

If we re-index our series with this `MultiIndex`, we see the hierarchical representation of the data:

In [6]:

```
pop = pop.reindex(index)
pop
```

Out[6]:

```
California  2000    33871648
            2010    37253956
New York    2000    18976457
            2010    19378102
Texas       2000    20851820
            2010    25145561
dtype: int64
```

Here the first two columns of the `Series` representation show the multiple index values, while the third column shows the data.
Notice that some entries are missing in the first column: in this multi-index representation, any blank entry indicates the same value as the line above it.

Now to access all data for which the second index is 2010, we can simply use the Pandas slicing notation:

In [7]:

```
pop[:, 2010]
```

Out[7]:

```
California    37253956
New York      19378102
Texas         25145561
dtype: int64
```

The result is a singly indexed array with just the keys we're interested in.
This syntax is much more convenient (and the operation is much more efficient!) than the home-spun tuple-based multi-indexing solution that we started with.
We'll now further discuss this sort of indexing operation on hieararchically indexed data.

### MultiIndex as extra dimension[¶](#MultiIndex-as-extra-dimension)

You might notice something else here: we could easily have stored the same data using a simple `DataFrame` with index and column labels.
In fact, Pandas is built with this equivalence in mind. The `unstack()` method will quickly convert a multiply indexed `Series` into a conventionally indexed `DataFrame`:

In [8]:

```
pop_df = pop.unstack()
pop_df
```

Out[8]:

|  | 2000 | 2010 |
| --- | --- | --- |
| California | 33871648 | 37253956 |
| New York | 18976457 | 19378102 |
| Texas | 20851820 | 25145561 |

Naturally, the `stack()` method provides the opposite operation:

In [9]:

```
pop_df.stack()
```

Out[9]:

```
California  2000    33871648
            2010    37253956
New York    2000    18976457
            2010    19378102
Texas       2000    20851820
            2010    25145561
dtype: int64
```

Seeing this, you might wonder why would we would bother with hierarchical indexing at all.
The reason is simple: just as we were able to use multi-indexing to represent two-dimensional data within a one-dimensional `Series`, we can also use it to represent data of three or more dimensions in a `Series` or `DataFrame`.
Each extra level in a multi-index represents an extra dimension of data; taking advantage of this property gives us much more flexibility in the types of data we can represent. Concretely, we might want to add another column of demographic data for each state at each year (say, population under 18) ; with a `MultiIndex` this is as easy as adding another column to the `DataFrame`:

In [10]:

```
pop_df = pd.DataFrame({'total': pop,
                       'under18': [9267089, 9284094,
                                   4687374, 4318033,
                                   5906301, 6879014]})
pop_df
```

Out[10]:

|  |  | total | under18 |
| --- | --- | --- | --- |
| California | 2000 | 33871648 | 9267089 |
| 2010 | 37253956 | 9284094 |
| New York | 2000 | 18976457 | 4687374 |
| 2010 | 19378102 | 4318033 |
| Texas | 2000 | 20851820 | 5906301 |
| 2010 | 25145561 | 6879014 |

In addition, all the ufuncs and other functionality discussed in [Operating on Data in Pandas](03.03-operations-in-pandas.html) work with hierarchical indices as well.
Here we compute the fraction of people under 18 by year, given the above data:

In [11]:

```
f_u18 = pop_df['under18'] / pop_df['total']
f_u18.unstack()
```

Out[11]:

|  | 2000 | 2010 |
| --- | --- | --- |
| California | 0.273594 | 0.249211 |
| New York | 0.247010 | 0.222831 |
| Texas | 0.283251 | 0.273568 |

This allows us to easily and quickly manipulate and explore even high-dimensional data.

## Methods of MultiIndex Creation[¶](#Methods-of-MultiIndex-Creation)

The most straightforward way to construct a multiply indexed `Series` or `DataFrame` is to simply pass a list of two or more index arrays to the constructor. For example:

In [12]:

```
df = pd.DataFrame(np.random.rand(4, 2),
                  index=[['a', 'a', 'b', 'b'], [1, 2, 1, 2]],
                  columns=['data1', 'data2'])
df
```

Out[12]:

|  |  | data1 | data2 |
| --- | --- | --- | --- |
| a | 1 | 0.554233 | 0.356072 |
| 2 | 0.925244 | 0.219474 |
| b | 1 | 0.441759 | 0.610054 |
| 2 | 0.171495 | 0.886688 |

The work of creating the `MultiIndex` is done in the background.

Similarly, if you pass a dictionary with appropriate tuples as keys, Pandas will automatically recognize this and use a `MultiIndex` by default:

In [13]:

```
data = {('California', 2000): 33871648,
        ('California', 2010): 37253956,
        ('Texas', 2000): 20851820,
        ('Texas', 2010): 25145561,
        ('New York', 2000): 18976457,
        ('New York', 2010): 19378102}
pd.Series(data)
```

Out[13]:

```
California  2000    33871648
            2010    37253956
New York    2000    18976457
            2010    19378102
Texas       2000    20851820
            2010    25145561
dtype: int64
```

Nevertheless, it is sometimes useful to explicitly create a `MultiIndex`; we'll see a couple of these methods here.

### Explicit MultiIndex constructors[¶](#Explicit-MultiIndex-constructors)

For more flexibility in how the index is constructed, you can instead use the class method constructors available in the `pd.MultiIndex`.
For example, as we did before, you can construct the `MultiIndex` from a simple list of arrays giving the index values within each level:

In [14]:

```
pd.MultiIndex.from_arrays([['a', 'a', 'b', 'b'], [1, 2, 1, 2]])
```

Out[14]:

```
MultiIndex(levels=[['a', 'b'], [1, 2]],
           labels=[[0, 0, 1, 1], [0, 1, 0, 1]])
```

You can construct it from a list of tuples giving the multiple index values of each point:

In [15]:

```
pd.MultiIndex.from_tuples([('a', 1), ('a', 2), ('b', 1), ('b', 2)])
```

Out[15]:

```
MultiIndex(levels=[['a', 'b'], [1, 2]],
           labels=[[0, 0, 1, 1], [0, 1, 0, 1]])
```

You can even construct it from a Cartesian product of single indices:

In [16]:

```
pd.MultiIndex.from_product([['a', 'b'], [1, 2]])
```

Out[16]:

```
MultiIndex(levels=[['a', 'b'], [1, 2]],
           labels=[[0, 0, 1, 1], [0, 1, 0, 1]])
```

Similarly, you can construct the `MultiIndex` directly using its internal encoding by passing `levels` (a list of lists containing available index values for each level) and `labels` (a list of lists that reference these labels):

In [17]:

```
pd.MultiIndex(levels=[['a', 'b'], [1, 2]],
              labels=[[0, 0, 1, 1], [0, 1, 0, 1]])
```

Out[17]:

```
MultiIndex(levels=[['a', 'b'], [1, 2]],
           labels=[[0, 0, 1, 1], [0, 1, 0, 1]])
```

Any of these objects can be passed as the `index` argument when creating a `Series` or `Dataframe`, or be passed to the `reindex` method of an existing `Series` or `DataFrame`.

### MultiIndex level names[¶](#MultiIndex-level-names)

Sometimes it is convenient to name the levels of the `MultiIndex`.
This can be accomplished by passing the `names` argument to any of the above `MultiIndex` constructors, or by setting the `names` attribute of the index after the fact:

In [18]:

```
pop.index.names = ['state', 'year']
pop
```

Out[18]:

```
state       year
California  2000    33871648
            2010    37253956
New York    2000    18976457
            2010    19378102
Texas       2000    20851820
            2010    25145561
dtype: int64
```

With more involved datasets, this can be a useful way to keep track of the meaning of various index values.

### MultiIndex for columns[¶](#MultiIndex-for-columns)

In a `DataFrame`, the rows and columns are completely symmetric, and just as the rows can have multiple levels of indices, the columns can have multiple levels as well.
Consider the following, which is a mock-up of some (somewhat realistic) medical data:

In [19]:

```
# hierarchical indices and columns
index = pd.MultiIndex.from_product([[2013, 2014], [1, 2]],
                                   names=['year', 'visit'])
columns = pd.MultiIndex.from_product([['Bob', 'Guido', 'Sue'], ['HR', 'Temp']],
                                     names=['subject', 'type'])

# mock some data
data = np.round(np.random.randn(4, 6), 1)
data[:, ::2] *= 10
data += 37

# create the DataFrame
health_data = pd.DataFrame(data, index=index, columns=columns)
health_data
```

Out[19]:

|  | subject | Bob | | Guido | | Sue | |
| --- | --- | --- | --- | --- | --- | --- | --- |
|  | type | HR | Temp | HR | Temp | HR | Temp |
| year | visit |  |  |  |  |  |  |
| 2013 | 1 | 31.0 | 38.7 | 32.0 | 36.7 | 35.0 | 37.2 |
| 2 | 44.0 | 37.7 | 50.0 | 35.0 | 29.0 | 36.7 |
| 2014 | 1 | 30.0 | 37.4 | 39.0 | 37.8 | 61.0 | 36.9 |
| 2 | 47.0 | 37.8 | 48.0 | 37.3 | 51.0 | 36.5 |

Here we see where the multi-indexing for both rows and columns can come in *very* handy.
This is fundamentally four-dimensional data, where the dimensions are the subject, the measurement type, the year, and the visit number.
With this in place we can, for example, index the top-level column by the person's name and get a full `DataFrame` containing just that person's information:

In [20]:

```
health_data['Guido']
```

Out[20]:

|  | type | HR | Temp |
| --- | --- | --- | --- |
| year | visit |  |  |
| 2013 | 1 | 32.0 | 36.7 |
| 2 | 50.0 | 35.0 |
| 2014 | 1 | 39.0 | 37.8 |
| 2 | 48.0 | 37.3 |

For complicated records containing multiple labeled measurements across multiple times for many subjects (people, countries, cities, etc.) use of hierarchical rows and columns can be extremely convenient!

## Indexing and Slicing a MultiIndex[¶](#Indexing-and-Slicing-a-MultiIndex)

Indexing and slicing on a `MultiIndex` is designed to be intuitive, and it helps if you think about the indices as added dimensions.
We'll first look at indexing multiply indexed `Series`, and then multiply-indexed `DataFrame`s.

### Multiply indexed Series[¶](#Multiply-indexed-Series)

Consider the multiply indexed `Series` of st