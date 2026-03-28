[Python Data Science Handbook](/PythonDataScienceHandbook/ "Home")

* [About](/pages/about.html "About")
* [Archive](/archives.html "Archive")

![](/PythonDataScienceHandbook/figures/PDSH-cover-small.png)
*This is an excerpt from the [Python Data Science Handbook](http://shop.oreilly.com/product/0636920034919.do) by Jake VanderPlas; Jupyter notebooks are available [on GitHub](https://github.com/jakevdp/PythonDataScienceHandbook).*

*The text is released under the [CC-BY-NC-ND license](https://creativecommons.org/licenses/by-nc-nd/3.0/us/legalcode), and code is released under the [MIT license](https://opensource.org/licenses/MIT). If you find this content useful, please consider supporting the work by [buying the book](http://shop.oreilly.com/product/0636920034919.do)!*

# Combining Datasets: Merge and Join

< [Combining Datasets: Concat and Append](03.06-concat-and-append.html) | [Contents](index.html) | [Aggregation and Grouping](03.08-aggregation-and-grouping.html) >

[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg "Open and Execute in Google Colaboratory")](https://colab.research.google.com/github/jakevdp/PythonDataScienceHandbook/blob/master/notebooks/03.07-Merge-and-Join.ipynb)

One essential feature offered by Pandas is its high-performance, in-memory join and merge operations.
If you have ever worked with databases, you should be familiar with this type of data interaction.
The main interface for this is the `pd.merge` function, and we'll see few examples of how this can work in practice.

For convenience, we will start by redefining the `display()` functionality from the previous section:

In [1]:

```
import pandas as pd
import numpy as np

class display(object):
    """Display HTML representation of multiple objects"""
    template = """<div style="float: left; padding: 10px;">
    <p style='font-family:"Courier New", Courier, monospace'>{0}</p>{1}
    </div>"""
    def __init__(self, *args):
        self.args = args

    def _repr_html_(self):
        return '\n'.join(self.template.format(a, eval(a)._repr_html_())
                         for a in self.args)

    def __repr__(self):
        return '\n\n'.join(a + '\n' + repr(eval(a))
                           for a in self.args)
```

## Relational Algebra[¶](#Relational-Algebra)

The behavior implemented in `pd.merge()` is a subset of what is known as *relational algebra*, which is a formal set of rules for manipulating relational data, and forms the conceptual foundation of operations available in most databases.
The strength of the relational algebra approach is that it proposes several primitive operations, which become the building blocks of more complicated operations on any dataset.
With this lexicon of fundamental operations implemented efficiently in a database or other program, a wide range of fairly complicated composite operations can be performed.

Pandas implements several of these fundamental building-blocks in the `pd.merge()` function and the related `join()` method of `Series` and `Dataframe`s.
As we will see, these let you efficiently link data from different sources.

## Categories of Joins[¶](#Categories-of-Joins)

The `pd.merge()` function implements a number of types of joins: the *one-to-one*, *many-to-one*, and *many-to-many* joins.
All three types of joins are accessed via an identical call to the `pd.merge()` interface; the type of join performed depends on the form of the input data.
Here we will show simple examples of the three types of merges, and discuss detailed options further below.

### One-to-one joins[¶](#One-to-one-joins)

Perhaps the simplest type of merge expresion is the one-to-one join, which is in many ways very similar to the column-wise concatenation seen in [Combining Datasets: Concat & Append](03.06-concat-and-append.html).
As a concrete example, consider the following two `DataFrames` which contain information on several employees in a company:

In [2]:

```
df1 = pd.DataFrame({'employee': ['Bob', 'Jake', 'Lisa', 'Sue'],
                    'group': ['Accounting', 'Engineering', 'Engineering', 'HR']})
df2 = pd.DataFrame({'employee': ['Lisa', 'Bob', 'Jake', 'Sue'],
                    'hire_date': [2004, 2008, 2012, 2014]})
display('df1', 'df2')
```

Out[2]:

df1

|  | employee | group |
| --- | --- | --- |
| 0 | Bob | Accounting |
| 1 | Jake | Engineering |
| 2 | Lisa | Engineering |
| 3 | Sue | HR |

df2

|  | employee | hire\_date |
| --- | --- | --- |
| 0 | Lisa | 2004 |
| 1 | Bob | 2008 |
| 2 | Jake | 2012 |
| 3 | Sue | 2014 |

To combine this information into a single `DataFrame`, we can use the `pd.merge()` function:

In [3]:

```
df3 = pd.merge(df1, df2)
df3
```

Out[3]:

|  | employee | group | hire\_date |
| --- | --- | --- | --- |
| 0 | Bob | Accounting | 2008 |
| 1 | Jake | Engineering | 2012 |
| 2 | Lisa | Engineering | 2004 |
| 3 | Sue | HR | 2014 |

The `pd.merge()` function recognizes that each `DataFrame` has an "employee" column, and automatically joins using this column as a key.
The result of the merge is a new `DataFrame` that combines the information from the two inputs.
Notice that the order of entries in each column is not necessarily maintained: in this case, the order of the "employee" column differs between `df1` and `df2`, and the `pd.merge()` function correctly accounts for this.
Additionally, keep in mind that the merge in general discards the index, except in the special case of merges by index (see the `left_index` and `right_index` keywords, discussed momentarily).

### Many-to-one joins[¶](#Many-to-one-joins)

Many-to-one joins are joins in which one of the two key columns contains duplicate entries.
For the many-to-one case, the resulting `DataFrame` will preserve those duplicate entries as appropriate.
Consider the following example of a many-to-one join:

In [4]:

```
df4 = pd.DataFrame({'group': ['Accounting', 'Engineering', 'HR'],
                    'supervisor': ['Carly', 'Guido', 'Steve']})
display('df3', 'df4', 'pd.merge(df3, df4)')
```

Out[4]:

df3

|  | employee | group | hire\_date |
| --- | --- | --- | --- |
| 0 | Bob | Accounting | 2008 |
| 1 | Jake | Engineering | 2012 |
| 2 | Lisa | Engineering | 2004 |
| 3 | Sue | HR | 2014 |

df4

|  | group | supervisor |
| --- | --- | --- |
| 0 | Accounting | Carly |
| 1 | Engineering | Guido |
| 2 | HR | Steve |

pd.merge(df3, df4)

|  | employee | group | hire\_date | supervisor |
| --- | --- | --- | --- | --- |
| 0 | Bob | Accounting | 2008 | Carly |
| 1 | Jake | Engineering | 2012 | Guido |
| 2 | Lisa | Engineering | 2004 | Guido |
| 3 | Sue | HR | 2014 | Steve |

The resulting `DataFrame` has an aditional column with the "supervisor" information, where the information is repeated in one or more locations as required by the inputs.

### Many-to-many joins[¶](#Many-to-many-joins)

Many-to-many joins are a bit confusing conceptually, but are nevertheless well defined.
If the key column in both the left and right array contains duplicates, then the result is a many-to-many merge.
This will be perhaps most clear with a concrete example.
Consider the following, where we have a `DataFrame` showing one or more skills associated with a particular group.
By performing a many-to-many join, we can recover the skills associated with any individual person:

In [5]:

```
df5 = pd.DataFrame({'group': ['Accounting', 'Accounting',
                              'Engineering', 'Engineering', 'HR', 'HR'],
                    'skills': ['math', 'spreadsheets', 'coding', 'linux',
                               'spreadsheets', 'organization']})
display('df1', 'df5', "pd.merge(df1, df5)")
```

Out[5]:

df1

|  | employee | group |
| --- | --- | --- |
| 0 | Bob | Accounting |
| 1 | Jake | Engineering |
| 2 | Lisa | Engineering |
| 3 | Sue | HR |

df5

|  | group | skills |
| --- | --- | --- |
| 0 | Accounting | math |
| 1 | Accounting | spreadsheets |
| 2 | Engineering | coding |
| 3 | Engineering | linux |
| 4 | HR | spreadsheets |
| 5 | HR | organization |

pd.merge(df1, df5)

|  | employee | group | skills |
| --- | --- | --- | --- |
| 0 | Bob | Accounting | math |
| 1 | Bob | Accounting | spreadsheets |
| 2 | Jake | Engineering | coding |
| 3 | Jake | Engineering | linux |
| 4 | Lisa | Engineering | coding |
| 5 | Lisa | Engineering | linux |
| 6 | Sue | HR | spreadsheets |
| 7 | Sue | HR | organization |

These three types of joins can be used with other Pandas tools to implement a wide array of functionality.
But in practice, datasets are rarely as clean as the one we're working with here.
In the following section we'll consider some of the options provided by `pd.merge()` that enable you to tune how the join operations work.

## Specification of the Merge Key[¶](#Specification-of-the-Merge-Key)

We've already seen the default behavior of `pd.merge()`: it looks for one or more matching column names between the two inputs, and uses this as the key.
However, often the column names will not match so nicely, and `pd.merge()` provides a variety of options for handling this.

### The `on` keyword[¶](#The-on-keyword)

Most simply, you can explicitly specify the name of the key column using the `on` keyword, which takes a column name or a list of column names:

In [6]:

```
display('df1', 'df2', "pd.merge(df1, df2, on='employee')")
```

Out[6]:

df1

|  | employee | group |
| --- | --- | --- |
| 0 | Bob | Accounting |
| 1 | Jake | Engineering |
| 2 | Lisa | Engineering |
| 3 | Sue | HR |

df2

|  | employee | hire\_date |
| --- | --- | --- |
| 0 | Lisa | 2004 |
| 1 | Bob | 2008 |
| 2 | Jake | 2012 |
| 3 | Sue | 2014 |

pd.merge(df1, df2, on='employee')

|  | employee | group | hire\_date |
| --- | --- | --- | --- |
| 0 | Bob | Accounting | 2008 |
| 1 | Jake | Engineering | 2012 |
| 2 | Lisa | Engineering | 2004 |
| 3 | Sue | HR | 2014 |

This option works only if both the left and right `DataFrame`s have the specified column name.

### The `left_on` and `right_on` keywords[¶](#The-left_on-and-right_on-keywords)

At times you may wish to merge two datasets with different column names; for example, we may have a dataset in which the employee name is labeled as "name" rather than "employee".
In this case, we can use the `left_on` and `right_on` keywords to specify the two column names:

In [7]:

```
df3 = pd.DataFrame({'name': ['Bob', 'Jake', 'Lisa', 'Sue'],
                    'salary': [70000, 80000, 120000, 90000]})
display('df1', 'df3', 'pd.merge(df1, df3, left_on="employee", right_on="name")')
```

Out[7]:

df1

|  | employee | group |
| --- | --- | --- |
| 0 | Bob | Accounting |
| 1 | Jake | Engineering |
| 2 | Lisa | Engineering |
| 3 | Sue | HR |

df3

|  | name | salary |
| --- | --- | --- |
| 0 | Bob | 70000 |
| 1 | Jake | 80000 |
| 2 | Lisa | 120000 |
| 3 | Sue | 90000 |

pd.merge(df1, df3, left\_on="employee", right\_on="name")

|  | employee | group | name | salary |
| --- | --- | --- | --- | --- |
| 0 | Bob | Accounting | Bob | 70000 |
| 1 | Jake | Engineering | Jake | 80000 |
| 2 | Lisa | Engineering | Lisa | 120000 |
| 3 | Sue | HR | Sue | 90000 |

The result has a redundant column that we can drop if desired–for example, by using the `drop()` method of `DataFrame`s:

In [8]:

```
pd.merge(df1, df3, left_on="employee", right_on="name").drop('name', axis=1)
```

Out[8]:

|  | employee | group | salary |
| --- | --- | --- | --- |
| 0 | Bob | Accounting | 70000 |
| 1 | Jake | Engineering | 80000 |
| 2 | Lisa | Engineering | 120000 |
| 3 | Sue | HR | 90000 |

### The `left_index` and `right_index` keywords[¶](#The-left_index-and-right_index-keywords)

Sometimes, rather than merging on a column, you would instead like to merge on an index.
For example, your data might look like this:

In [9]:

```
df1a = df1.set_index('employee')
df2a = df2.set_index('employee')
display('df1a', 'df2a')
```

Out[9]:

df1a

|  | group |
| --- | --- |
| employee |  |
| Bob | Accounting |
| Jake | Engineering |
| Lisa | Engineering |
| Sue | HR |

df2a

|  | hire\_date |
| --- | --- |
| employee |  |
| Lisa | 2004 |
| Bob | 2008 |
| Jake | 2012 |
| Sue | 2014 |

You can use the index as the key for merging by specifying the `left_index` and/or `right_index` flags in `pd.merge()`:

In [10]:

```
display('df1a', 'df2a',
        "pd.merge(df1a, df2a, left_index=True, right_index=True)")
```

Out[10]:

df1a

|  | group |
| --- | --- |
| employee |  |
| Bob | Accounting |
| Jake | Engineering |
| Lisa | Engineering |
| Sue | HR |

df2a

|  | hire\_date |
| --- | --- |
| employee |  |
| Lisa | 2004 |
| Bob | 2008 |
| Jake | 2012 |
| Sue | 2014 |

pd.merge(df1a, df2a, left\_index=True, right\_index=True)

|  | group | hire\_date |
| --- | --- | --- |
| employee |  |  |
| Lisa | Engineering | 2004 |
| Bob | Accounting | 2008 |
| Jake | Engineering | 2012 |
| Sue | HR | 2014 |

For convenience, `DataFrame`s implement the `join()` method, which performs a merge that defaults to joining on indices:

In [11]:

```
display('df1a', 'df2a', 'df1a.join(df2a)')
```

Out[11]:

df1a

|  | group |
| --- | --- |
| employee |  |
| Bob | Accounting |
| Jake | Engineering |
| Lisa | Engineering |
| Sue | HR |

df2a

|  | hire\_date |
| --- | --- |
| employee |  |
| Lisa | 2004 |
| Bob | 2008 |
| Jake | 2012 |
| Sue | 2014 |

df1a.join(df2a)

|  | group | hire\_date |
| --- | --- | --- |
| employee |  |  |
| Bob | Accounting | 2008 |
| Jake | Engineering | 2012 |
| Lisa | Engineering | 2004 |
| Sue | HR | 2014 |

If you'd like to mix indices and columns, you can combine `left_index` with `right_on` or `left_on` with `right_index` to get the desired behavior:

In [12]:

```
display('df1a', 'df3', "pd.merge(df1a, df3, left_index=True, right_on='name')")
```

Out[12]:

df1a

|  | group |
| --- | --- |
| employee |  |
| Bob | Accounting |
| Jake | Engineering |
| Lisa | Engineering |
| Sue | HR |

df3

|  | name | salary |
| --- | --- | --- |
| 0 | Bob | 70000 |
| 1 | Jake | 80000 |
| 2 | Lisa | 120000 |
| 3 | Sue | 90000 |

pd.merge(df1a, df3, left\_index=True, right\_on='name')

|  | group | name | salary |
| --- | --- | --- | --- |
| 0 | Accounting | Bob | 70000 |
| 1 | Engineering | Jake | 80000 |
| 2 | Engineering | Lisa | 120000 |
| 3 | HR | Sue | 90000 |

All of these options also work with multiple indices and/or multiple columns; the interface for this behavior is very intuitive.
For more information on this, see the ["Merge, Join, and Concatenate" section](http://pandas.pydata.org/pandas-docs/stable/merging.html) of the Pandas documentation.

## Specifying Set Arithmetic for Joins[¶](#Specifying-Set-Arithmetic-for-Joins)

In all the preceding examples we have glossed over one important consideration in performing a join: the type of set arithmetic used in the join.
This comes up when a value appears in one key column but not the other. Consider this example:

In [13]:

```
df6 = pd.DataFrame({'name': ['Peter', 'Paul', 'Mary'],
                    'food': ['fish', 'beans', 'bread']},
                   columns=['name', 'food'])
df7 = pd.DataFra