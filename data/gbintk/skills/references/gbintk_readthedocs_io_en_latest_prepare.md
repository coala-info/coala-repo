[GraphBin-Tk](..)

Home

* [Introduction](..)
* [Citation](../citation/)
* [Install](../install/)

MetaCoAG

* [Introduction](../metacoag_intro/)
* [Preprocess](../metacoag_preprocess/)
* [Usage](../metacoag_usage/)

GraphBin

* [Introduction](../graphbin_intro/)
* [Preprocess](../graphbin_preprocess/)
* [Usage](../graphbin_usage/)

GraphBin2

* [Introduction](../graphbin2_intro/)
* [Preprocess](../graphbin2_preprocess/)
* [Usage](../graphbin2_usage/)

Processing

* Prepare
  + [Input](#input)
  + [Example usage](#example-usage)
  + [Output](#output)
* [Visualise](../visualise/)
* [Evaluate](../evaluate/)

[GraphBin-Tk](..)

* Processing
* Prepare
* [Edit on GitHub](https://github.com/Vini2/gbintk/edit/master/docs/prepare.md)

---

# Formatting binning results for GraphBin/GraphBin2

You can use the `prepare` subcommand of `gbintk` to format the binning results so they are accepted by GraphBin/GraphBin2.

Run `gbintk prepare --help` or `gbintk prepare -h` to list the help message for formatting.

```
Usage: gbintk prepare [OPTIONS]

  Format the initial binning result from an existing binning tool

Options:
  --assembler [spades|megahit|flye]
                                  name of the assembler used (SPAdes, MEGAHIT
                                  or Flye)  [required]
  --resfolder PATH                path to the folder containing FASTA files
                                  for individual bins  [required]
  --delimiter [comma|tab]         delimiter for input/output results. Supports
                                  a comma and a tab.  [default: comma]
  --prefix TEXT                   prefix for the output file
  --output PATH                   path to the output folder  [required]
  -h, --help                      Show this message and exit.
```

## Input

`prepare` subcommand takes the path to the folder containing the `.fasta` files of the bins as input.

## Example usage

You can use the `prepare` subcommand to format an initial binning result in to the `.csv` format (by default) with contig identifiers and bin ID. You can run the `prepare` subcommand as follows.

```
# For SPAdes data available in tests/data/
gbintk prepare --assembler spades --resfolder tests/data/5G_metaSPAdes/initial_bins --output tests/data/5G_metaSPAdes/prepare_results

# For MEGAHIT data available in tests/data/
gbintk prepare --assembler megahit --resfolder tests/data/5G_MEGAHIT/initial_bins --output tests/data/5G_MEGAHIT/prepare_results

# For Flye data available in tests/data/
gbintk prepare --assembler flye --resfolder tests/data/1Y3B_Flye/initial_bins --output tests/data/1Y3B_Flye/prepare_results
```

## Output

Formatted binning result will be stored in a delimited text file in the output folder provided (e.g. `initial_contig_bins.csv`). Contigs are named according to their original identifier and bins are numbered according to the fasta file name.

[Previous](../graphbin2_usage/ "Usage")
[Next](../visualise/ "Visualise")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).