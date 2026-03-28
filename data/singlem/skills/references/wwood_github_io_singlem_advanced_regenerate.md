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

# singlem regenerate

# DESCRIPTION

Update a SingleM package with new sequences and taxonomy (expert mode).

# OPTIONS

**--min-aligned-percent** percent

remove sequences from the alignment which do not cover this
percentage of the HMM [default: 10]

**--window-position** *WINDOW\_POSITION*

change window position of output package [default: do not change]

**--sequence-prefix** *SEQUENCE\_PREFIX*

add a prefix to sequence names

**--candidate-decoy-sequences**, **--euk-sequences** *CANDIDATE\_DECOY\_SEQUENCES*

candidate amino acid sequences fasta file to search for decoys

**--candidate-decoy-taxonomy**, **--euk-taxonomy** *CANDIDATE\_DECOY\_TAXONOMY*

tab-separated sequence ID to taxonomy file of candidate decoy
sequences

**--no-candidate-decoy-sequences**, **--no-further-euks**

Do not include any euk sequences beyond what is already in the
current SingleM package

# REQUIRED ARGUMENTS

**--input-singlem-package** PATH

input package path

**--output-singlem-package** PATH

output package path

**--input-sequences** *INPUT\_SEQUENCES*

all on-target amino acid sequences fasta file for new package

**--input-taxonomy** *INPUT\_TAXONOMY*

tab-separated sequence ID to taxonomy file of on-target sequence
taxonomy

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

* [singlem regenerate](#singlem-regenerate)
* [DESCRIPTION](#description)
* [OPTIONS](#options)
* [REQUIRED ARGUMENTS](#required-arguments)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [AUTHORS](#authors)

Powered by [Doctave](https://cli.doctave.com)