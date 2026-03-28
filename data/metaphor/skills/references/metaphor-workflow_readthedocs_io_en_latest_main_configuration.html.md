# Configuration[¶](#configuration "Link to this heading")

This page explains each value of Metaphor’s config settings, that is, the values defined in the config YAML file.

**TOP LEVEL**

These settings are valid for all steps in the workflow.

**`samples:`** `samples.csv`

**QC**

**`fastp:`**
   **`activate:`** `True`
   **`length_required:`** `50`
   **`cut_mean_quality:`** `30`
   **`extra:`** `"--detect_adapter_for_pe"`

**`merge_reads:`**
   **`activate:`** `True`

**`host_removal:`**
   **`activate:`** `False`
   **`reference:`** `""`

**`fastqc:`**
   **`activate:`** `True`

**`multiqc:`**
   **`activate:`** `True`

**ASSEMBLY**

**`coassembly:`** `False` Whether to perform coassembly (also known as pooled assembly). If this is true, all samples are merged together and assembled into a single file of contigs.

**`megahit:`**
   **`preset:`** `"meta-large"`
   **`min_contig_len:`** `1000`
   **`remove_intermediate_contigs:`** `True`

**`rename_contigs:`**
   **`activate:`** `True` Whether to rename contigs so contigs and mapping files (.bam) can be imported into Anvi’o. We suggest you keep this on.
   **`awk_command:`** `awk '/^>/{{gsub(" |\\\\.|=", "_", $0); print $0; next}}{{print}}' {input} > {output}` This is to prevent errors with the Snakemake –lint command. Don’t change it unless you know what you’re doing.

**`metaquast:`**
   **`activate:`** `False`
   **`coassembly_reference:`** `""` Reference FASTA file for Metaquast to use as reference. Only required if `coassembly` is True.

**ANNOTATION**

**`prodigal:`**
   **`activate:`** `True`
   **`mode:`** `"meta"`
   **`quiet:`** `True`
   **`genes:`** `False`
   **`scores:`** `False`

**`prokka:`**
   **`activate:`** `False`
   **`args:`** `"--quiet --force"`

**`diamond:`**
   **`db:`** `"COG2020/cog-20.dmnd"` Will try to create from db\_source if it doesn’t exist.
   **`db_source:`** `"COG2020/cog-20.fa.gz"`
   **`output_type:`** `6`
   **`output_format:`** `"qseqid sseqid stitle evalue bitscore staxids sscinames"`

**`cog_functional_parser:`**
   **`activate:`** `True`
   **`db:`** `"COG2020"`

**`lineage_parser:`**
   **`activate:`** `True`
   **`taxonmap:`** `"COG2020/cog-20.taxonmap.tsv"`
   **`rankedlineage:`** `"taxonomy/rankedlineage.dmp"`
   **`names:`** `"taxonomy/names.dmp"` Path of names file of NCBI Taxonomy
   **`nodes:`** `"taxonomy/nodes.dmp"` Path of nodes file of NCBI Taxonomy
   **`download_url:`** `"https://ftp.ncbi.nih.gov/pub/taxonomy/new_taxdump/new_taxdump.tar.gz"` URL to download NCBI Taxonomy database

**`plot_cog_functional:`**
   **`activate:`** `True`
   **`filter_categories:`** `True`
   **`categories_cutoff:`** `0.01` Remove categories with mean abundance across samples smaller than this value

**`plot_taxonomies:`**
   **`activate:`** `True`
   **`tax_cutoff:`** `20` Only show the N most abundant taxa for any rank. Leave as 0 for no filtering. Low abundance taxa will be grouped as ‘Low abundance’.
   **`colormap:`** `"tab20c"` Which matplotlib colormap to use

**BINNING**

**`cobinning:`** `True` Whether to perform cobinning. When this is true, only one binning group will be used. If False, samples will be binned according to their ‘group’ column.

**`vamb:`**
   **`activate:`** `True`
   **`minfasta:`** `100000`
   **`batchsize:`** `256`

**`metabat2:`**
   **`activate:`** `True`
   **`seed:`** `0`
   **`preffix:`** `"bin"` Preffix of each bin, e.g. bin.1.fa, bin.2.fa, etc.

**`concoct:`**
   **`activate:`** `True`

**`das_tool:`**
   **`activate:`** `True`
   **`score_threshold:`** `0.5`
   **`bins_report:`** `True`

**POSTPROCESSING**

**`postprocessing:`**
   **`activate:`** `True`
   **`runtime_unit:`** `"m"`
   **`runtime_cutoff:`** `5`
   **`memory_unit:`** `"max_vms"`
   **`memory_cutoff:`** `1`
   **`memory_gb:`** `True`

# [Metaphor](../index.html)

### Navigation

* [Tutorial](tutorial.html)
* [Output](output.html)
* [Advanced](advanced.html)
* Configuration
* [Troubleshooting](troubleshooting.html)
* [Contributing](contributing.html)
* [Reference](reference.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Advanced](advanced.html "previous chapter")
  + Next: [Troubleshooting](troubleshooting.html "next chapter")

### Quick search

© The University of Melbourne 2023 — This documentation is public domain under a CC0 license.
|
Powered by [Sphinx 7.4.7](https://www.sphinx-doc.org/)
& [Alabaster 0.7.16](https://alabaster.readthedocs.io)
|
[Page source](../_sources/main/configuration.md.txt)