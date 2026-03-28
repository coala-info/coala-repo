[xpore](index.html)

latest

* [Installation](installation.html)
* [Quickstart - Detection of differential RNA modifications](quickstart.html)
* [Output table description](outputtable.html)
* Configuration file
* [Data preparation from raw reads](preparation.html)
* [Data](data.html)
* [Command line arguments](cmd.html)
* [Citing xPore](citing.html)
* [Getting Help](help.html)

[xpore](index.html)

* [Docs](index.html) »
* Configuration file
* [Edit on GitHub](https://github.com/GoekeLab/xpore/blob/master/docs/source/configuration.rst)

---

# Configuration file[¶](#configuration-file "Permalink to this headline")

The format of configuration file which is one of the inputs for `xpore-diffmod` is YAML.

Only the `data` and `out` sections are required, other sections are optional. Below is the detail for each section.

```
data:
    <CONDITION_NAME_1>:
        <REP1>: <DIR_PATH_TO_DATA_JSON>
        ...

    <CONDITION_NAME_2>:
        <REP1>: <DIR_PATH_TO_DATA_JSON>
        ...

    ...

out: <DIR_PATH_FOR_OUTPUTS>

criteria:
    readcount_min: <15>
    readcount_max: <1000>

method:
    # To speed up xpore-diffmod, you can use a statistical test (currently only t-test is implemented) can be used
    # to remove positions that are unlikely to be differentially modified. So, xpore-diffmod will model only
    # those significant positions by the statistical test -- usually the P_VALUE_THRESHOLD very high e.g. 0.1.
    # If you want xPore to test every genomic/transcriptomic position, please remove this prefiltering section.
    prefiltering:
        method: t-test
        threshold: <P_VALUE_THRESHOLD>

    # Here are the parameters for Bayesian inference. The default values shown in <> are used, if not specified.
    max_iters: <500>
    stopping_criteria: <0.00001>
```

[Next](preparation.html "Data preparation from raw reads")
 [Previous](outputtable.html "Output table description")

---

© Copyright 2020, Ploy N. Pratanwanich
Revision `3bf7114e`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).