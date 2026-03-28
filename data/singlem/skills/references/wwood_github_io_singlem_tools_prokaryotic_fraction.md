☰
[ ]

[![SingleM logo](/singlem/sandpiper.png)](/singlem/)

## [SingleM](/singlem/)

S

* [Lyrebird (phage profiling)](/singlem/Lyrebird)
* [Installation](/singlem/Installation)
* [Glossary](/singlem/Glossary)
* [FAQ](/singlem/FAQ)
* [Usage](/singlem/tools)

+ [SingleM data](/singlem/tools/data)
+ [SingleM pipe](/singlem/tools/pipe)
+ [SingleM summarise](/singlem/tools/summarise)
+ [SingleM renew](/singlem/tools/renew)
+ [SingleM supplement](/singlem/tools/supplement)
+ [SingleM prokaryotic\_fraction](/singlem/tools/prokaryotic_fraction)
+ [SingleM appraise](/singlem/tools/appraise)
+ [Lyrebird data](/singlem/tools/lyrebird_data)
+ [Lyrebird pipe](/singlem/tools/lyrebird_pipe)

* [Advanced modes](/singlem/advanced)

+ [SingleM query](/singlem/advanced/query)
+ [SingleM makedb](/singlem/advanced/makedb)
+ [SingleM condense](/singlem/advanced/condense)
+ [SingleM seqs](/singlem/advanced/seqs)
+ [SingleM create](/singlem/advanced/create)
+ [SingleM metapackage](/singlem/advanced/metapackage)
+ [SingleM regenerate](/singlem/advanced/regenerate)
+ [Lyrebird condense](/singlem/advanced/lyrebird_condense)
+ [Lyrebird renew](/singlem/advanced/lyrebird_renew)

# singlem prokaryotic\_fraction

The SingleM `prokaryotic_fraction` subcommand (previously called `microbial_fraction`) estimates the fraction of reads in a metagenome that are bacterial or archaeal, including their plasmids. The remaining fraction is either eukaryote- or phage-derived. We denote this fraction as the SingleM "prokaryotic fraction" of a metagenome, or its *SPF*.

It can help prioritise samples for deeper sequencing, forecast how much sequencing is required for a given set of samples, and identify problematic steps in genome-resolved metagenomic pipelines, for instance.

SingleM `prokaryotic_fraction` also estimates the average genome size (AGS) of prokaryotic cells in the sample.

The main conceptual advantage of this method over other tools is that it does not require reference sequences of the non-prokaryotic genomes that may be present (e.g. those of an animal host). Instead, it uses a SingleM taxonomic profile of the metagenome to "add up" the components of the community which are prokaryotic. The remaining components are non-prokaryotic e.g. host, diet, or phage.

Roughly, the number of prokaryotic bases is estimated by summing the genome sizes of each species/taxon after multiplying by their coverage in a taxonomic profile. The prokaryotic fraction is then calculated as the ratio of prokaryotic bases to the total metagenome size. It does not estimate which reads are prokaryotic, but merely what fraction of the reads are prokaryotic.

## Usage

To run `prokaryotic_fraction`, first run `pipe` on your metagenome.

```
$ singlem pipe --forward SRR9841429_1.fastq.gz \
    --reverse SRR9841429_2.fastq.gz \
    --threads 32 \
    -p SRR9841429.profile
```

Then run `prokaryotic_fraction` on the profile.

```
singlem prokaryotic_fraction --forward SRR9841429_1.fastq.gz \
    --reverse SRR9841429_2.fastq.gz \
    -p SRR9841429.profile >SRR9841429.spf.tsv
```

The output you get is a tab-separated values file containing (with some columns omitted):

| sample | bacterial\_archaeal\_bases | metagenome\_size | read\_fraction | .. |
| --- | --- | --- | --- | --- |
| SRR9841429\_1 | 2059301599 | 2648177782 | 77.76 | .. |

So, for this sample, 77.76% of the reads are estimated to be prokaryotic.

A full table is shown below for this one sample, transposed for formatting:

| header | value |
| --- | --- |
| sample | SRR9841429\_1 |
| bacterial\_archaeal\_bases | 2059301599 |
| metagenome\_size | 2648177782 |
| read\_fraction | 77.76 |
| average\_bacterial\_archaeal\_genome\_size | 3448186 |
| warning |  |
| domain\_relative\_abundance | 1.10 |
| phylum\_relative\_abundance | 0.65 |
| class\_relative\_abundance | 1.72 |
| order\_relative\_abundance | 0.54 |
| family\_relative\_abundance | 1.03 |
| genus\_relative\_abundance | 8.01 |
| species\_relative\_abundance | 86.94 |

This table tells us that:

