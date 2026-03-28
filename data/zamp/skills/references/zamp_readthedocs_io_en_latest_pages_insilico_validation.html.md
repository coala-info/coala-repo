# *In silico* validation tool[¶](#in-silico-validation-tool "Link to this heading")

## Aim[¶](#aim "Link to this heading")

This module aims at predicting *in silico* if specific taxa are:

> 1. amplified by a set of PCR primers used for amplicon-based metagenomics
> 2. accurately classified taxonomically based on the generated amplicon

## Working principle[¶](#working-principle "Link to this heading")

Based on a user-defined list of NCBI tax IDs, assemblies or taxon queries, genome assemblies are downloaded from the NCBI database with [Assembly Finder](https://github.com/metagenlab/assembly_finder). Then, PCR primer sequences provided by the user are used to run an *in silico* PCR with [in\_silico\_pcr](https://github.com/egonozer/in_silico_pcr) (or alternatively, with [simulate\_PCR](https://github.com/metagenlab/updated_simulate_PCR)). The generated *in silico* amplicons are treated by the main pipeline as they would if they were the results of sequencing reads (primer trimming, amplicon clustering into representative sequences, taxonomic classification).

Finally, for each of the downloaded assembly, this module provides a table with a description of the amplicons predicted to be amplified with the PCR primers (number of sequence variants, number of copies) as well as the expected and obtained taxonomic assignment.

## Inputs[¶](#inputs "Link to this heading")

To execute the pipeline, one needs:

* An input file containing the accession names or the Tax IDs of interest. This is a one-column text file without headers. The identifiers should match NCBI taxonomy. One can skip this text file and use a query term instead, see usage cases below.
* A taxonomic database preprocessed with our dedicated pipeline

**Input file example:**

* With accession names:

```
GCA_000008005.1
GCA_000010425.1
GCA_000016965.1
GCA_020546685.1
GCA_000172575.2
GCA_000005845.2
GCA_000014425.1
GCA_003324715.1
GCA_000007645.1
GCA_000007465.2
GCA_013372085.1
GCA_031191545.1
GCA_000012825.1
GCA_000307795.1
GCA_000008805.1
GCA_000010505.1
GCA_000231215.1
GCA_000017205.1
GCA_000013425.1
GCA_000007265.1
```

* With NCBI tax IDs:

```
1069201
182096
41058
1220207
1287682
746128
5059
5062
```

## Execution[¶](#execution "Link to this heading")

The module is executed with zamp insilico.
You can see all required and optional arguments with:

```
zamp insilico -h
```

Example usage cases:

* Using bacteria assembly accession names (note the –accession argument when using accession names instead of tax IDs):

  ```
  zamp insilico -i zamp/data/bacteria-accs.txt -db greengenes2 --accession --fw-primer CCTACGGGNGGCWGCAG --rv-primer GACTACHVGGGTATCTAATCC
  ```
* Using fungi tax IDs (requires additional ITS amplicon-specific parameters to adjust the amplicon size)

  ```
  zamp insilico -i zamp/data/fungi-taxa.txt \
  -db unite_db_v10 \
  --fw-primer CYHRGYYATTTAGAGGWMSTAA --rv-primer RCKDYSTTCWTCRWYGHTGB \
  --minlen 50 --maxlen 900
  ```
* Using a query term. In this example, 100 assemblies will be downloaded per taxon (`nb 100`) including non-reference assemblies (not-only-ref):

  ```
  zamp insilico -i "lactobacillus" \
  -db ezbiocloud \
  --fw-primer CCTACGGGNGGCWGCAG --rv-primer GACTACHVGGGTATCTAATCC \
  --replace-empty -nb 100 --not-only-ref
  ```

## Output[¶](#output "Link to this heading")

The pipeline gathers information on available assemblies for the requested taxIDs in the assembly\_finder folder.

The output of the in-silico amplification is in Insilico folder, and contains the following subfolders:

* PCR: contains the output of in-silico PCR amplification
* 2\_denoised: output of clustering and denoising into representative sequences, and count tables
* 3\_classified: output of taxonomic classification and tables comparing expected and obtained taxonomic assignations (InSilico\_compare\_tax.tsv and InSilico\_compare\_tax\_long.tsv.)

# [zAMP](../index.html)

### Navigation

* [Installation and resource requirements](setup.html)
* [Taxonomic reference databases](ref_DB_preprocessing.html)
* [Running zAMP](execution.html)
* [Under the hood](under_the_hood.html)
* [Downstream Analysis](downstream_analysis.html)
* [Frequently asked questions (FAQ)](FAQ.html)
* *In silico* validation tool
  + [Aim](#aim)
  + [Working principle](#working-principle)
  + [Inputs](#inputs)
  + [Execution](#execution)
  + [Output](#output)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Frequently asked questions (FAQ)](FAQ.html "previous chapter")

©2020, MetaGenLab.
|
Powered by [Sphinx 8.2.3](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](../_sources/pages/insilico_validation.rst.txt)