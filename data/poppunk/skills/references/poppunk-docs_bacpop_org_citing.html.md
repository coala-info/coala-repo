Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[PopPUNK 2.7.0 documentation](index.html)

[![Logo](_static/poppunk_v2.png)

PopPUNK 2.7.0 documentation](index.html)

Contents:

* [PopPUNK documentation](index.html)
* [Installation](installation.html)
* [Overview](overview.html)
* [Sketching (`--create-db`)](sketching.html)
* [Data quality control (`--qc-db`)](qc.html)
* [Fitting new models (`--fit-model`)](model_fitting.html)
* [Distributing PopPUNK models](model_distribution.html)
* [Query assignment (`poppunk_assign`)](query_assignment.html)
* [Creating visualisations](visualisation.html)
* [Minimum spanning trees](mst.html)
* [Subclustering with PopPIPE](subclustering.html)
* [Using GPUs](gpu.html)
* [Troubleshooting](troubleshooting.html)
* [Scripts](scripts.html)
* [Iterative PopPUNK](poppunk_iterate.html)
* Citing PopPUNK
* [Reference documentation](api.html)
* [Roadmap](roadmap.html)
* [Miscellaneous](miscellaneous.html)

Back to top

[View this page](_sources/citing.rst.txt "View this page")

# Citing PopPUNK[¶](#citing-poppunk "Link to this heading")

If you use PopPUNK, PopPIPE or pp-sketchlib in a scientific paper, we would appreciate
a citation. As a minimum, please cite the following paper(s):

Lees JA, Harris SR, Tonkin-Hill G, Gladstone RA, Lo SW, Weiser JN, Corander J, Bentley SD, Croucher NJ. Fast and flexible
bacterial genomic epidemiology with PopPUNK. *Genome Research* **29**:1-13 (2019).
doi:[10.1101/gr.241455.118](https://dx.doi.org/10.1101/gr.241455.118)

## Generating citations and methods[¶](#generating-citations-and-methods "Link to this heading")

You can add `--citation` to your PopPUNK command to generate a full list of papers
to cite. This will also produce a basic methods paragraph for you to edit and include. You
can do this after running `poppunk_assign` or `poppunk --fit-model`:

```
poppunk --citation --fit-model bgmm --ref-db example_db --K 4
```

gives:

> We built a database of 28 isolates using pp-sketchlib version 1.7.0 (doi:10.5281/zenodo.4531418)
> with sketch version 88ee3ff83ba294c928505f991e20078691ed090e, k-mer lengths 13-28, a sketch size of 9984 and dense seeds [6-8].
> We assigned variable-length-k-mer clusters (VLKCs) using PopPUNK version 2.4.0
> (doi:10.1101/gr.241455.118) by fitting a BGMM with 4 components [1-5].

or:

```
poppunk_assign --citation --query some_queries.txt --db example_db
```

gives:

> We queried a database of 28 isolates and their pre-assigned variable-length-k-mer
> clusters (VLKCs) using pp-sketchlib version 1.7.0 (doi:10.5281/zenodo.4531418) with
> sketch version 88ee3ff83ba294c928505f991e20078691ed090e, k-mer lengths 13-28,
> a sketch size of 9984 and dense seeds [6-8]. We assigned the VLKCs using PopPUNK
> version 2.4.0 (doi:10.1101/gr.241455.118) [1-5].

If your journal requires versions for all software packages, you may find running
`conda list` helpful. Running `poppunk_info` ([Viewing information about a database](sketching.html#db-info)) on your `.h5`
files will give useful information too.

[Next

Reference documentation](api.html)
[Previous

Iterative PopPUNK](poppunk_iterate.html)

Copyright © 2018-2025, John Lees and Nicholas Croucher

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Citing PopPUNK
  + [Generating citations and methods](#generating-citations-and-methods)