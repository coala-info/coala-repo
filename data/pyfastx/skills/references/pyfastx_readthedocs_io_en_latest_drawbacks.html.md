[pyfastx](index.html)

Contents:

* [Installation](installation.html)
* [FASTX](usage.html)
* [FASTA](usage.html#fasta)
* [Sequence](usage.html#sequence)
* [FASTQ](usage.html#fastq)
* [Read](usage.html#read)
* [FastaKeys](usage.html#fastakeys)
* [FastqKeys](usage.html#fastqkeys)
* [Command line interface](commandline.html)
* [Multiple processes](advance.html)
* Drawbacks
* [Changelog](changelog.html)
* [API Reference](api_reference.html)
* [Acknowledgements](acknowledgements.html)

[pyfastx](index.html)

* Drawbacks
* [View page source](_sources/drawbacks.rst.txt)

---

# Drawbacks[](#drawbacks "Link to this heading")

If you intensively check sequence names exists in FASTA file using `in` operator on FASTA object like:

```
>>> fa = pyfastx.Fasta('tests/data/test.fa.gz')
>>> # Suppose seqnames has 100000 names
>>> for seqname in seqnames:
>>>     if seqname in fa:
>>>             do something
```

This will take a long time to finish. Because, pyfastx does not load the index into memory, the `in` operating is corresponding to sql query existence from index database. The faster alternative way to do this is:

```
>>> fa = pyfastx.Fasta('tests/data/test.fa.gz')
>>> # load all sequence names into a set object
>>> all_names = set(fa.keys())
>>> for seqname in seqnames:
>>>     if seqname in all_names:
>>>             do something
```

[Previous](advance.html "Multiple processes")
[Next](changelog.html "Changelog")

---

© Copyright 2023, Lianming Du.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).