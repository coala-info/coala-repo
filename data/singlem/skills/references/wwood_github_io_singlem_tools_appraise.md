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

# singlem appraise

SingleM can be used to determine how much of a community is represented in an assembly or represented
by a set of genomes.

The assessment is carried out by comparing the set of OTU sequences in the
assembly/genomes to those found from the raw metagenomic reads. A similar metric
can be estimated by the fraction of reads mapping to either the assembly or the
genome, but the approach here is more flexible and has several advantages:

1. We can determine which specific lineages are missing
2. We can match OTU sequences imperfectly, so we can e.g. make statements about whether a genus level representative genome has been recovered
3. Since the metric assesses only single copy marker genes, the appraisal is on a per-cell basis, not per-read
4. Some care must be taken, but we can prevent Eukaryotic DNA from skewing the estimate

To assess how well a set of sequences represent a metagenome, first run `pipe`
on both the genomes and the raw reads, and then use `appraise`:

```
singlem pipe --sequences raw.fq.gz --otu-table metagenome.otu_table.csv
singlem pipe --genome-fasta-files my-genomes/*.fasta --otu-table \
    genomes.otu_table.csv
singlem appraise --metagenome-otu-tables metagenome.otu_table.csv \
    --genome-otu-tables genomes.otu_table.csv
```

One may also accommodate some sequence differences, with `--imperfect`, or
output OTU tables of those sequences that match and those that do not (see
`singlem appraise -h`). Assessing assemblies is similar to assessing genomes,
except that when assessing bins duplicate markers from the same genome are
excluded as likely contamination.

An appraisal can also be represented visually, using `appraise --plot`:

![appraise plot](/singlem/appraise_plot.png)

Each rectangle represents a single OTU sequence where its size represents its
abundance (the number of reads that OTU represents in the metagenome). Colours
represent 89% OTU clustering of these sequences (~genus level), with the
taxonomy of the most common sequence written out. Here we see that highly
abundant OTUs in SRR5040536 were assembled, but only 1 of the 3 abundant
Gallionellales OTUs has an associated bin. As is common, the highest abundance
lineages did not necessarily assemble and bin successfully. The marker
`4.20.ribosomal_protein_S15P_S13e` was chosen as the representative marker
because it has a representative fraction of OTUs binned, assembled and
unassembled.

# INPUT OTU TABLE OPTIONS

**--metagenome-otu-tables** *METAGENOME\_OTU\_TABLES* [*METAGENOME\_OTU\_TABLES* ...]

output of 'pipe' run on metagenomes

**--metagenome-archive-otu-tables** *METAGENOME\_ARCHIVE\_OTU\_TABLES* [*METAGENOME\_ARCHIVE\_OTU\_TABLES* ...]

archive output of 'pipe' run on metagenomes

**--genome-otu-tables** *GENOME\_OTU\_TABLES* [*GENOME\_OTU\_TABLES* ...]

output of 'pipe' run on genomes

**--genome-archive-otu-tables** *GENOME\_ARCHIVE\_OTU\_TABLES* [*GENOME\_ARCHIVE\_OTU\_TABLES* ...]

archive output of 'pipe' run on genomes

**--assembly-otu-tables** *ASSEMBLY\_OTU\_TABLES* [*ASSEMBLY\_OTU\_TABLES* ...]

output of 'pipe' run on assembled sequence

**--assembly-archive-otu-tables** *ASSEMBLY\_ARCHIVE\_OTU\_TABLES* [*ASSEMBLY\_ARCHIVE\_OTU\_TABLES* ...]

archive output of 'pipe' run on assembled sequence

**--metapackage** *METAPACKAGE*

Metapackage used in the creation of the OTU tables

# INEXACT APPRAISAL OPTIONS

**--imperfect**

use sequence searching to account for genomes that are similar to
those found in the metagenome [default: False]

**--sequence-identity** *SEQUENCE\_IDENTITY*

sequence identity cutoff to use if --imperfect is specified
[default: ~species level divergence i.e. 0.9666666666666667]

# PLOTTING-RELATED OPTIONS

**--plot** *PLOT*

Output plot SVG filename (marker chosen automatically unless
--plot-marker is also specified)

**--plot-marker** *PLOT\_MARKER*

Marker gene to plot OTUs from

**--plot-basename** *PLOT\_BASENAME*

Plot visualisation of appraisal results from all markers to this
basename (one SVG per marker)

# OUTPUT SUMMARY OTU TABLES

**--output-binned-otu-table** *OUTPUT\_BINNED\_OTU\_TABLE*

output OTU table of binned populations

**--output-unbinned-otu-table** *OUTPUT\_UNBINNED\_OTU\_TABLE*

output OTU table of assembled but not binned populations

**--output-assembled-otu-table** *OUTPUT\_ASSEMBLED\_OTU\_TABLE*

output OTU table of all assembled populations

**--output-unaccounted-for-otu-table** *OUTPUT\_UNACCOUNTED\_FOR\_OTU\_TABLE*

Output OTU table of populations not accounted for

**--output-found-in**

Output sample name (genome or assembly) the hit was found in

**--output-style** {standard,archive}

Style of output OTU tables

**--stream-inputs**

Stream input OTU tables, saving RAM. Only works with
--output-otu-table and transformation options do not work [expert
option].

**--threads** num\_threads

Use this many threads when processing streaming inputs [default 1]

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

* [singlem appraise](#singlem-appraise)
* [INPUT OTU TABLE OPTIONS](#input-otu-table-options)
* [INEXACT APPRAISAL OPTIONS](#inexact-appraisal-options)
* [PLOTTING-RELATED OPTIONS](#plotting-related-options)
* [OUTPUT SUMMARY OTU TABLES](#output-summary-otu-tables)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [AUTHORS](#authors)

Powered by [Doctave](https://cli.doctave.com)