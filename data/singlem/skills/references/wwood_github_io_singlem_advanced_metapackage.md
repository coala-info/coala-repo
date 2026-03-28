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

# singlem metapackage

# DESCRIPTION

Create or describe a metapackage (i.e. set of SingleM packages)

# OPTIONS

**--metapackage** *METAPACKAGE*

Path to write generated metapackage to

**--singlem-packages** *SINGLEM\_PACKAGES* [*SINGLEM\_PACKAGES* ...]

Input packages

**--nucleotide-sdb** *NUCLEOTIDE\_SDB*

Nucleotide SingleM database for initial assignment pass

**--no-nucleotide-sdb**

Skip nucleotide SingleM database

**--taxon-genome-lengths** *TAXON\_GENOME\_LENGTHS*

TSV file of genome lengths for each taxon

**--no-taxon-genome-lengths**

Skip taxon genome lengths

**--taxonomy-database-name** *TAXONOMY\_DATABASE\_NAME*

Name of the taxonomy database to use [default:
custom\_taxonomy\_database]

**--taxonomy-database-version** *TAXONOMY\_DATABASE\_VERSION*

Version of the taxonomy database to use [default: unspecified]

**--diamond-prefilter-performance-parameters** *DIAMOND\_PREFILTER\_PERFORMANCE\_PARAMETERS*

Performance-type arguments to use when calling 'diamond blastx'
during the prefiltering. [default: '--block-size 0.5
--target-indexed -c1']

**--diamond-taxonomy-assignment-performance-parameters** *DIAMOND\_TAXONOMY\_ASSIGNMENT\_PERFORMANCE\_PARAMETERS*

Performance-type arguments to use when calling 'diamond blastx'
during the taxonomy assignment. [default: '--block-size 0.5
--target-indexed -c1']

**--describe**

Describe a metapackage rather than create it

**--threads** num\_threads

number of CPUS to use [default: 1]

**--prefilter-clustering-threshold** fraction

ID for dereplication of prefilter DB [default: 0.6]

**--prefilter-diamond-db** DMND

Dereplicated DIAMOND db for prefilter to use [default: dereplicate
from input SingleM packages]

**--makeidx-sensitivity-params** PARAMS

DIAMOND sensitivity parameters to use when indexing the prefilter
DIAMOND db. [default: None]

**--calculate-average-num-genes-per-species**

Calculate the average number of genes per species in the
metapackage. [default: False]

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

* [singlem metapackage](#singlem-metapackage)
* [DESCRIPTION](#description)
* [OPTIONS](#options)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [AUTHORS](#authors)

Powered by [Doctave](https://cli.doctave.com)