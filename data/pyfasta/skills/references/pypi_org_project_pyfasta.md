[Skip to main content](#content)
Switch to mobile version

Warning
Some features may not work without JavaScript. Please try enabling it if you encounter problems.

[![PyPI](/static/images/logo-small.8998e9d1.svg)](/)

Search PyPI

Search

* [Help](/help/)
* [Docs](https://docs.pypi.org/)
* [Sponsors](/sponsors/)
* [Log in](/account/login/?next=https%3A%2F%2Fpypi.org%2Fproject%2Fpyfasta%2F)
* [Register](/account/register/)

Menu

* [Help](/help/)
* [Docs](https://docs.pypi.org/)
* [Sponsors](/sponsors/)
* [Log in](/account/login/?next=https%3A%2F%2Fpypi.org%2Fproject%2Fpyfasta%2F)
* [Register](/account/register/)

Search PyPI

Search

# pyfasta 0.5.2

pip install pyfasta

Copy PIP instructions

[Latest version](/project/pyfasta/)

Released:
Apr 3, 2014

fast, memory-efficient, pythonic (and command-line) access to fasta sequence files

### Navigation

* [Project description](#description)
* [Release history](#history)
* [Download files](#files)

### Verified details

*These details have been [verified by PyPI](https://docs.pypi.org/project_metadata/#verified-details)*

###### Maintainers

[![Avatar for brentp from gravatar.com](https://pypi-camo.freetls.fastly.net/7b667679ed7ef0782a146cf586ce8cbaf1577704/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f36373361313132636365616638613437313461633663336236616539313639303f73697a653d3530 "Avatar for brentp from gravatar.com")
brentp](/user/brentp/)

### Unverified details

*These details have **not** been verified by PyPI*

###### Project links

* [Homepage](http://github.com/brentp/pyfasta/)

###### Meta

* **License:** MIT
* **Author:** brentp
* Tags

  bioinformatics
  ,

  blast
  ,

  fasta

###### Classifiers

* **Topic**
  + [Scientific/Engineering :: Bio-Informatics](/search/?c=Topic+%3A%3A+Scientific%2FEngineering+%3A%3A+Bio-Informatics)

[Report project as malware](https://pypi.org/project/pyfasta/submit-malware-report/)

* [Project description](#description)
* [Project details](#data)
* [Release history](#history)
* [Download files](#files)

## Project description

Author:
:   Brent Pedersen (brentp)

Email:
:   bpederse@gmail.com

License:
:   MIT

[Contents](#top)

* [Implementation](#implementation)
* [Usage](#usage)

  + [Slicing](#slicing)
  + [Key Function](#key-function)
* [Numpy](#numpy)
* [Backends (Record class)](#backends-record-class)
* [Flattening](#flattening)
* [Command Line Interface](#command-line-interface)
* [cleanup](#cleanup)
* [Testing](#testing)
* [Changes](#changes)

  + [0.5.2](#section-1)
  + [0.5.0](#section-2)
  + [0.4.5](#section-3)
  + [0.4.4](#section-4)
  + [0.4.3](#section-5)
  + [0.4.2](#section-6)
  + [0.4.1](#section-7)
  + [0.4.0](#section-8)
  + [0.3.9](#section-9)
  + [0.3.8](#section-10)
  + [0.3.6/7](#section-11)
  + [0.3.5](#section-12)
  + [0.3.4](#section-13)
  + [0.3.3](#section-14)
  + [0.3.2](#section-15)

## [Implementation](#toc-entry-1)

Requires Python >= 2.6. Stores a flattened version of the fasta file without
spaces or headers and uses either a mmap of numpy binary format or fseek/fread so the
*sequence data is never read into memory*. Saves a pickle (.gdx) of the start, stop
(for fseek/mmap) locations of each header in the fasta file for internal use.

## [Usage](#toc-entry-2)

```
>>> from pyfasta import Fasta

>>> f = Fasta('tests/data/three_chrs.fasta')
>>> sorted(f.keys())
['chr1', 'chr2', 'chr3']

>>> f['chr1']
NpyFastaRecord(0..80)
```

### [Slicing](#toc-entry-3)

```
# get full the sequence:
>>> a = str(f['chr1'])
>>> b = f['chr1'][:]
>>> a == b
True

>>> f['chr1'][:10]
'ACTGACTGAC'

# get the 1st basepair in every codon (it's python yo)
>>> f['chr1'][::3]
'AGTCAGTCAGTCAGTCAGTCAGTCAGT'

# can query by a 'feature' dictionary (note this is one based coordinates)
>>> f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9})
'CTGACTGA'

# same as:
>>> f['chr1'][1:9]
'CTGACTGA'

# use python, zero based coords
>>> f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9}, one_based=False)
'TGACTGA'

# with reverse complement (automatic for - strand)
>>> f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9, 'strand': '-'})
'TCAGTCAG'
```

### [Key Function](#toc-entry-4)

Sometimes your fasta will have a long header like: “AT1G51370.2 | Symbols: | F-box family protein | chr1:19045615-19046748 FORWARD” when you only want to key off: “AT1G51370.2”. In this case, specify the key\_fn argument to the constructor:

```
>>> fkey = Fasta('tests/data/key.fasta', key_fn=lambda key: key.split()[0])
>>> sorted(fkey.keys())
['a', 'b', 'c']
```

## [Numpy](#toc-entry-5)

The default is to use a memmaped numpy array as the backend. In which case it’s possible to
get back an array directly…

```
>>> f['chr1'].as_string = False
>>> f['chr1'][:10] # doctest: +NORMALIZE_WHITESPACE
memmap(['A', 'C', 'T', 'G', 'A', 'C', 'T', 'G', 'A', 'C'], dtype='|S1')

>>> import numpy as np
>>> a = np.array(f['chr2'])
>>> a.shape[0] == len(f['chr2'])
True

>>> a[10:14] # doctest: +NORMALIZE_WHITESPACE
array(['A', 'A', 'A', 'A'], dtype='|S1')
```

mask a sub-sequence

```
>>> a[11:13] = np.array('N', dtype='S1')
>>> a[10:14].tostring()
'ANNA'
```

## [Backends (Record class)](#toc-entry-6)

It’s also possible to specify another record class as the underlying work-horse
for slicing and reading. Currently, there’s just the default:

> * NpyFastaRecord which uses numpy memmap
> * FastaRecord, which uses using fseek/fread
> * MemoryRecord which reads everything into memory and must reparse the original
>   fasta every time.
> * TCRecord which is identical to NpyFastaRecord except that it saves the index
>   in a TokyoCabinet hash database, for cases when there are enough records that
>   loading the entire index from a pickle into memory is unwise. (NOTE: that the
>   sequence is not loaded into memory in either case).

It’s possible to specify the class used with the record\_class kwarg to the Fasta
constructor:

```
>>> from pyfasta import FastaRecord # default is NpyFastaRecord
>>> f = Fasta('tests/data/three_chrs.fasta', record_class=FastaRecord)
>>> f['chr1']
FastaRecord('tests/data/three_chrs.fasta.flat', 0..80)
```

other than the repr, it should behave exactly like the Npy record class backend

it’s possible to create your own using a sub-class of FastaRecord. see the source
in pyfasta/records.py for details.

## [Flattening](#toc-entry-7)

In order to efficiently access the sequence content, pyfasta saves a separate, flattened file with all newlines and headers removed from the sequence. In the case of large fasta files, one may not wish to save 2 copies of a 5GG+ file. In that case, it’s possible to flatten the file “inplace”, keeping all the headers, and retaining the validity of the fasta file – with the only change being that the new-lines are removed from each sequence. This can be specified via flatten\_inplace = True

```
>>> import os
>>> os.unlink('tests/data/three_chrs.fasta.gdx') # cleanup non-inplace idx
>>> f = Fasta('tests/data/three_chrs.fasta', flatten_inplace=True)
>>> f['chr1']  # note the difference in the output from above.
NpyFastaRecord(6..86)

# sequence from is same as when requested from non-flat file above.
>>> f['chr1'][1:9]
'CTGACTGA'

# the flattened file is kept as a place holder without the sequence data.
>>> open('tests/data/three_chrs.fasta.flat').read()
'@flattened@'
```

## [Command Line Interface](#toc-entry-8)

there’s also a command line interface to manipulate / view fasta files.
the pyfasta executable is installed via setuptools, running it will show
help text.

split a fasta file into 6 new files of relatively even size:

> $ pyfasta **split** -n 6 original.fasta

split the fasta file into one new file per header with “%(seqid)s” being filled into each filename.:

> $ pyfasta **split** –header “%(seqid)s.fasta” original.fasta

create 1 new fasta file with the sequence split into 10K-mers:

> $ pyfasta **split** -n 1 -k 10000 original.fasta

2 new fasta files with the sequence split into 10K-mers with 2K overlap:

> $ pyfasta **split** -n 2 -k 10000 -o 2000 original.fasta

show some info about the file (and show gc content):

> $ pyfasta **info** –gc test/data/three\_chrs.fasta

**extract** sequence from the file. use the header flag to make
a new fasta file. the args are a list of sequences to extract.

> $ pyfasta **extract** –header –fasta test/data/three\_chrs.fasta seqa seqb seqc

**extract** sequence from a file using a file containing the headers *not* wanted in the new file:

> $ pyfasta extract –header –fasta input.fasta –exclude –file seqids\_to\_exclude.txt

**extract** sequence from a fasta file with complex keys where we only want to lookup based on the part before the space.

> $ pyfasta extract –header –fasta input.with.keys.fasta –space –file seqids.txt

**flatten** a file inplace, for faster later use by pyfasta, and without creating another copy. ([Flattening](#flattening))

> $ pyfasta flatten input.fasta

## [cleanup](#toc-entry-9)

(though for real use these will remain for faster access)

```
>>> os.unlink('tests/data/three_chrs.fasta.gdx')
>>> os.unlink('tests/data/three_chrs.fasta.flat')
```

## [Testing](#toc-entry-10)

there is currently > 99% test coverage for the 2 modules and all included
record classes. to run the tests:

```
$ python setup.py nosetests
```

## [Changes](#toc-entry-11)

### [0.5.2](#toc-entry-12)

fix complement (@mruffalo)

### [0.5.0](#toc-entry-13)

python 3 compatibility thanks to mruffalo

### [0.4.5](#toc-entry-14)

pyfasta split can handle > 52 files. (thanks Devtulya)

### [0.4.4](#toc-entry-15)

fix pyfasta extract

### [0.4.3](#toc-entry-16)

Add 0 or 1-based intervals in sequence() thanks @jamescasbon

### [0.4.2](#toc-entry-17)

update for latest numpy (can’t close memmap)

### [0.4.1](#toc-entry-18)

check for duplicate headers.

### [0.4.0](#toc-entry-19)

* add key\_fn kwarg to constuctor

### [0.3.9](#toc-entry-20)

* only require ‘r’ (not r+) for memory map.

### [0.3.8](#toc-entry-21)

* clean up logic for mixing inplace/non-inplace flattened files.
  if the inplace is available, it is always used.

### [0.3.6/7](#toc-entry-22)

* dont re-flatten the file every time!
* allow spaces before and after the header in the orginal fasta.

### [0.3.5](#toc-entry-23)

* update docs in README.txt for new CLI stuff.
* allow flattening inplace.
* get rid of memmap (results in faster parsing).

### [0.3.4](#toc-entry-24)

* restore python2.5 compatiblity.
* CLI: add ability to exclude sequence from extract
* CLI: allow spliting based on header.

### [0.3.3](#toc-entry-25)

* include this file in the tar ball (thanks wen h.)

### [0.3.2](#toc-entry-26)

* separate out backends into records.py
* use nosetests (python setup.py nosetests)
* add a TCRecord backend for next-gen sequencing availabe if tc is (easy-)installed.
* improve test coverage.

## Project details

### Verified details

*These details have been [verified by PyPI](https://docs.pypi.org/project_metadata/#verified-details)*

###### Maintainers

[![Avatar for brentp from gravatar.com](https://pypi-camo.freetls.fastly.net/7b667679ed7ef0782a146cf586ce8cbaf1577704/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f36373361313132636365616638613437313461633663336236616539313639303f73697a653d3530 "Avatar for brentp from gravatar.com")
brentp](/user/brentp/)

### Unverified details

*These details have **not** been verified by PyPI*

###### Project links

* [Homepage](http://github.com/brentp/pyfasta/)

###### Meta

* **License:** MIT
* **Author:** brentp
* Tags

  bioinformatics
  ,

  blast
  ,

  fasta

###### Classifiers

* **Topic**
  + [Scientific/Engineering :: Bio-Informatics](/search/?c=Topic+%3A%3A+Scientific%2FEngineering+%3A%3A+Bio-Informatics)

## Release history [Release notifications](/help/#project-release-notifications) | [RSS feed](/rss/project/pyfasta/releases.xml)

This version

![](https://pypi.org/static/images/blue-cube.572a5bfb.svg)

[0.5.2

Apr 3, 2014](/project/pyfasta/0.5.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.5.1

Oct 3, 2013](/project/pyfasta/0.5.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.5.0

Aug 29, 2013](/project/pyfasta/0.5.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.5

Feb 21, 2012](/project/pyfasta/0.4.5/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.4

Oct 12, 2011](/project/pyfasta/0.4.4/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.3

May 31, 2011](/project/pyfasta/0.4.3/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.2

Apr 5, 2011](/project/pyfasta/0.4.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.1

Dec 1, 2010](/project/pyfasta/0.4.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.0

Oct 25, 2010](/project/pyfasta/0.4.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.9

Mar 17, 2010](/project/pyfasta/0.3.9/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.7

Dec 21, 2009](/project/pyfasta/0.3.7/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.6

Dec 21, 2009](/project/pyfasta/0.3.6/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.5

Dec 20, 2009](/project/pyfasta/0.3.5/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.4

Dec 15, 2009](/project/pyfasta/0.3.4/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.3

Dec 6, 2009](/project/pyfasta/0.3.3/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.2

Dec 3, 2009](/project/pyfasta/0.3.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.1

Nov 17, 2009](/project/pyfasta/0.3.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.0

Nov 17, 2009](/project/pyfasta/0.3.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.9

Nov 10, 2009](/project/pyfasta/0.2.9/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.8

Nov 6, 2009](/project/pyfasta/0.2.8/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.5

Sep 23, 2009](/project/pyfasta/0.2.5/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.4

Sep 9, 2009](/project/pyfasta/0.2.4/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.3

Sep 8, 2009](/project/pyfasta/0.2.3/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.2

Sep 8, 2009](/project/pyfasta/0.2.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.1

Jul 13, 2009](/project/pyfasta/0.2.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2

Jul 13, 2009](/project/pyfasta/0.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.1

May 27, 2009](/project/pyfasta/0.1/)

## Download files

Download the file for your platform. If you're not sure which to choose, learn more about [installing packages](https://packaging.python.org/tutorials/installing-packages/ "External lin