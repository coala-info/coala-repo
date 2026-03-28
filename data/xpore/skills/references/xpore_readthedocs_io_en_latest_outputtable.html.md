[xpore](index.html)

latest

* [Installation](installation.html)
* [Quickstart - Detection of differential RNA modifications](quickstart.html)
* Output table description
* [Configuration file](configuration.html)
* [Data preparation from raw reads](preparation.html)
* [Data](data.html)
* [Command line arguments](cmd.html)
* [Citing xPore](citing.html)
* [Getting Help](help.html)

[xpore](index.html)

* [Docs](index.html) »
* Output table description
* [Edit on GitHub](https://github.com/GoekeLab/xpore/blob/master/docs/source/outputtable.rst)

---

# Output table description[¶](#output-table-description "Permalink to this headline")

| Column name | Description |
| --- | --- |
| id | transcript or gene id |
| position | transcript or gene position |
| kmer | 5-mer where modified base sits in the middle if modified |
| diff\_mod\_rate\_<condition1>\_vs\_<condition2> | differential modification rate between condition1 and condition2 (modification rate of condition1 - modification rate of condition2) |
| z\_score\_<condition1>\_vs\_<condition2> | z score obtained from z-test of the differential modification rate |
| pval\_<condition1>\_vs\_<condition2> | significance level from z-test of the differential modification rate |
| mod\_rate\_<condition>-<replicate> | modification rate of a replicate in the condition |
| mu\_unmod | inferred mean of the unmodified RNAs distribution |
| mu\_mod | inferred mean of the modified RNAs distribution |
| sigma2\_unmod | inferred sigma^2 of the unmodified RNAs distribution |
| sigma2\_mod | inferred sigma^2 of the modified RNAs distribution |
| conf\_mu\_unmod | confidence level of mu\_unmod compared to the unmodified reference signal |
| conf\_mu\_mod | confidence level of mu\_unmod compared to the unmodified reference signal |
| mod\_assignment | lower if mu\_mod < mu\_unmod and higher if mu\_mod > mu\_unmod |

[Next](configuration.html "Configuration file")
 [Previous](quickstart.html "Quickstart - Detection of differential RNA modifications")

---

© Copyright 2020, Ploy N. Pratanwanich
Revision `3bf7114e`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).