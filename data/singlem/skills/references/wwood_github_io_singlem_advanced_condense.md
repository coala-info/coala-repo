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

# singlem condense

# DESCRIPTION

Combine OTU tables across different markers into a single taxonomic
profile. Note that while this mode can be run independently, it is often
more straightforward to invoke its methodology by specifying -p /
--taxonomic- profile when running pipe mode.

# OPTIONS

# INPUT ARGUMENTS (1+ REQUIRED)

**--input-archive-otu-tables**, **--input-archive-otu-table** *INPUT\_ARCHIVE\_OTU\_TABLES* [*INPUT\_ARCHIVE\_OTU\_TABLES* ...]

Condense from these archive tables

**--input-archive-otu-table-list** *INPUT\_ARCHIVE\_OTU\_TABLE\_LIST*

Condense from the archive tables newline separated in this file

**--input-gzip-archive-otu-table-list** *INPUT\_GZIP\_ARCHIVE\_OTU\_TABLE\_LIST*

Condense from the gzip'd archive tables newline separated in this
file

# OUTPUT ARGUMENTS (1+ REQUIRED)

**-p**, **--taxonomic-profile** filename

output OTU table

**--taxonomic-profile-krona** filename

name of krona file to generate.

**--output-after-em-otu-table** filename

output OTU table after expectation maximisation has been applied.
Note that this table usually contains multiple rows with the same
window sequence.

# OTHER OPTIONS

**--metapackage** *METAPACKAGE*

Set of SingleM packages to use [default: use the default set]

**--min-taxon-coverage** FRACTION

Set taxons with less coverage to coverage=0. [default: 0.35]

**--trim-percent** *TRIM\_PERCENT*

percentage of markers to be trimmed for each taxonomy [default:
10]

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

* [singlem condense](#singlem-condense)
* [DESCRIPTION](#description)
* [OPTIONS](#options)
* [INPUT ARGUMENTS (1+ REQUIRED)](#input-arguments-(1+-required))
* [OUTPUT ARGUMENTS (1+ REQUIRED)](#output-arguments-(1+-required))
* [OTHER OPTIONS](#other-options)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [AUTHORS](#authors)

Powered by [Doctave](https://cli.doctave.com)