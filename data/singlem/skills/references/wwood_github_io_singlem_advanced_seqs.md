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

# singlem seqs

This mode is an integral part of creating a new SingleM package from scratch. The purpose of the mode is to choose where in the HMM is the best place for a starting window. At the moment this means the most conserved stretch.

The best position output is the one that has the most nucleic acids that overlap the HMM at the window starting at that position.

The input is an alignment created by applying the HMMER tool `hmmalign`, which is converted to FASTA format using [seqmagick](https://github.com/fhcrc/seqmagick) `convert`.

The window positions in the default SingleM packages were chosen through this method, supplying an alignment created from the reads of a complex soil metagenome. Whole gene sequences may also be appropriate as input (after alignment).

Once a best window position is chosen through this process, [singlem create](/singlem/advanced/create) is used to finalise creation of the SingleM package.

# OPTIONS

**--alignment** aligned\_fasta

Protein sequences hmmaligned and converted to fasta format with
seqmagick

**--alignment-type** type

alignment is 'aa' or 'dna'

**--window-size** INT

Number of nucleotides to use in continuous window [default: 60]

**--hmm** *HMM*

HMM file used to generate alignment, used here to rank windows
according to their information content.

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

* [singlem seqs](#singlem-seqs)
* [OPTIONS](#options)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [AUTHORS](#authors)

Powered by [Doctave](https://cli.doctave.com)