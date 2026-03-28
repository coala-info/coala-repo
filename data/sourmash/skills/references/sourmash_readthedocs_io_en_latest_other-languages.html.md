# Using `sourmash` output with R and other languages[¶](#using-sourmash-output-with-r-and-other-languages "Link to this heading")

Most of the sourmash shell commands output CSV files upon request;
these files have headers and are straightforward to load into R.
Below are some code snippets and links that might be useful.

## R code for working with compare output[¶](#r-code-for-working-with-compare-output "Link to this heading")

(by Taylor Reiter)

`sourmash compare` can output matrices in a CSV format, which can
easily be read into R. For example, if you download the Eschericia
signature collection as in
[the sourmash tutorial](tutorial-basic.html#make-and-search-a-database-quickly),
then the shell command

```
sourmash compare ecoli_many_sigs/*.sig --csv ecoli.cmp.csv
```

will output a file `ecoli.cmp.csv` that can be loaded into R like so:

```
sourmash_comp_matrix <- read.csv("ecoli.cmp.csv")

# Label the rows
rownames(sourmash_comp_matrix) <- colnames(sourmash_comp_matrix)

# Transform for plotting
sourmash_comp_matrix <- as.matrix(sourmash_comp_matrix)
```

See the output of plotting and clustering this matrix by downloading and opening [this html](https://raw.githubusercontent.com/sourmash-bio/sourmash/latest/doc/_static/ecoli-cmp.html), produced by [this RMarkdown file](https://raw.githubusercontent.com/sourmash-bio/sourmash/latest/doc/_static/ecoli-cmp.Rmd).

You can download the `ecoli.cmp.csv` file itself [here](https://raw.githubusercontent.com/sourmash-bio/sourmash/latest/doc/_static/ecoli.cmp.csv).

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

* [Show Source](_sources/other-languages.md.txt)

### Quick search

©2016-2023, C. Titus Brown, Luiz Irber, and N. Tessa Pierce-Ward.
|
Powered by [Sphinx 9.0.4](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](_sources/other-languages.md.txt)