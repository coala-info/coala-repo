[kPAL](index.html)

latest

* [Introduction](intro.html)
* [Installation](install.html)
* [Methodology](method.html)
* [Tutorial](tutorial.html)
* Using the Python library
  + [*k*-mer profiles](#k-mer-profiles)
  + [Storing *k*-mer profiles](#storing-k-mer-profiles)
  + [Differences between *k*-mer profiles](#differences-between-k-mer-profiles)

* [API reference](api.html)

* [Development](development.html)
* [*k*-mer profile file format](fileformat.html)
* [Changelog](changelog.html)
* [Copyright](copyright.html)

[kPAL](index.html)

* [Docs](index.html) »
* Using the Python library
* [Edit on GitHub](https://github.com/LUMC/kPAL/blob/master/doc/library.rst)

---

# Using the Python library[¶](#using-the-python-library "Permalink to this headline")

kPAL provides a light-weight Python library for creating, analysing, and
manipulating *k*-mer profiles. It is implemented on top of [NumPy](http://www.numpy.org/).

This is a gentle introduction to the library. Consult the [API reference](api.html#api) for more
detailed documentation.

## *k*-mer profiles[¶](#k-mer-profiles "Permalink to this headline")

The class [`Profile`](api.html#kpal.klib.Profile "kpal.klib.Profile") is the central object in kPAL. It encapsulates
*k*-mer counts and provides operations on them.

Instead of using the [`Profile`](api.html#kpal.klib.Profile "kpal.klib.Profile") constructor directly, you should
generally use one of the profile construction methods. One of those is
[`Profile.from_fasta()`](api.html#kpal.klib.Profile.from_fasta "kpal.klib.Profile.from_fasta"). The following code creates a 6-mer profile by
counting from a FASTA file:

```
>>> from kpal.klib import Profile
>>> p = Profile.from_fasta(open('a.fasta'), 6)
```

The profile object has several properties. For example, we can ask for the
*k*-mer length (also known as *k*), the total *k*-mer count, or the median
count per *k*-mer:

```
>>> p.length
6
>>> p.total
49995
>>> p.median
12.0
```

Counts are stored as a NumPy [`ndarray`](http://docs.scipy.org/doc/numpy/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v1.10)") of integers, one for each
possible *k*-mer, in alphabetical order:

```
>>> len(p.counts)
4096
>>> p.counts
array([ 8, 11,  5, ...,  7, 12, 13])
```

We can get the index in that array for a certain *k*-mer using the
[`dna_to_binary()`](api.html#kpal.klib.Profile.dna_to_binary "kpal.klib.Profile.dna_to_binary") method:

```
>>> i = p.dna_to_binary('AATTAA')
>>> p.counts[i]
13
```

## Storing *k*-mer profiles[¶](#storing-k-mer-profiles "Permalink to this headline")

Todo.

## Differences between *k*-mer profiles[¶](#differences-between-k-mer-profiles "Permalink to this headline")

Todo.

[Next](api.html "API reference")
 [Previous](tutorial.html "Tutorial")

---

© [Copyright](copyright.html) 2013-2014, LUMC, Jeroen F.J. Laros, Martijn Vermaat.
Revision `79b2ff97`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).