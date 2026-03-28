[ENASearch](index.html)

0.2.0

ENASearch documentation

* [Installation](installation.html)
* [Some example of usage](use_case.html)
* Interacting with ENA Database
  + [Data](#data)
  + [Programmatic access](#programmatic-access)
* [Usage with command-line](cli_usage.html)
* [Usage within Python](api_usage.html)
* [Contributing](contributing.html)
* [Source code on GitHub](https://github.com/bebatut/enasearch)

[ENASearch](index.html)

* [Docs](index.html) »
* Interacting with ENA Database

---

# Interacting with ENA Database[¶](#interacting-with-ena-database "Permalink to this headline")

## Data[¶](#data "Permalink to this headline")

Data in ENA are organzed into 11 domains (or type):

| Domain | Description |
| --- | --- |
| Assembly | Information describing the construction of reads and sequence contigs into higher order scaffolds and chromosomes |
| Sequence | Assembled and, optionally, annotated assembled reads |
| Coding | A virtual domain comprising sequence regions reported by data providers as being protein-coding regions |
| Non-coding | A virtual domain comprising sequence regions reported by data providers as representing non-protein-coding (RNA) genes |
| Marker | A virtual domain comprising information relating to phylogenetic, identification and molecular ecology marker data |
| Analysis | Derived data forms, such as recalibrated aligned reads and metabarcoding identifications |
| Read | Raw sequencing reads from next generation platforms |
| Trace | Raw sequencing data from capillary platforms |
| Taxon | Information relating to the organism that was the source of the sequenced biological sample |
| Sample | Information relating to the biological sample studied in the sequencing experiment |
| Study | Information relating to the scope of the sequencing effort; also known as ‘Project’, the primary use of study is to unite content otherwise dispersed across the ENA domains |

Each domains are further subdivided in some cases into data classes. It is the results that can be accessed:

| Domain | Result | Description |
| --- | --- | --- |
| Assembly | assembly | Genome assemblies |
| Sequence | sequence\_release | Nucleotide sequences (Release) |
| sequence\_update | Nucleotide sequences (Update) |
| wgs\_set | Genome assembly contig sets (WGS) |
| tsa\_set | Transcriptome assembly contig sets (TSA) |
| Coding | coding\_release | Protein coding sequences (Release) |
| coding\_update | Protein coding sequences (Update) |
| Non-coding | noncoding\_release | Non-coding sequences (Release) |
| noncoding\_update | Non-coding sequences (Update) |
| Analysis | analysis\_study | Studies used for nucleotide sequence analyses from reads |
| analysis | Nucleotide sequence analyses from reads |
| Read | read\_experiment | Experiments used for raw reads |
| read\_run | Raw reads |
| read\_study | Studies used for raw reads |
| Sample | sample | Samples |
| Taxon | taxon | Taxonomic classfication |
| Environmental | environmental | Environmental samples |
| Study | Study | Studies |

This list can be accessed with get\_results.

Each “result” can be searched, the outputs can be formatted and sorted given different fields. These fields are accessible via the commands:

* get\_filter\_fields to obtain the fields to build a query or filter (more information about the type of these filters with get\_filter\_types)
* get\_returnable\_fields to obtain the fields extractable for a result
* get\_sortable\_fields to obtain the fields usable to sort the outputs

## Programmatic access[¶](#programmatic-access "Permalink to this headline")

The data on ENA can be accessed programmatically, in ENASearch:

* ENA database can be queried via search\_data
* Data with an accession id can be retrieved via retrieve\_data

  > This function can not be used to
  >
  > + Retrieve taxonomic data
  >
  >   > It must be done via the taxon portal with retrieve\_taxons. The taxonomy results can be accessed via get\_taxonomy\_results
  > + Retrieve a run file report via a study accession (ERP, SRP, DRP, PRJ prefixes), experiment accession (ERX, SRX, DRX prefixes), sample accessions (ERS, SRS, DRS, SAM prefixes) or a run accessions (ERR, SRR, DRR prefixes)
  >
  >   > retrieve\_run\_report is used then. The fields accessible for the run report can be obtained with get\_run\_fields
  > + Retrieve an analysis report via a study accession (ERP, SRP, DRP, PRJ prefixes), sample accession (ERS, SRS, DRS, SAM prefixes) or analysis accession (ERZ, SRZ, DRZ prefixes)
  >
  >   > retrieve\_analysis\_report is used then. The fields accessible for the run report can be obtained with get\_analysis\_fields

[Next](cli_usage.html "Usage with command-line")
 [Previous](use_case.html "Some example of usage")

---

© Copyright 2017, Bérénice Batut.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).