1. SingleM estimates 77.76% of the metagenome's reads are prokaryotic (the SPF).
2. The total number of bases assigned to prokaryotic genomes is 2,059,301,599.
3. The total number of bases in the metagenome is 2,648,177,782.
4. The estimated average genome size of the prokaryotic cells in the sample is 3,448,186 bp.
5. No warning about unreliability due to high prevalence of novel lineages was emitted (see below). The `warning` column is empty if no warning was emitted.
6. 1.10% of the profile is classified as domain level *and no further*. So 100-1.1=98.9% of the profile is classified to at least phylum level.
7. 0.65% of the profile is classified as phylum level *and no further*. So 100-1.1-0.65=98.25% of the profile is classified to at least class level.
8. and so on down to species level. 86.94% of the profile is classified to species level.

Note that the `read_fraction` and `relative_abundance` columns are percentages, i.e. 0.3 is 0.3%, not 30%.

## Warnings and limitations

The method is least reliable in simple communities consisting of a small number of species that are missing from the reference database. The main challenge in these cases is that the genome sizes of novel species are hard to estimate accurately. Multiplying a coverage from the taxonomic profile against an uncertain genome length equals an uncertain number of bases assigned as prokaryotic.

To detect such situations SingleM `prokaryotic_fraction` emits a warning when a sample's prokaryotic\_fraction estimate could under- or overestimate the read fraction. Specifically, the warning is emitted when the 3 highest abundance lineages not classified to the species level would change the estimated read fraction of the sample by >2% if their genome size is halved or doubled. Prokaryotic fractions are also capped at 100% since values greater than this are impossible, but the original value can be recovered from the output if you calculate `bacterial_archaeal_bases / metagenome_size`.

One current limitation of the approach relates to multi-copy plasmids. In `prokaryotic_fraction`, the genome size of each prokaryotic species is estimated as the sum of the chromosome and plasmid sizes, since these are the sequences available for each genome. However, in a metagenome, a species' plasmid may occur in multiple copies per cell (e.g. if the plasmid is 'high copy number'). SingleM `prokaryotic_fraction` does not account for plasmid copy number, leading to an underestimation of the prokaryotic fraction when plasmids are multi-copy. However, we consider this to be a minor issue, since plasmids are typically small compared to chromosomes. The average genome size estimate is unaffected by this limitation since by definition each plasmid counts only once regardless of its copy number.

# OPTIONS

# INPUT

**-p**, **--input-profile** *INPUT\_PROFILE*

Input taxonomic profile file [required]

# READ INFORMATION [1+ ARGS REQUIRED]

**-1**, **--forward**, **--reads**, **--sequences** sequence\_file [sequence\_file ...]

nucleotide read sequence(s) (forward or unpaired) to be searched.
Can be FASTA or FASTQ format, GZIP-compressed or not. These must be
the same ones that were used to generate the input profile.

**-2**, **--reverse** sequence\_file [sequence\_file ...]

reverse reads to be searched. Can be FASTA or FASTQ format,
GZIP-compressed or not. These must be the same reads that were used
to generate the input profile.

**--input-metagenome-sizes** *INPUT\_METAGENOME\_SIZES*

TSV file with 'sample' and 'num\_bases' as a header, where sample
matches the input profile name, and num\_reads is the total number
(forward+reverse) of bases in the metagenome that was analysed with
'pipe'. These must be the same reads that were used to generate
the input profile.

# DATABASE

**--taxon-genome-lengths-file** *TAXON\_GENOME\_LENGTHS\_FILE*

TSV file with 'rank' and 'genome\_size' as headers [default: Use
genome lengths from the default metapackage]

**--metapackage** *METAPACKAGE*

Metapackage containing genome lengths [default: Use genome lengths
from the default metapackage]

# OTHER OPTIONS

**--accept-missing-samples**

If a sample is missing from the input-metagenome-sizes file, skip
analysis of it without croaking.

**--output-tsv** *OUTPUT\_TSV*

Output file [default: stdout]

**--output-per-taxon-read-fractions** *OUTPUT\_PER\_TAXON\_READ\_FRACTIONS*

Output a fraction for each taxon to this TSV [default: Do not
output anything]

# OTHER GENERAL OPTIONS

**--debug**

output debug information

**--version**

output version information and quit

**--quiet**

only output errors

**--full-help**

print longer help message

**--full-help-roff**

print longer help message in ROFF (manpage) format

# AUTHORS

> ```
> Ben J. Woodcroft, Centre for Microbiome Research, School of Biomedical Sciences, Faculty of Health, Queensland University of Technology
> Samuel Aroney, Centre for Microbiome Research, School of Biomedical Sciences, Faculty of Health, Queensland University of Technology
> Raphael Eisenhofer, Centre for Evolutionary Hologenomics, University of Copenhagen, Denmark
> Rossen Zhao, Centre for Microbiome Research, School of Biomedical Sciences, Faculty of Health, Queensland University of Technology
> ```

On this page

* [singlem prokaryotic\_fraction](#singlem-prokaryotic_fraction)
* [Usage](#usage)
* [Warnings and limitations](#warnings-and-limitations)
* [OPTIONS](#options)
* [INPUT](#input)
* [READ INFORMATION [1+ ARGS REQUIRED]](#read-information-[-1+-args-required-])
* [DATABASE](#database)
* [OTHER OPTIONS](#other-options)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [AUTHORS](#authors)

Powered by [Doctave](https://cli.doctave.com)