[kPAL](index.html)

latest

* [Introduction](intro.html)
* [Installation](install.html)
* [Methodology](method.html)
* [Tutorial](tutorial.html)
* [Using the Python library](library.html)

* API reference
  + [*k*-mer profiles](#module-kpal.klib)
  + [*k*-mer profile distances](#module-kpal.kdistlib)
  + [Metrics](#module-kpal.metrics)

* [Development](development.html)
* [*k*-mer profile file format](fileformat.html)
* [Changelog](changelog.html)
* [Copyright](copyright.html)

[kPAL](index.html)

* [Docs](index.html) »
* API reference
* [Edit on GitHub](https://github.com/LUMC/kPAL/blob/master/doc/api.rst)

---

# API reference[¶](#api-reference "Permalink to this headline")

This part of the documentation covers the interfaces of kPAL’s Python
library.

## *k*-mer profiles[¶](#module-kpal.klib "Permalink to this headline")

*class* `kpal.klib.``Profile`(*counts*, *name=None*)[¶](#kpal.klib.Profile "Permalink to this definition")
:   A *k*-mer profile provides *k*-mer counts and operations on them.

    Instead of using the [`Profile`](#kpal.klib.Profile "kpal.klib.Profile") constructor directly, you should
    generally use one of the profile construction methods:

    * [`from_file()`](#kpal.klib.Profile.from_file "kpal.klib.Profile.from_file")
    * [`from_file_old_format()`](#kpal.klib.Profile.from_file_old_format "kpal.klib.Profile.from_file_old_format")
    * [`from_fasta()`](#kpal.klib.Profile.from_fasta "kpal.klib.Profile.from_fasta")

    |  |  |
    | --- | --- |
    | Parameters: | * **counts** ([*numpy.ndarray*](http://docs.scipy.org/doc/numpy/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v1.10)")) – Array of integers where each element is the count for a   *k*-mer. Ordering is alphabetically by the *k*-mer. * **name** ([*str*](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)")) – Profile name. |

    `balance`()[¶](#kpal.klib.Profile.balance "Permalink to this definition")
    :   Add the counts of the reverse complement of a *k*-mer to the *k*-mer
        and vice versa.

    `binary_to_dna`(*number*)[¶](#kpal.klib.Profile.binary_to_dna "Permalink to this definition")
    :   Convert an integer to a DNA string.

        |  |  |
        | --- | --- |
        | Parameters: | **number** ([*int*](http://docs.python.org/2/library/functions.html#int "(in Python v2.7)")) – Binary representation of a DNA sequence. |
        | Returns: | DNA string corresponding to number. |
        | Return type: | [str](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)") |

    `copy`()[¶](#kpal.klib.Profile.copy "Permalink to this definition")
    :   Create a copy of the *k*-mer profile. This returns a deep copy, so
        modifying the copy’s *k*-mer counts will not affect the original and
        vice versa.

        |  |  |
        | --- | --- |
        | Returns: | Deep copy of profile. |
        | Return type: | [Profile](#kpal.klib.Profile "kpal.klib.Profile") |

    `dna_to_binary`(*sequence*)[¶](#kpal.klib.Profile.dna_to_binary "Permalink to this definition")
    :   Convert a string of DNA to an integer.

        |  |  |
        | --- | --- |
        | Parameters: | **sequence** ([*str*](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)")) – DNA sequence. |
        | Returns: | Binary representation of sequence. |
        | Return type: | [int](http://docs.python.org/2/library/functions.html#int "(in Python v2.7)") |

    *classmethod* `from_fasta`(*handle*, *length*, *name=None*)[¶](#kpal.klib.Profile.from_fasta "Permalink to this definition")
    :   Create a *k*-mer profile from a FASTA file by counting all *k*-mers in
        each line.

        |  |  |
        | --- | --- |
        | Parameters: | * **handle** (*file-like object*) – Open readable FASTA file handle. * **length** ([*int*](http://docs.python.org/2/library/functions.html#int "(in Python v2.7)")) – Length of the *k*-mers. * **name** ([*str*](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)")) – Profile name. |
        | Returns: | A *k*-mer profile. |
        | Return type: | [Profile](#kpal.klib.Profile "kpal.klib.Profile") |

    *classmethod* `from_fasta_by_record`(*handle*, *length*, *prefix=None*)[¶](#kpal.klib.Profile.from_fasta_by_record "Permalink to this definition")
    :   Create *k*-mer profiles from a FASTA file by counting all *k*-mers per
        record. Profiles are named by the record names.

        |  |  |
        | --- | --- |
        | Parameters: | * **handle** (*file-like object*) – Open readable FASTA file handle. * **length** ([*int*](http://docs.python.org/2/library/functions.html#int "(in Python v2.7)")) – Length of the *k*-mers. * **prefix** ([*str*](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)")) – If provided, the names of the *k*-mer profiles are   prefixed with this. |
        | Returns: | A generator yielding the created *k*-mer profiles. |
        | Return type: | iterator(Profile) |

    *classmethod* `from_file`(*handle*, *name=None*)[¶](#kpal.klib.Profile.from_file "Permalink to this definition")
    :   Load the *k*-mer profile from a file.

        |  |  |
        | --- | --- |
        | Parameters: | * **handle** (*h5py.File*) – Open readable *k*-mer profile file handle. * **name** ([*str*](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)")) – Profile name. |
        | Returns: | A *k*-mer profile. |
        | Return type: | [Profile](#kpal.klib.Profile "kpal.klib.Profile") |

    *classmethod* `from_file_old_format`(*handle*, *name=None*)[¶](#kpal.klib.Profile.from_file_old_format "Permalink to this definition")
    :   Load the *k*-mer profile from a file in the old plaintext format.

        |  |  |
        | --- | --- |
        | Parameters: | * **handle** (*file-like object*) – Open readable *k*-mer profile file handle (old format). * **name** ([*str*](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)")) – Profile name. |
        | Returns: | A *k*-mer profile. |
        | Return type: | [Profile](#kpal.klib.Profile "kpal.klib.Profile") |

    *classmethod* `from_sequences`(*sequences*, *length*, *name=None*)[¶](#kpal.klib.Profile.from_sequences "Permalink to this definition")
    :   Create a *k*-mer profile from sequences by counting all *k*-mers in
        each sequence.

        |  |  |
        | --- | --- |
        | Parameters: | * **sequences** (*iterator(str)*) – An iterable of string sequences. * **length** ([*int*](http://docs.python.org/2/library/functions.html#int "(in Python v2.7)")) – Length of the *k*-mers. * **name** ([*str*](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)")) – Profile name. |
        | Returns: | A *k*-mer profile. |
        | Return type: | [Profile](#kpal.klib.Profile "kpal.klib.Profile") |

    `mean`[¶](#kpal.klib.Profile.mean "Permalink to this definition")
    :   Mean of *k*-mer counts.

    `median`[¶](#kpal.klib.Profile.median "Permalink to this definition")
    :   Median of *k*-mer counts.

    `merge`(*profile*, *merger=<function <lambda>>*)[¶](#kpal.klib.Profile.merge "Permalink to this definition")
    :   Merge two profiles.

        |  |  |
        | --- | --- |
        | Parameters: | * **profile** ([*Profile*](#kpal.klib.Profile "kpal.klib.Profile")) – Another *k*-mer profile. * **merger** (*function*) – A pairwise merge function. |

        Note that function must be vectorized, i.e., it is called directly
        on NumPy arrays, instead of on their pairwise elements. If your
        function only works on individual elements, convert it to a NumPy
        ufunc first. For example:

        ```
        >>> f = np.vectorize(f, otypes=['int64'])
        ```

    `name`[¶](#kpal.klib.Profile.name "Permalink to this definition")
    :   Profile name.

    `non_zero`[¶](#kpal.klib.Profile.non_zero "Permalink to this definition")
    :   Number *k*-mers with a non-zero count.

    `number`[¶](#kpal.klib.Profile.number "Permalink to this definition")
    :   Number of possible *k*-mers with this length.

    `print_counts`()[¶](#kpal.klib.Profile.print_counts "Permalink to this definition")
    :   Print the *k*-mer counts.

    `reverse_complement`(*number*)[¶](#kpal.klib.Profile.reverse_complement "Permalink to this definition")
    :   Calculate the reverse complement of a DNA sequence in a binary
        representation.

        |  |  |
        | --- | --- |
        | Parameters: | **number** ([*int*](http://docs.python.org/2/library/functions.html#int "(in Python v2.7)")) – Binary representation of a DNA sequence. |
        | Returns: | Binary representation of the reverse complement of the sequence corresponding to number. |
        | Return type: | [int](http://docs.python.org/2/library/functions.html#int "(in Python v2.7)") |

    `save`(*handle*, *name=None*)[¶](#kpal.klib.Profile.save "Permalink to this definition")
    :   Save the *k*-mer counts to a file.

        |  |  |
        | --- | --- |
        | Parameters: | * **handle** (*h5py.File*) – Open writeable *k*-mer profile file handle. * **name** ([*str*](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)")) – Profile name in the file. If not provided, the current   profile name is used, or the first available number from 1   consecutively if the profile has no name. |
        | Returns: | Profile name in the file. |
        | Return type: | [str](http://docs.python.org/2/library/functions.html#str "(in Python v2.7)") |

    `shrink`(*factor=1*)[¶](#kpal.klib.Profile.shrink "Permalink to this definition")
    :   Shrink the profile, effectively reducing the value of *k*.

        Note that this operation may give slightly different values than
        counting at a lower *k* directly.

        |  |  |
        | --- | --- |
        | Parameters: | **factor** ([*int*](http://docs.python.org/2/library/functions.html#int "(in Python v2.7)")) – Shrinking factor. |

    `shuffle`()[¶](#kpal.klib.Profile.shuffle "Permalink to this definition")
    :   Randomise the profile.

    `split`()[¶](#kpal.klib.Profile.split "Permalink to this definition")
    :   Split the profile into two lists, every position in the first list has
        its reverse complement in the same position in the second list and
        vice versa. All counts are doubled, so we can equaly distribute
        palindrome counts over both lists.

        Note that the returned counts are not *k*-mer profiles. They can be
        used to show the balance of the original profile by calculating the
        distance between them.

        |  |  |
        | --- | --- |
        | Returns: | The doubled forward and reverse complement counts. |
        | Return type: | numpy.ndarray, numpy.ndarray |

    `std`[¶](#kpal.klib.Profile.std "Permalink to this definition")
    :   Standard deviation of *k*-mer counts.

    `total`[¶](#kpal.klib.Profile.total "Permalink to this definition")
    :   Sum of *k*-mer counts.

## *k*-mer profile distances[¶](#module-kpal.kdistlib "Permalink to this headline")

*class* `kpal.kdistlib.``ProfileDistance`(*do\_balance=False*, *do\_positive=False*, *do\_smooth=False*, *summary=<Mock id='139952132355920'>*, *threshold=0*, *do\_scale=False*, *down=False*, *distance\_function=None*, *pairwise=<function <lambda>>*)[¶](#kpal.kdistlib.ProfileDistance "Permalink to this definition")
:   Class of distance functions.

    `distance`(*left*, *right*)[¶](#kpal.kdistlib.ProfileDistance.distance "Permalink to this definition")
    :   Calculate the distance between two *k*-mer profiles.

        |  |  |
        | --- | --- |
        | Parameters: | **left, right** ([*kpal.klib.Profile*](#kpal.klib.Profile "kpal.klib.Profile")) – Profiles to calculate distance between. |
        | Returns: | The distance between left and right. |
        | Return type: | [float](http://docs.python.org/2/library/functions.html#float "(in Python v2.7)") |

    `dynamic_smooth`(*left*, *right*)[¶](#kpal.kdistlib.ProfileDistance.dynamic_smooth "Permalink to this definition")
    :   Smooth two profiles by collapsing sub-profiles that do not meet the
        requirements governed by the selected summary function and the
        threshold.

        |  |  |
        | --- | --- |
        | Parameters: | **left, right** ([*kpal.klib.Profile*](#kpal.klib.Profile "kpal.klib.Profile")) – Profiles to smooth. |

`kpal.kdistlib.``distance_matrix`(*profiles*, *output*, *precision*, *dist*)[¶](#kpal.kdistlib.distance_matrix "Permalink to this definition")
:   Make a distance matrix for any number of *k*-mer profiles.

    |  |  |
    | --- | --- |
    | Parameters: | * **profiles** (*list(Profile)*) – List of profiles. * **output** (*file-like object*) – Open writable file handle. * **precision** ([*int*](http://docs.python.org/2/library/functions.html#int "(in Python v2.7)")) – Number of digits in the output. * **dist** ([*kpal.kdistlib.ProfileDistance*](#kpal.kdistlib.ProfileDistance "kpal.kdistlib.ProfileDistance")) – A distance functions object. |

## Metrics[¶](#module-kpal.metrics "Permalink to this headline")

General library containing metrics and helper functions.

`kpal.metrics.``cosine_similarity`(*left*, *right*)[¶](#kpal.metrics.cosine_similarity "Permalink to this definition")
:   Calculate the Cosine similarity between two vectors.

    |  |  |
    | --- | --- |
    | Parameters: | **left, right** (*array\_like*) – Vector. |
    | Returns: | The Cosine similarity between left and right. |
    | Return type: | [float](http://docs.python.org/2/library/functions.html#float "(in Python v2.7)") |

`kpal.metrics.``distribution`(*vector*)[¶](#kpal.metrics.distribution "Permalink to this definition")
:   Calculate the distribution of the values in a vector.

    |  |  |
    | --- | --- |
    | Parameters: | **vector** (*iterable(int)*) – A vector. |
    | Returns: | A list of (value, count) pairs. |
    | Return type: | list(int, int) |

`kpal.metrics.``euclidean`(*left*, *right*)[¶](#kpal.metrics.euclidean "Permalink to this definition")
:   Calculate the Euclidean distance between two vectors.

    |  |  |
    | --- | --- |
    | Parameters: | **left, right** (*array\_like*) – Vector. |
    | Returns: | The Euclidean distance between left and right. |
    | Return type: | [float](http://docs.python.org/2/library/functions.html#float "(in Python v2.7)") |

`kpal.metrics.``get_scale`(*left*, *right*)[¶](#kpal.metrics.get_scale "Permalink to this definition")
:   Calculate scaling factors based upon total counts. One of the factors
    is always one (the other is either one or larger than one).

    |  |  |
    | --- | --- |
    | Parameters: | **left, right** (*array\_like*) – A vector. |
    | Returns: | A tuple of scaling factors. |
    | Return type: | float, float |

`kpal.metrics.``mergers` *= {u'int': <function <lambda> at 0x7f4924906320>, u'sum': <function <lambda> at 0x7f4924906230>, u'xor': <function <lambda> at 0x7f49249062a8>, 