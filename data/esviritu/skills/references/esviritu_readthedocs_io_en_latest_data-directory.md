[EsViritu](..)

* [Home](..)

* [Installation](../installation/)

* [Pipeline Description](../pipeline-description/)

* [Using EsViritu](../esviritu-usage/)

* Data Directory
  + [Files](#files)
  + [Notes](#notes)
  + [Column reference for main tables](#column-reference-for-main-tables)
    - [SAMPLE.detected\_virus.info.tsv](#sampledetected_virusinfotsv)
    - [SAMPLE.detected\_virus.assembly\_summary.tsv](#sampledetected_virusassembly_summarytsv)
    - [SAMPLE.virus\_coverage\_windows.tsv](#samplevirus_coverage_windowstsv)
    - [SAMPLE.tax\_profile.tsv](#sampletax_profiletsv)

* [Interpretting Outputs](../interpretting-outputs/)

* [Making Custom Databases](../custom-database/)

* [Notable Changes in v1](../notable-changes/)

[EsViritu](..)

* Data Directory
* [Edit on cmmr/EsViritu](https://github.com/cmmr/EsViritu/blob/main/docs/data-directory.md)

---

# Output data directory

EsViritu writes its primary tab-delimited outputs to the directory provided with `-o/--output_dir`.
Each file is prefixed with your `--sample` name.

Location: `<OUTPUT_DIR>/`

## Files

* `<SAMPLE>.detected_virus.info.tsv`
* Per-contig summary table of detected viral contigs.
* Contains detection and quantification metrics for each contig.
* `<SAMPLE>.detected_virus.assembly_summary.tsv`
* Per-assembly summary table.
* Aggregates contig-level results at the assembly level.
* `<SAMPLE>.tax_profile.tsv`
* Taxonomic profile table.
* Assigns taxonomy to records based on average nucleotide identity to reference
* See `--species-threshold` (default 0.90)
* See `--subspecies-threshold` (default 0.95)
* `<SAMPLE>.virus_coverage_windows.tsv`
* Coverage in fixed windows across each reference contig.
* Useful for visualizing coverage profiles and drops/gaps.

## Notes

* Temporary/intermediate files are written under `<OUTPUT_DIR>/<SAMPLE>_temp/` (unless you set `--temp`).
  These include aligned .bam files,read-sharing comparisons, clustering summaries, coverm-like tables, and read ANI per contig.
  They will be removed automatically unless you run with `--keep`.

## Column reference for main tables

### *SAMPLE*.detected\_virus.info.tsv

| Column | Type | Description |
| --- | --- | --- |
| sample\_ID | string | Sample name provided via `--sample`. |
| Name | string | Virus name from database metadata. |
| description | string | Reference sequence description. |
| Length | int | Reference contig length (bp). |
| Segment | string | Segment identifier (if applicable). |
| Accession | string | Reference contig accession ID. |
| Assembly | string | Assembly name the contig belongs to. |
| Asm\_length | int | Total assembly length (bp). |
| kingdom | string | Taxonomic rank. |
| phylum | string | Taxonomic rank. |
| tclass | string | Taxonomic class (named `tclass` to avoid keyword collision). |
| order | string | Taxonomic rank. |
| family | string | Taxonomic rank. |
| genus | string | Taxonomic rank. |
| species | string | Taxonomic rank. |
| subspecies | string | Taxonomic rank. |
| RPKMF | float | Reads per kilobase per million filtered reads: `(read_count/(Length/1000)) / (filtered_reads_in_sample/1e6)`. |
| read\_count | int | Number of reads aligned to the contig. |
| covered\_bases | int | Number of bases with coverage > 0 on the contig. |
| mean\_coverage | float | Mean read depth across the contig. |
| avg\_read\_identity | float | Average per-read alignment identity for the contig. |
| Pi | float | Average nucleotide diversity across covered positions. |
| filtered\_reads\_in\_sample | int | Total filtered reads used for normalization. |

### *SAMPLE*.detected\_virus.assembly\_summary.tsv

| Column | Type | Description |
| --- | --- | --- |
| sample\_ID | string | Sample name provided via `--sample`. |
| filtered\_reads\_in\_sample | int | Total filtered reads used for normalization. |
| Assembly | string | Assembly name. |
| Asm\_length | int | Total assembly length (bp). |
| kingdom | string | Taxonomic rank. |
| phylum | string | Taxonomic rank. |
| tclass | string | Taxonomic class (named `tclass` to avoid keyword collision). |
| order | string | Taxonomic rank. |
| family | string | Taxonomic rank. |
| genus | string | Taxonomic rank. |
| species | string | Taxonomic rank. |
| subspecies | string | Taxonomic rank. |
| read\_count | int | Number of reads aligned across contigs in the assembly. |
| covered\_bases | int | Number of bases with coverage > 0 across contigs in the assembly. |
| avg\_read\_identity | float | Mean read identity across contigs in the assembly. |
| Accession | string | Comma-separated list of accessions included. |
| Segment | string | Comma-separated list of segments included. |
| RPKMF | float | Assembly-level RPKMF using `Asm_length`. |

### *SAMPLE*.virus\_coverage\_windows.tsv

| Column | Type | Description |
| --- | --- | --- |
| Accession | string | Reference accession ID. |
| window\_index | int | Window index (0–99). |
| window\_start | int | 0-based start coordinate (inclusive). |
| window\_end | int | 0-based end coordinate (exclusive). |
| average\_coverage | float | Mean read depth across the window. |

### *SAMPLE*.tax\_profile.tsv

| Column | Type | Description |
| --- | --- | --- |
| sample\_ID | string | Sample name provided via `--sample`. |
| filtered\_reads\_in\_sample | int | Total filtered reads used for normalization. |
| kingdom | string | Taxonomic rank. |
| phylum | string | Taxonomic rank. |
| tclass | string | Taxonomic class (named `tclass` to avoid keyword collision). |
| order | string | Taxonomic rank. |
| family | string | Taxonomic rank. |
| genus | string | Taxonomic rank. |
| species | string | Species classification; may be `s__unclassified <genus>` when `avg_read_identity` < `--species-threshold`. |
| subspecies | string | Subspecies classification; may be `t__unclassified <species>` when `avg_read_identity` < `--subspecies-threshold`. |
| read\_count | int | Sum of reads aligned to assemblies contributing to this taxon. |
| RPKMF | float | Sum of RPKMF across assemblies in this taxon. |
| avg\_read\_identity | float | Mean read identity across assemblies in this taxon. |
| assembly\_list | string | Comma-separated list of assemblies contributing to this row. |

[Previous](../esviritu-usage/ "Using EsViritu")
[Next](../interpretting-outputs/ "Interpretting Outputs")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).