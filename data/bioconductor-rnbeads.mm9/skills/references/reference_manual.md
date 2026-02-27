Package ‘RnBeads.mm9’

February 26, 2026

Title RnBeads.mm9

Description Automatically generated RnBeads annotation package for the assembly mm9.

Author RnBeadsAnnotationCreator

Maintainer RnBeadsAnnotationCreator <rnbeads@mpi-inf.mpg.de>

Date 2021-11-21

License GPL-3

Version 1.42.0

Depends R (>= 3.0.0), GenomicRanges

Suggests RnBeads

NeedsCompilation no

git_url https://git.bioconductor.org/packages/RnBeads.mm9

git_branch RELEASE_3_22

git_last_commit c3692d0

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

mm9 .

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

.

. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Index

mm9

Description

Annotation tables for mm9

1

3

Scaffold of annotation tables for the mm9 assembly. This structure is automatically loaded upon
initialization of the annotation, that is, by the first valid call to any of the following functions:
rnb.get.assemblies, rnb.get.chromosomes, rnb.get.annotation, rnb.set.annotation, rnb.get.mapping,
rnb.annotation.size. Adding an annotation amounts to attaching its table(s) and mapping struc-
tures to this scaffold.

1

2

Format

mm9

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
mm9, 1

mm9, 1

regions (mm9), 1
rnb.annotation.size, 1
rnb.get.annotation, 1
rnb.get.assemblies, 1
rnb.get.chromosomes, 1
rnb.get.mapping, 1
rnb.set.annotation, 1

sites (mm9), 1

3

