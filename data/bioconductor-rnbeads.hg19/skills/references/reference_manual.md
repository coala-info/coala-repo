Package ‘RnBeads.hg19’

February 26, 2026

Title RnBeads.hg19

Description Automatically generated RnBeads annotation package for the assembly hg19.

Author RnBeadsAnnotationCreator

Maintainer RnBeadsAnnotationCreator <rnbeads@mpi-inf.mpg.de>

Date 2021-11-21

License GPL-3

Version 1.42.0

Depends R (>= 3.0.0), GenomicRanges

Suggests RnBeads

NeedsCompilation no

RoxygenNote 6.0.1

git_url https://git.bioconductor.org/packages/RnBeads.hg19

git_branch RELEASE_3_22

git_last_commit cb8d172

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

.
.

.
.

.
.

.
.
hg19 .
.
regions .
.
.
rnb.set.example .
.
.
.
sites .

.

.

.

Index

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
.

.
.
.
.

.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .

2
2
3
3

4

1

2

regions

hg19

HG19 - Annotation tables

Description

Scaffold of annotation tables for HG19. This structure is automatically loaded upon initialization of
the annotation, that is, by the first valid call to any of the following functions: rnb.get.assemblies,
rnb.get.chromosomes, rnb.get.annotation, rnb.set.annotation, rnb.get.mapping, rnb.annotation.size.
Adding an annotation amounts to attaching its table(s) and mapping structures to this scaffold.

Format

list of four elements - "regions", "sites", "controls" and "mappings". These elements are
described below.

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

Yassen Assenov

regions

Names of the regions

Description

This a a list of all regions available for the annotation.

Usage

regions

Format

list of NULLs; the names of the elements correspond to the built-in region annotation tables. Once
the default annotations are loaded, the attribute "builtin" is a logical vector storing, for each
region annotation, whether it is the default (built-in) or custom.

Author(s)

Michael Scherer

rnb.set.example

3

rnb.set.example

Example Data Set

Description

A small example dataset for testing RnBeads’ basic functionality.

Usage

data(small.example.object)

Format

RnBeadRawSet-class object with 12 samples and 1,736 sites. It is an example object obtained
from Illumina Infinium 450K BeadChip and contains coverage, intensity, and detection p-values.
No preprocessing steps have been performed.

Author(s)

Michael Scherer

sites

Names of the sites

Description

This a a list of all sites available for the annotation.

Usage

sites

Format

list of NULLs; the names of the elements correspond to the site and probe annotation tables.

Author(s)

Michael Scherer

Index

∗ datasets

hg19, 2
regions, 2
rnb.set.example, 3
sites, 3

hg19, 2

regions, 2
rnb.annotation.size, 2
rnb.get.annotation, 2
rnb.get.assemblies, 2
rnb.get.chromosomes, 2
rnb.get.mapping, 2
rnb.set.annotation, 2
rnb.set.example, 3

sites, 3

4

