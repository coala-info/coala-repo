[PPanGGOLiN](../index.html)

User Guide:

* [Installation](install.html)
* [Quick usage](QuickUsage/quickAnalyses.html)
* [Practical information](practicalInformation.html)
* [Pangenome analyses](PangenomeAnalyses/pangenomeAnalyses.html)
* [Regions of genome plasticity analyses](RGP/rgpAnalyses.html)
* [Conserved module prediction](Modules/moduleAnalyses.html)
* [Write genomes](writeGenomes.html)
* [Write pangenome sequences](writeFasta.html)
* [Align external genes to a pangenome](align.html)
* Projection
  + [Input files:](#input-files)
  + [Output Files](#output-files)
* [Prediction of Genomic Context](genomicContext.html)
* [Multiple Sequence Alignment](MSA.html)
* [Metadata and Pangenome](metadata.html)

Developper Guide:

* [How to Contribute ✨](../dev/contribute.html)
* [Building the Documentation](../dev/buildDoc.html)
* [API Reference](../api/api_ref.html)

[PPanGGOLiN](../index.html)

* Projection
* [View page source](../_sources/user/projection.md.txt)

---

# Projection[](#projection "Permalink to this heading")

The ppanggolin projection command allows you to annotate external genomes using an existing pangenome. This process eliminates the need to recompute all components, streamlining the annotation process. Input genomes are expected to belong to the same species.

Genes within the input genome are aligned with genes in the pangenome to determine their gene families and partitions. Genes that do not align with any existing gene in the pangenome are considered specific to the input genome and are assigned to the “Cloud” partition. The number of this specific cloud families are detailed in the summary table.

Based on the alignment and partition assignment, Regions of Plasticity (RGPs) within the input genome are predicted. Each RGP that is not located on a contig border is assigned to a spot of insertion. Finally, conserved modules of the pangenome found in the input genome are reported in the output files.

## Input files:[](#input-files "Permalink to this heading")

This command supports two input modes depending on whether you want to project a single genome or multiple genomes at once:

Multiple Files in One TSV:

* **Options**: `--fasta` or `--anno`
* **Description**: You can provide a tab-separated file listing genome names alongside their respective FASTA genomic sequences or annotation filepaths, with one line per genome. This mode is suitable when you want to annotate multiple genomes in a single operation. The format of this file is identical to the format used in the annotate and workflow commands; for more details, refer [here](PangenomeAnalyses/pangenomeAnnotation.html).

**Example Usage:**
Suppose you have a TSV file named `external_genome_paths.txt` listing multiple annotation files of external genomes. To execute the projection, use the following command:

```
ppanggolin projection -p pangenome.h5 --anno external_genome_paths.txt
```

Single File:

* **Options**: `--genome_name` with `--fasta` or `--anno` and `--circular_contigs` (optional)
* **Description**: When annotating a single genome, you can directly provide a single FASTA genomic sequence file or an annotation file in GFF/GBFF format. Additionally, specify the name of the genome using the `--genome_name` option. You can also indicate circular contigs using the `--circular_contigs` option when necessary.

**Example Usage:**
Suppose you have a single fasta file named `genome_A.fasta` of an external genome. To execute the projection, use the following command:

```
ppanggolin projection -p pangenome.h5 --anno genome_A.fasta --genome_name genome_A
```

## Output Files[](#output-files "Permalink to this heading")

Within the Output directory, the `summary_projection.tsv` file provides an overview of the projection, featuring one line per genome. This file includes all the columns described in the [genome-statistics table](PangenomeAnalyses/pangenomeStat.html#genome-statistics-table) section, along with specific projection-related columns detailed below:

| Column | Description |
| --- | --- |
| Cloud\_specific\_families | Number of cloud-specific families. These gene families do not match any existing families within the pangenome. |
| Pangenome\_file | The file path of the pangenome used in the projection. |
| New\_spots | Number of newly identified spots in the input genome. |

Additionally, within the Output directory, there is a subdirectory for each input genome, named after the input genome itself. Each of these subdirectories contains several files:

For Gene Family and Partition of Input Genes:

* `cds_sequences.fasta`: This file contains the sequences of coding regions (CDS) from the input genome.
* `gene_to_gene_family.tsv`: It provides the mapping of genes to gene families of the pangenome. Its format follows [this output](PangenomeAnalyses/pangenomeAnalyses.html#gene-families-to-genes-associations)
* `sequences_partition_projection.tsv`: This file maps the input genes to its partition (Persistent, Shell or Cloud).
* `specific_genes.tsv`: This file lists the gene of the input genomes that do not align to any gene of the pangenome. These genes are assigned to Cloud parititon.

For RGPs and Spots:

* `plastic_regions.tsv`: This file contains information about RGPs within the input genome. Its format follows [this output](RGP/rgpOutputs.html#rgp-outputs).
* `input_genome_rgp_to_spot.tsv`: It provides information about the association between RGPs and insertion spots in the input genome. Its format follows [this output](RGP/rgpOutputs.html#summarize-spots).

Optionally, you can generate a graph of the spots using the `--spot_graph` option. This graph resembles the one produced by the `ppanggolin draw --spots` command, which is detailed [here](RGP/rgpOutputs.html#draw-spots).

For Modules:

* `modules_in_input_genome.tsv`: This file lists the modules that have been found in the input genome. Its format follows [this output](Modules/moduleOutputs.html#module-outputs).

[Previous](align.html "Align external genes to a pangenome")
[Next](genomicContext.html "Prediction of Genomic Context")

---

© Copyright 2023, LABGeM.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).