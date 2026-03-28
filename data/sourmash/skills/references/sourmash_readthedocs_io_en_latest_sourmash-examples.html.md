# Some sourmash command line examples![¶](#Some-sourmash-command-line-examples! "Link to this heading")

[sourmash](https://sourmash.readthedocs.io/en/latest/) is research software from the Lab for Data Intensive Biology at UC Davis. It implements MinHash and modulo hash.

Below are some examples of using sourmash. They are computed in a Jupyter Notebook so you can run them yourself if you like!

Sourmash works on *signature files*, which are just saved collections of hashes.

Let’s try it out!

## Running this notebook.[¶](#Running-this-notebook. "Link to this heading")

You can run this notebook interactively via mybinder; click on this button: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dib-lab/sourmash/latest?labpath=doc%2Fsourmash-examples.ipynb)

A rendered version of this notebook is available at [sourmash.readthedocs.io](https://sourmash.readthedocs.io) under “Tutorials and notebooks”.

You can also get this notebook from the [doc/ subdirectory of the sourmash github repository](https://github.com/dib-lab/sourmash/tree/latest/doc). See [binder/environment.yaml](https://github.com/dib-lab/sourmash/blob/latest/binder/environment.yml) for installation dependencies.

## What is this?[¶](#What-is-this? "Link to this heading")

This is a Jupyter Notebook using Python 3. If you are running this via [binder](https://mybinder.org), you can use Shift-ENTER to run cells, and double click on code cells to edit them.

Contact: C. Titus Brown, ctbrown@ucdavis.edu. Please [file issues on GitHub](https://github.com/dib-lab/sourmash/issues/) if you have any questions or comments!

### Compute scaled signatures[¶](#Compute-scaled-signatures "Link to this heading")

```
[1]:
```

```
!rm -f *.sig
!sourmash sketch dna -p k=21,k=31,k=51,scaled=1000 genomes/*.fa --name-from-first -f
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

computing signatures for files: genomes/akkermansia.fa, genomes/shew_os185.fa, genomes/shew_os223.fa
Computing a total of 1 signature(s).
... reading sequences from genomes/akkermansia.fa
calculated 1 signatures for 1 sequences in genomes/akkermansia.fa
saved signature(s) to akkermansia.fa.sig. Note: signature license is CC0.
... reading sequences from genomes/shew_os185.fa
calculated 1 signatures for 1 sequences in genomes/shew_os185.fa
saved signature(s) to shew_os185.fa.sig. Note: signature license is CC0.
... reading sequences from genomes/shew_os223.fa
calculated 1 signatures for 1 sequences in genomes/shew_os223.fa
saved signature(s) to shew_os223.fa.sig. Note: signature license is CC0.
```

This outputs three signature files, each containing three signatures (one calculated at k=21, one at k=31, and one at k=51).

```
[2]:
```

```
ls *.sig
```

```
akkermansia.fa.sig  shew_os185.fa.sig   shew_os223.fa.sig
```

We can now use these signature files for various comparisons.

### Search multiple signatures with a query[¶](#Search-multiple-signatures-with-a-query "Link to this heading")

The below command queries all of the signature files in the directory with the `shew_os223` signature and finds the best Jaccard similarity:

```
[3]:
```

```
!sourmash search -k 31 shew_os223.fa.sig *.sig
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

selecting specified query k=31
loaded query: NC_011663.1 Shewanella baltica... (k=31, DNA)
loaded 3 signatures.

2 matches:
similarity   match
----------   -----
100.0%       NC_011663.1 Shewanella baltica OS223, complete genome
 22.8%       NC_009665.1 Shewanella baltica OS185, complete genome
```

The below command uses Jaccard containment instead of Jaccard similarity:

```
[4]:
```

```
!sourmash search -k 31 shew_os223.fa.sig *.sig --containment
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

selecting specified query k=31
loaded query: NC_011663.1 Shewanella baltica... (k=31, DNA)
loaded 3 signatures.

2 matches:
similarity   match
----------   -----
100.0%       NC_011663.1 Shewanella baltica OS223, complete genome
 37.3%       NC_009665.1 Shewanella baltica OS185, complete genome
```

### Performing all-by-all queries[¶](#Performing-all-by-all-queries "Link to this heading")

We can also compare all three signatures:

```
[5]:
```

```
!sourmash compare -k 31 *.sig
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

loaded 1 sigs from 'akkermansia.fa.sig'g'
loaded 1 sigs from 'shew_os185.fa.sig'g'
loaded 1 sigs from 'shew_os223.fa.sig'g'
loaded 3 signatures total.

0-CP001071.1 Akke...    [1. 0. 0.]
1-NC_009665.1 She...    [0.    1.    0.228]
2-NC_011663.1 She...    [0.    0.228 1.   ]
min similarity in matrix: 0.000
```

…and produce a similarity matrix that we can use for plotting:

```
[6]:
```

```
!sourmash compare -k 31 *.sig -o genome_compare.mat
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

loaded 1 sigs from 'akkermansia.fa.sig'g'
loaded 1 sigs from 'shew_os185.fa.sig'g'
loaded 1 sigs from 'shew_os223.fa.sig'g'
loaded 3 signatures total.

0-CP001071.1 Akke...    [1. 0. 0.]
1-NC_009665.1 She...    [0.    1.    0.228]
2-NC_011663.1 She...    [0.    0.228 1.   ]
min similarity in matrix: 0.000
saving labels to: genome_compare.mat.labels.txt
saving comparison matrix to: genome_compare.mat
```

```
[7]:
```

```
!sourmash plot genome_compare.mat

from IPython.display import Image
Image(filename='genome_compare.mat.matrix.png')
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

loading comparison matrix from genome_compare.mat...
...got 3 x 3 matrix.
loading labels from genome_compare.mat.labels.txt
saving histogram of matrix values => genome_compare.mat.hist.png
wrote dendrogram to: genome_compare.mat.dendro.png
wrote numpy distance matrix to: genome_compare.mat.matrix.png
0       CP001071.1 Akkermansia muciniphila ATCC BAA-835, complete genome
1       NC_009665.1 Shewanella baltica OS185, complete genome
2       NC_011663.1 Shewanella baltica OS223, complete genome
```

```
[7]:
```

![_images/sourmash-examples_14_1.png](_images/sourmash-examples_14_1.png)

and for the R aficionados, you can output a CSV version of the matrix:

```
[8]:
```

```
!sourmash compare -k 31 *.sig --csv genome_compare.csv
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

loaded 1 sigs from 'akkermansia.fa.sig'g'
loaded 1 sigs from 'shew_os185.fa.sig'g'
loaded 1 sigs from 'shew_os223.fa.sig'g'
loaded 3 signatures total.

0-CP001071.1 Akke...    [1. 0. 0.]
1-NC_009665.1 She...    [0.    1.    0.228]
2-NC_011663.1 She...    [0.    0.228 1.   ]
min similarity in matrix: 0.000
```

```
[9]:
```

```
!cat genome_compare.csv
```

```

```

This is now a file that you can load into R and examine - see [our documentation](https://sourmash.readthedocs.io/en/latest/other-languages.html) on that.

### working with metagenomes[¶](#working-with-metagenomes "Link to this heading")

Let’s make a fake metagenome:

```
[10]:
```

```
!rm -f fake-metagenome.fa*
!cat genomes/*.fa > fake-metagenome.fa
!sourmash sketch dna -p k=31,scaled=1000 fake-metagenome.fa
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

computing signatures for files: fake-metagenome.fa
Computing a total of 1 signature(s).
... reading sequences from fake-metagenome.fa
calculated 1 signatures for 3 sequences in fake-metagenome.fa
saved signature(s) to fake-metagenome.fa.sig. Note: signature license is CC0.
```

We can use the `sourmash gather` command to see what’s in it:

```
[11]:
```

```
!sourmash gather fake-metagenome.fa.sig shew*.sig akker*.sig
```

```
== This is sourmash version 4.0.0a4.dev12+g31c5eda2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

select query k=31 automatically.
loaded query: fake-metagenome.fa... (k=31, DNA)
loaded 3 signatures.

overlap     p_query p_match
---------   ------- -------
499.0 kbp     38.4%  100.0%    CP001071.1 Akkermansia muciniphila AT...
494.0 kbp     38.0%  100.0%    NC_009665.1 Shewanella baltica OS185,...
490.0 kbp     23.6%   62.7%    NC_011663.1 Shewanella baltica OS223,...

found 3 matches total;
the recovered matches hit 100.0% of the query
```

### Other pointers[¶](#Other-pointers "Link to this heading")

[Sourmash: a practical guide](https://sourmash.readthedocs.io/en/latest/using-sourmash-a-guide.html)

[Classifying signatures taxonomically](https://sourmash.readthedocs.io/en/latest/classifying-signatures.html)

[Pre-built search databases](https://sourmash.readthedocs.io/en/latest/databases.html)

### A full list of notebooks[¶](#A-full-list-of-notebooks "Link to this heading")

[An introduction to k-mers for genome comparison and analysis](kmers-and-minhash.html)

Some sourmash command line examples!

[Working with private collections of signatures.](sourmash-collections.html)

[Using the LCA\_Database API.](using-LCA-database-API.html)

```
[ ]:
```

```

```

[![Logo](_static/logo.png)

# sourmash](index.html)

Quickly search, compare, and analyze genomic and metagenomic data sets

### Navigation

* [Tutorials and examples](sidebar.html)
* [How-To Guides](sidebar.html#how-to-guides)
* [Frequently Asked Questions](sidebar.html#frequently-asked-questions)
* [How sourmash works under the hood](sidebar.html#how-sourmash-works-under-the-hood)
* [Reference material](sidebar.html#reference-material)
* [Developing and extending sourmash](sidebar.html#developing-and-extending-sourmash)
* [Full table of contents for all docs](sidebar.html#full-table-of-contents-for-all-docs)
* [Using sourmash from the command line](command-line.html)
* [Prepared databases](databases.html)
* [`sourmash` Python API examples](api-example.html)
* [How to cite sourmash](cite.html)

### Related Topics

* [Documentation overview](index.html)

### This Page

* [Show Source](_sources/sourmash-examples.ipynb.txt)

### Quick search

©2016-2023, C. Titus Brown, Luiz Irber, and N. Tessa Pierce-Ward.
|
Powered by [Sphinx 9.0.4](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](_sources/sourmash-examples.ipynb.txt)