[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

PANORAMA just released!

[![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)
![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)

PANORAMA](../index.html)

* [User Documentation](user_guide.html)
* [Modeler Documentation](../modeler/modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* More
  + [PANORAMA](https://github.com/labgem/PANORAMA)
  + [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
  + [LABGeM](https://labgem.genoscope.cns.fr/)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Search
`Ctrl`+`K`

* [User Documentation](user_guide.html)
* [Modeler Documentation](../modeler/modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* [PANORAMA](https://github.com/labgem/PANORAMA)
* [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
* [LABGeM](https://labgem.genoscope.cns.fr/)

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Section Navigation

Get Started:

* [Installation Guide 🦮](install.html)
* [Quick usage 🦅](quick_usage.html)
  + [Complete Biological Systems Prediction Workflow](pansystems.html)
  + [Pangenome Comparison Analysis](quick_compare.html)
* [Reporting Issues and Suggesting Features 💬](issues.html)

Biological system Prediction:

* Gene Family annotation
* [System Detection Based on Models](detection.html)
* [Systems analysis output 📊](write_systems.html)
  + [System Projection on Genomes](projection.html)
  + [System Association with Pangenome Elements](association.html)
  + [System Partition Analysis](partition.html)

Pangenomes comparison:

* [Conserved Spots Comparison Across Pangenomes](compare_spots.html)
* [Systems Comparison Across Pangenomes](compare_systems.html)

PANORAMA utilities:

* [Extract and Visualize Pangenome Information ℹ️](info.html)
* [Gene Family Alignment Across Pangenomes](align.html)
* [Gene Family Clustering Across Pangenomes](clustering.html)

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [User Documentation](user_guide.html)
* Gene Family annotation

# Gene Family annotation[#](#gene-family-annotation "Link to this heading")

The `annotation` command adds **functional annotations** to gene families in pangenomes.
You can choose between:

* A **TSV file** with metadata
* A **HMM database**, searched with [pyhmmer](https://pyhmmer.readthedocs.io/en/stable/index.html)

---

## Annotation Modes[#](#annotation-modes "Link to this heading")

### TSV-based annotation[#](#tsv-based-annotation "Link to this heading")

This mode injects gene family metadata from a `.tsv` file.

**Expected format**:
A TSV file where each row lists a pangenome name and the path to its gene family annotation file.

These annotation files contain functional details (e.g., protein name, accession, score, etc.).
The only mandatory column is `families`, which correspond to the gene families identifier.
See [metadata format](https://ppanggolin.readthedocs.io/en/latest/user/metadata.html#metadata-format) PPanGGOLiN
documentation, for more information.

### HMM-based annotation[#](#hmm-based-annotation "Link to this heading")

To annotate with a HMM database, you must provide a HMM metadata file (TSV format), containing:

| Column | Description | Type | Mandatory |
| --- | --- | --- | --- |
| name | The name of the HMM | string | True |
| accession | Identifier of the HMM | string | True |
| path | Path to the HMM file | string | True |
| length | Length of the profile. Automatically recover by pyhmmer if necessary | int | False |
| protein\_name | Name of the protein/function corresponding to the HMM | string | True |
| secondary\_name | Secondary name of the protein | string | True |
| score\_threshold | Threshold used on the score to filter the profile | float | False |
| eval\_threshold | Threshold used on the E-value to filter the profile | float | False |
| ieval\_threshold | Threshold used on the iE-value to filter the profile | float | False |
| hmm\_cov\_threshold | Threshold used on the HMM covering to filter the profile | float | False |
| target\_cov\_threshold | Threshold used on the target covering to filter the profile | float | False |
| description | Description of the HMM, its protein function, or any other information | float | False |

Warning

Not all the columns need to be filled with value as indicated by the mandatory column, but they should exist in the metadata file.

Tip

To keep all assignations possible between a profile and a gen family, you can let the threshold columns empty.

Note

You can generate the input files expected by PANORAMA using `panorama utils --hmm`.

To align gene families against a HMM database, you can use different modes:

| Mode | Description |
| --- | --- |
| `fast` | Aligns representative sequences of each family to the HMMs |
| `profile` | Builds HMMs for each family from MSAs |
| `sensitive` | Aligns **all genes** from each family to the HMMs |

---

## Command Line Usage[#](#command-line-usage "Link to this heading")

To annotate gene families with precomputed metadata, do as such:

```
panorama annotation \
  --pangenomes pangenomes.tsv \
  --source KEGG \
  --table annotations.tsv
  --threads 8
```

To annotate with a HMM database, do as such:

```
panorama annotation \
  --pangenomes pangenomes.tsv \
  --source defensefinder \
  --hmm hmms.tsv \
  --mode sensitive \
  --k_best_hit 3 \    # <-- or use the alias -b to keep only the best hit
  --save_hits tblout \
  --output results/ \
  --threads 8
```

Tip

More options are available to annotate with a HMM database. See below.

Note

Source name should not contain a special character. They could interfere with the `.h5` writing.

Warning

You **must provide either** `--table` **or** `--hmm`, **but not both**.
These options are mutually exclusive.

### Key options[#](#key-options "Link to this heading")

| Shortcut | Argument | Description |
| --- | --- | --- |
| `-p` | `--pangenomes` | TSV file listing `.h5` pangenomes |
| `-s` | `--source` | Name of the annotation source (e.g. `KO2024`, `Pfam`) |
| — | `--table` | **Mutually exclusive with `--hmm`**. TSV linking pangenome names to annotation files |
| — | `--hmm` | **Mutually exclusive with `--table`**. HMM metadata TSV (from `panorama utils --hmm`) |
| — | `--mode` | Required with `--hmm`. Alignment strategy: `fast`, `profile`, or `sensitive` |
| — | `--msa` | (Used only in `profile` mode) TSV listing MSAs per gene family |
| `-b` | `--only_best_hit` | Equivalent to `--k_best_hit 1` |
| — | `--k_best_hit` | Keep up to `k` best hits per gene family |
| — | `--output` | Output directory for HMM result files (optional, used with `--save_hits`) |
| — | `--save_hits` | Save HMM alignment results in formats: `tblout`, `domtblout`, `pfamtblout` |
| — | `--tmp` | Temporary directory (used with HMM mode) |
| — | `--keep_tmp` | Keep temporary files after HMM alignment |
| — | `--Z` | Custom Z value for e-value scaling (advanced HMMER option) |
| — | `--msa-format` | Format of MSA files (default: `afa`) — rarely changed |
| — | `--threads` | Number of threads to use |

## Annotation Workflow[#](#annotation-workflow "Link to this heading")

1. Load pangenomes

   Pangenomes are loaded from .h5 files. Only necessary information is retrieved based on the mode.
2. Retrieve annotations

   * With `--table`: loads metadata from TSV
   * With `--hmm`: aligns families via annot\_with\_hmm() from hmm\_search.py
3. Filter HMM hits (only for the hmm option)

   Each hit is filtered using the thresholds defined in the HMM metadata:

   * e-value
   * i-evalue
   * score
   * target coverage
   * HMM coverage

Tip

Prefer to use the score instead of the e-value or the i-evalue to ensure reproducibility of the results even if the size of your targets changes.

4. Write annotations

   Filtered annotations are stored in the .h5 files, under the given –source name.

Note

Annotations can be viewed or reused with PANORAMA, PPanGGOLiN, or custom tools (*e.g.*, [vitables](https://vitables.org/index.html)).

## HMM Search Details[#](#hmm-search-details "Link to this heading")

Annotation relies on the [pyhmmer](https://pyhmmer.readthedocs.io/en/stable/index.html) Python API.

Depending on sequence size, PANORAMA chooses the best method:

| Method | Use case |
| --- | --- |
| hmmsearch | In-memory, fast |
| hmmscan | Streaming, used when memory is limited |

Note

If sequences exceed 10% of available RAM, PANORAMA uses `hmmscan`, as recommended by pyhmmer documentation
[here](https://pyhmmer.readthedocs.io/en/stable/examples/performance_tips.html#Performance-tips-and-tricks)

## Minimal example[#](#minimal-example "Link to this heading")

### Annotate gene families based on the reference sequence with COG HMM[#](#annotate-gene-families-based-on-the-reference-sequence-with-cog-hmm "Link to this heading")

```
panorama annotation \
  -p pangenomes.tsv \
  -s COG \
  --hmm hmms.tsv \
  --mode fast \
  --only_best_hit   # <-- or use the alias: -b
```

[previous

Reporting Issues and Suggesting Features 💬](issues.html "previous page")
[next

System Detection Based on Models](detection.html "next page")

On this page

* [Annotation Modes](#annotation-modes)
  + [TSV-based annotation](#tsv-based-annotation)
  + [HMM-based annotation](#hmm-based-annotation)
* [Command Line Usage](#command-line-usage)
  + [Key options](#key-options)
* [Annotation Workflow](#annotation-workflow)
* [HMM Search Details](#hmm-search-details)
* [Minimal example](#minimal-example)
  + [Annotate gene families based on the reference sequence with COG HMM](#annotate-gene-families-based-on-the-reference-sequence-with-cog-hmm)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/user/annotation.md)

### This Page

* [Show Source](../_sources/user/annotation.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.