[genomepy](../index.html)

* [Home](../index.html)
* [Installation](installation.html)
* [Command line documentation](command_line.html)
* [Python API documentation (core)](api_core.html)
* [Python API documentation (full)](../_autosummary/genomepy.html)
* [Configuration](config.html)
* FAQ
  + [Frequently Asked Questions](#id1)
    - [Provider is offline](#provider-is-offline)
    - [This genome is missing](#this-genome-is-missing)
    - [This genome is STILL missing/URL is broken](#this-genome-is-still-missing-url-is-broken)
    - [The genomepy config was corrupted](#the-genomepy-config-was-corrupted)
    - [What’s genomepy maximum memory usage?](#what-s-genomepy-maximum-memory-usage)
    - [Which genome/gene annotation to use](#which-genome-gene-annotation-to-use)
* [About](about.html)

[genomepy](../index.html)

* Frequently Asked Questions
* [Edit on GitHub](https://github.com/vanheeringen-lab/genomepy/blob/develop/docs/content/help_faq.rst)

---

# Frequently Asked Questions[](#frequently-asked-questions "Permalink to this heading")

## Frequently Asked Questions[](#id1 "Permalink to this heading")

Genomepy utilizes external databases to obtain your files.
Unfortunately this sometimes causes issues.
Here are some of the more common issues, with solutions.

Let us know if you encounter issues you cannot solve by creating [a new issue](https://github.com/vanheeringen-lab/genomepy/issues).

### Provider is offline[](#provider-is-offline "Permalink to this heading")

Occasionally one of the providers experience connection issues, which can last anywhere between minutes to hours.
When this happens genomepy will warn that the provider appears offline, or that the URL seems broken.

If the issue does not pass, you can try to reset genomepy.
Simply run `genomepy clean` on the command line, or run `genomepy.clean()` in Python.

### This genome is missing[](#this-genome-is-missing "Permalink to this heading")

Genomepy stores provider data on your computer to rerun it faster later.
If a provider was offline during this time, it may miss (parts of) the data.

To re-download the data, remove the local data with `genomepy clean`, then `search` for your genome again.

### This genome is STILL missing/URL is broken[](#this-genome-is-still-missing-url-is-broken "Permalink to this heading")

Sadly, not everything (naming, structure, filenames) is always consistent on the provider end.
Contact the provider to get it fixed!
One notable group are Ensembl fungi, which seems to be mostly mislabelled.

In the meantime, you can still use the power of genomepy by manually retrieving the URLs,
and downloading the files with `genomepy install GENOME_URL -p url --url-to-annotation ANNOTATION_URL`.

### The genomepy config was corrupted[](#the-genomepy-config-was-corrupted "Permalink to this heading")

You can create a new one with `genomepy config generate` on command line,
or `genomepy.manage_config("generate")` in Python.

### What’s genomepy maximum memory usage?[](#what-s-genomepy-maximum-memory-usage "Permalink to this heading")

Genomepy does not read a genome fully into memory.
Therefore, installing takes less than 1 GB RAM regardless of the genome’s size.
Searching NCBI is the most costly operation, using around 3 GB (the first time).

### Which genome/gene annotation to use[](#which-genome-gene-annotation-to-use "Permalink to this heading")

Each provider has its pros and cons:

* Ensembl has excellent gene annotations, but their chromosome names can cause issues with some tools.
* UCSC has an excellent genome browser, but their gene annotations vary in format.
* NCBI allows public submissions, and so has the latest versions, although not always complete or error free.

[Previous](config.html "Configuration")
[Next](about.html "About")

---

© Copyright Siebren Frölich, Maarten van der Sande, Tilman Schäfers and Simon van Heeringen.
Last updated on 2025-09-30, 12:32 (UTC).

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).