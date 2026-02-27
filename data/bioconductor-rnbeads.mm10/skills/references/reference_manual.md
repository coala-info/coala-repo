Package ‘RnBeads.mm10’

February 26, 2026

Title RnBeads.mm10

Description Automatically generated RnBeads annotation package for the assembly mm10.

Author RnBeads Team

Maintainer RnBeads Team <team@rnbeads.org>

Date 2021-11-21

License GPL-3

Version 2.18.0

Depends R (>= 3.5.0), GenomicRanges

Suggests RnBeads

git_url https://git.bioconductor.org/packages/RnBeads.mm10

git_branch RELEASE_3_22

git_last_commit f468d9a

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

mm10 .

.

.

.

.

.

.

.

.

.

.

. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

mm10

Annotation tables for mm10

Description

Scaffold of annotation tables for the mm10 assembly. This structure is automatically loaded upon
initialization of the annotation, that is, by the first valid call to any of the following functions:
rnb.get.assemblies, rnb.get.chromosomes, rnb.get.annotation, rnb.set.annotation, rnb.get.mapping,
rnb.annotation.size. Adding an annotation amounts to attaching its table(s) and mapping struc-
tures to this scaffold.

1

2

Format

mm10

list of up to six elements - "GENOME", "CHROMOSOMES", "regions", "sites", "controls" and
"mappings". These elements are described below.

"GENOME" Name of the Bioconductor package that contains the genomic sequence for this genome

assembly.

"CHROMOSOMES" Supported chromosomes for this genome assembly. The elements of this character

vector follow the Ensembl convention ("1", "2", ...), and the names of this vector - the con-
vention of the UCSC Genome Browser ("chr1", "chr2", ...).

"regions" list of NULLs; the names of the elements correspond to the built-in region annotation
tables. Once the default annotations are loaded, the attribute "builtin" is a logical vector
storing, for each region annotation, whether it is the default (built-in) or custom.

"sites" list of NULLs; the names of the elements correspond to the site and probe annotation

tables.

"controls" list of NULLs; the names of the elements correspond to the control probe annota-
tion tables. The attribute "sites" is a character vector pointing to the site annotation that
encompasses the respective control probes.

"mappings" list of NULLs; the names of the elements correspond to the built-in region annotation

tables.

Author(s)

RnBeads Annotation Creator

Index

∗ datasets

mm10, 1

mm10, 1

regions (mm10), 1
rnb.annotation.size, 1
rnb.get.annotation, 1
rnb.get.assemblies, 1
rnb.get.chromosomes, 1
rnb.get.mapping, 1
rnb.set.annotation, 1

sites (mm10), 1

3

