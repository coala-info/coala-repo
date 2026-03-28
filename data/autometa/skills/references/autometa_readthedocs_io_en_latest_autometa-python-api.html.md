[Autometa](index.html)

latest

* [Getting Started](getting-started.html)
* [🍏 Nextflow Workflow 🍏](nextflow-workflow.html)
* [🐚 Bash Workflow 🐚](bash-workflow.html)
* [📓 Bash Step by Step Tutorial 📓](bash-step-by-step-tutorial.html)
* [Databases](databases.html)
* [Examining Results](examining-results.html)
* [Benchmarking](benchmarking.html)
* [Installation](installation.html)
* Autometa Python API
  + [Running modules](#running-modules)
  + [Using Autometa’s Python API](#using-autometa-s-python-api)
    - [Examples](#examples)
      * [Samtools wrapper](#samtools-wrapper)
      * [Metagenome Description](#metagenome-description)
      * [k-mer frequency counting, normalization, embedding](#k-mer-frequency-counting-normalization-embedding)
* [Usage](scripts/usage.html)
* [How to contribute](how-to-contribute.html)
* [Autometa modules](Autometa_modules/modules.html)
* [Legacy Autometa](legacy-autometa.html)
* [License](license.html)

[Autometa](index.html)

* Autometa Python API
* [Edit on GitHub](https://github.com/KwanLab/Autometa/blob/main/docs/source/autometa-python-api.rst)

---

# Autometa Python API[](#autometa-python-api "Permalink to this heading")

## Running modules[](#running-modules "Permalink to this heading")

Many of the Autometa modules may be run standalone.

Simply pass in the `-m` flag when calling a script to signify to python you are
running the script as an Autometa *module*.

I.e. `python -m autometa.common.kmers -h`

Note

Autometa has many *entrypoints* available that are utilized by the [🍏 Nextflow Workflow 🍏](nextflow-workflow.html#autometa-nextflow-workflow) and [🐚 Bash Workflow 🐚](bash-workflow.html#autometa-bash-workflow). If you have installed autometa,
all of these entrypoints will be available to you.

If you would like to get a better understanding of each entrypoint, we recommend reading the [📓 Bash Step by Step Tutorial 📓](bash-step-by-step-tutorial.html#bash-step-by-step-tutorial) section.

## Using Autometa’s Python API[](#using-autometa-s-python-api "Permalink to this heading")

Autometa’s classes and functions are available after installation.
To access these, do the same as importing any other python library.

### Examples[](#examples "Permalink to this heading")

#### Samtools wrapper[](#samtools-wrapper "Permalink to this heading")

To incorporate a call to `samtools sort` inside of your python code using the Autometa samtools wrapper.

```
from autometa.common.external import samtools

# To see samtools.sort parameters try the commented command below:
# samtools.sort?

# Run samtools sort command in ipython interpreter
samtools.sort(sam="<path/to/alignment.sam>", out="<path/to/output/alignment.bam>", cpus=4)
```

#### Metagenome Description[](#metagenome-description "Permalink to this heading")

Here is an example to easily assess your metagenome’s characteristics using Autometa’s Metagenome class

```
from autometa.common.metagenome import Metagenome

# To see input parameters, instance attributes and methods
# Metagenome?

# Create a metagenome instance
mg = Metagenome(assembly="/path/to/metagenome.fasta")

# To see available methods (ignore any elements in the list with a double underscore)
dir(mg)

# Get pandas dataframe of metagenome details.
metagenome_df = mg.describe()

metagenome_df.to_csv("path/to/metagenome_description.tsv", sep='\t', index=True, header=True)
```

#### k-mer frequency counting, normalization, embedding[](#k-mer-frequency-counting-normalization-embedding "Permalink to this heading")

To quickly perform a k-mer frequency counting, normalization and embedding pipeline…

```
from autometa.common import kmers

# Count kmers
counts = kmers.count(
    assembly="/path/to/metagenome.fasta",
    size=5
)

# Normalize kmers
norm_df = kmers.normalize(
    df=counts,
    method="ilr"
)

# Embed kmers
embed_df = kmers.embed(
    norm_df,
    pca_dimensions=50,
    embed_dimensions=3,
    method="densmap"
)
```

[Previous](installation.html "Installation")
[Next](scripts/usage.html "Usage")

---

© Copyright 2016 - 2024, Ian J. Miller, Evan R. Rees, Izaak Miller, Shaurya Chanana, Siddharth Uppal, Kyle Wolf, Jason C. Kwan.
Revision `0d9028cf`.
Last updated on Jun 14, 2024.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).