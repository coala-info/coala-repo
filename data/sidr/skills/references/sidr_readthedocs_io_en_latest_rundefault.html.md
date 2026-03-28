[SIDR](index.html)

latest

* [Installing SIDR](install.html)
* [Data Preparation](dataprep.html)
* Running With Raw Input
* [Running With a Runfile](runfilerun.html)
* [Runfile Example](runfileexample.html)

[SIDR](index.html)

* [Docs](index.html) »
* Running With Raw Input
* [Edit on GitHub](https://github.com/damurdock/SIDR/blob/master/docs/rundefault.rst)

---

# Running With Raw Input[¶](#running-with-raw-input "Permalink to this headline")

By default, SIDR will analyse your data and construct a Decision Tree model based on the GC content and average coverage of your contigs. Before running SIDR, you will need to prepare some data based on your input. This is described here: [Data Preparation](dataprep.html#dataprep)

To run SIDR with the default settings on raw data, enter a command like:

```
sidr default -d [taxdump path] \
-b [bamfile] \
-f [assembly FASTA] \
-r [BLAST results] \
-k tokeep.contigids \
-x toremove.contigids \
-t [target phylum]
```

[Next](runfilerun.html "Running With a Runfile")
 [Previous](dataprep.html "Data Preparation")

---

© Copyright 2017, Duncan Murdock.
Revision `37d56e54`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).