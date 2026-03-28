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

[alevin-fry 0.11.0 documentation](index.html)

[![Logo](_static/logo.png)

alevin-fry 0.11.0 documentation](index.html)

Contents:

* [Overview](overview.html)
* [Other resources for alevin-fry](overview.html#other-resources-for-alevin-fry)
* [Installing alevin-fry](installing.html)
* [Getting Started](getting_started.html)
* [alevin-fry commands](commands.html)[x]
* [License](LICENSE.html)

Back to top

[View this page](_sources/infer.rst.txt "View this page")

# infer[¶](#infer "Link to this heading")

The `infer` command takes a gene-resolved equivalence class count matrix, along with the
equivalence class description file (both output when running `quant` with the `-d` flag),
and performs inference via the EM to reduce the matrix to a cell-by-gene level count matrix.

This functionality makes it possible to separate the UMI resolution step (which may result in
UMIs being assigned to equivalence classes of genes rather than individual genes), and the gene-level
estimation step, that attempts to resolve gene-multimapping UMIs.

This command can takes the following options :

* `-c, --count-mat <eqc-mat>` : This provides the path to the (mtx format) matrix of cells by equivalence class counts. **Note**: It is assumed that the parent directory where `eqc-mat` is located will also contain a file called `quants_mat_rows.txt` containing the row names of the matrix and a file called `quants_mat_cols.txt` containing the column names of the files. The `infer` command will not run if these other input files are absent from the parent directory of `eqc-mat`.
* `-e, --eq-labels <eq-labels>` : This provides the path to the file containing the gene labels of the equivalence class description.
* `-o, --output-dir <output-dir>` : This provides the output file directory the quantification matrix, barcodes (row names), and genes (column names) will be written.
* `--quant-subset <sfile>` : This optional argument provides a file containing list of barcodes to quantify (one barcode per line, written as a string), those not in this list will be ignored during inference and will not appear in the output quantification matrix. If this argument is not provided, then all of the original barcodes will be quantified.
* `-t, --threads <threads>` : This option provides the number of threads to use for processing [default: number of hardware threads].

## output[¶](#output "Link to this heading")

The output of the `infer` command is written in the provided `output-dir`. It consists of the cell-by-gene count matrix derived from the input cell-by-equivalence-class count matrix, as well as a `quants_mat_rows.txt` and `quants_mat_cols.txt` file providing the row and column names for the output matrix, respectively.

[Next

License](LICENSE.html)
[Previous

quant](quant.html)

Copyright © 2021-2024, Dongze He, Mohsen Zakeri, Hirak Sarkar, Charlotte Soneson, Avi Srivastava, Noor Pratap Singh, Rob Patro

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* infer
  + [output](#output)