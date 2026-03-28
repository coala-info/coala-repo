# Padlock

Design padlock probes for in-situ sequencing.

 [Get help](https://www.gear-genomics.com/contact)  ·  [Citation](https://www.gear-genomics.com/citation)  ·  [Source](https://github.com/gear-genomics/padlock)

* [Input](#input-tab)
* [Results](#result-tab)
* [Help](#help-tab)

##### Source sequences for target design

Ensembl gene/transcript name(s) or FASTA sequence
 ENSG00000171862

Attribute identifier  gene\_id transcript\_id

Feature identifier  exon CDS gene transcript three\_prime\_utr five\_prime\_utr

FASTA input: Source sequence is absent in reference genome:  [ ]

##### Probe design

Probe arm length

Min. genome distance  0 1

Use hamming distance (default is edit distance):  [ ]

Only one arm needs to be unique (default is both arms):  [ ]

Allow overlapping probes (default is non-overlapping):  [ ]

##### Color codes and pre-defined or custom barcodes

Amount of colors  2 3 4 5 6 7 8

Length of code  2 3 4 5 6 7 8

Custom barcodes
 Color code and barcode file in FASTA format (`.fa`, `.fa.gz`). Example:
  `>143312
 TCAGGCTAGTGTCCAACGGA
 >112431
 AAATCCGATCGGCCTAACGG`

##### Anchor and spacer sequences

Anchor
 TGCGTCTATTTAGTGGAGCC

Spacer left
 TCCTC

Spacer right
 TCTTT

Select genome

Genomes not loaded!

  Launch Analysis    Show Example

Analysis is running, please be patient.

Download tsv

#### Padlock probes

#### Application Description

Padlock is a method to design probes for in-situ sequencing.

#### Accepted Input

You need to input Ensembl gene (e.g., ENSG00000232810) or transcript identifiers (e.g., ENST00000700026). For gene identifiers use "gene\_id" as attribute and "transcript\_id" for transcript identifiers. Gene symbols are currently not supported. Alternatively, you can also input a FASTA sequence with a header like ">Input" followed by the actual sequence. For FASTA input, you need to specify whether the sequence is present in the genome (default) or absent.

#### Sample Data

The "Show Example" button loads an example reference genome with matching Ensembl gene identifiers.

[GEAR ~](https://www.gear-genomics.com)  ·  ·  [Terms of Use](https://www.gear-genomics.com/terms)  ·  [Contact Us](https://www.gear-genomics.com/contact)

Supported by  [![EMBL logo](embl.fe35cb76.svg)](https://www.embl.de/)