[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicMergeToSCool
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicMergeToSCool.rst)

---

# scHicMergeToSCool[¶](#schicmergetoscool "Permalink to this headline")

Creates out of n cool files one scool file.

```
usage: scHicMergeToSCool --matrices MATRICES [MATRICES ...] --outFileName
                         OUTFILENAME [--threads THREADS] [--help] [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrices, -m`
:   input file(s).

`--outFileName, -o`
:   File name to save the exported matrix.

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).