# Output[¶](#output "Link to this heading")

Metaphor’s output is organised in accordance with each module:

* Quality control (QC)
* Assembly
* Annotation
* Mapping
* Binning
* Postprocessing

Additionally, there are the `logs` and `benchmarks` directory which contain the log and benchmark files of each rule.
Log files contain the rules’ standard error (stderr), so they are useful for debugging in case your workflow errors out.
Benchmark files, on the other hand, contain the output of the [`psutil`](https://psutil.readthedocs.io/en/latest/)
command, which is the memory consumption and runtime of each rule.

The output directory of each module contains subdirectories named after each rule. These rule directories may contain
yet another level of subdirectories named after each sample. So, the structure of Metaphor’s output in general follows
this pattern:

```
(metaphor)$ tree output/
output/
└── module_1/
    └── rule_a/
        └── file_aa
        └── file_ab
└── module_2/
    └── rule_b/
        └── sample_1/
            └── file_ba
            └── file_bb
        └── sample_2/
```

And so on.

## QC[¶](#qc "Link to this heading")

The QC module contains four directories and the `multiqc.html` report:

* `fastp`: output of the fastp rule, which removes the adapters and performs quality fastp on the raw
  reads.
* `fastqc`: output of the FastQC rule. Has subdirectories for raw, trimmed, and merged reads.
* `merged`: merged reads after QC.
* `multiqc_data`: data for the `multiqc.html` report.

## Assembly[¶](#assembly "Link to this heading")

The assembly module contains two directories:

* `assembly_report`: report with assembly metrics for all samples, along with plots.
* `megahit`: results of the MegaHIT assembly. Contains subdirectories for each sample.

## Annotation[¶](#annotation "Link to this heading")

This module contains three directories:

* `cog`: final output of the annotation with the NCBI COG database. Generated from the DIAMOND tables along with the
  COG reference files. This contains subdirectories for each sample with the taxonomy and annotation tables for each
  sample, and two extra subdirectories:

  + `tables`: the concatenated (with all samples) tables of taxonomy and functional annotation.
  + `plots`: the plots generated from the concatenated tables.
* `diamond`: output tables of the DIAMOND annotation. These tables are similar to
  [BLAST tabular](https://www.metagenomics.wiki/tools/blast/blastn-output-format-6) format.
* `prodigal`: output of gene prediction with Prodigal. Contains subdirectories for each binning group. Each subdirectory
  contains 3-4 files:

  + `{binning_group}_genbank.gbk`: the [GenBank Flat File format](https://www.ncbi.nlm.nih.gov/Sitemap/samplerecord.html).
  + `{binning_group}_genes.fna`: predicted coding sequences as nucleotides.
  + `{binning_group}_proteins.faa`: predicted coding sequences as amino acids
  + `{binning_group}_scores.cds` (optional): is the tabular format with the scores for all possible genes.

## Mapping[¶](#mapping "Link to this heading")

This module contains the files that map the original reads back to both contigs and genes (CDSs). These files are required for the
binning process:

* `bam`: directory with BAM (four different kinds) files for all samples.
* `{binning_group}_{genes|contigs}_catalogue.fna.gz`: concatenated contigs for all samples.
* `{binning_group}_{genes|contigs}_catalogue.mmi`: index file of the concatenated contigs and genes
* `bam_{genes|contigs}_depths.txt`: coverage of each contig calculated from BAM files.

## Binning[¶](#binning "Link to this heading")

This module contains one directory for each of the binners:

* `metabat2`: bins are inside this directory as `.fa` files.
* `vamb`: contains a `bins` directory.
* `concoct`: contains a `fasta_bins` directory.
* `DAS_tool`: contains the refined bins inside the `DASTool_bins` directory, and the table with quality score for each
  bin is named as `DASTool_summary.tsv`

## Postprocessing[¶](#postprocessing "Link to this heading")

The postprocessing module contains four different plots:

* `memory_barplot_errorbar.png`
* `memory_barplot_sum.png`
* `runtime_barplot_errorbar.png`
* `runtime_barplot_sum.png`

These plots show the total (`_sum`) and average (`_errorbar`) runtime and memory consumption for each rule. You can use
them to identify computational bottlenecks in your analyses, that is, if any rule in particular is taking more time than
it should.

# [Metaphor](../index.html)

### Navigation

* [Tutorial](tutorial.html)
* Output
  + [QC](#qc)
  + [Assembly](#assembly)
  + [Annotation](#annotation)
  + [Mapping](#mapping)
  + [Binning](#binning)
  + [Postprocessing](#postprocessing)
* [Advanced](advanced.html)
* [Configuration](configuration.html)
* [Troubleshooting](troubleshooting.html)
* [Contributing](contributing.html)
* [Reference](reference.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Tutorial](tutorial.html "previous chapter")
  + Next: [Advanced](advanced.html "next chapter")

### Quick search

© The University of Melbourne 2023 — This documentation is public domain under a CC0 license.
|
Powered by [Sphinx 7.4.7](https://www.sphinx-doc.org/)
& [Alabaster 0.7.16](https://alabaster.readthedocs.io)
|
[Page source](../_sources/main/output.md.txt)