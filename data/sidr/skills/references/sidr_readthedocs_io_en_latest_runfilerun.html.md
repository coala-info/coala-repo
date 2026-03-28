[SIDR](index.html)

latest

* [Installing SIDR](install.html)
* [Data Preparation](dataprep.html)
* [Running With Raw Input](rundefault.html)
* Running With a Runfile
* [Runfile Example](runfileexample.html)

[SIDR](index.html)

* [Docs](index.html) »
* Running With a Runfile
* [Edit on GitHub](https://github.com/damurdock/SIDR/blob/master/docs/runfilerun.rst)

---

# Running With a Runfile[¶](#running-with-a-runfile "Permalink to this headline")

SIDR can take a “runfile” with pre-computed variables as input. The runfile should be a comma delimited file starting with a header row. A column named “ID” which contains the contigID must exist, along with an “Origin” column with the name of the organism identified by BLAST for contigs where one was found. All other columns are used as variables for the decision tree, except any titled “Covered\_bases”, “Plus\_reads”, or “Minus\_reads” as those are present in BBMap default output yet should not contribute to model construction.

To run SIDR in runfile mode, enter a command like:

```
sidr runfile -d [taxdump path] \
-i [runfile path] \
-k tokeep.contigids \
-x toremove.contigids \
-t [target phylum]
```

[Next](runfileexample.html "Runfile Example")
 [Previous](rundefault.html "Running With Raw Input")

---

© Copyright 2017, Duncan Murdock.
Revision `37d56e54`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).