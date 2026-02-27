Package ‘QDNAseq.hg19’
February 26, 2026

Type Package

Title QDNAseq bin annotation for hg19

Version 1.40.0

Date 2015-09-30

Author Daoud Sie [aut, cre]
Maintainer Daoud Sie <d.sie@vumc.nl>

Description This package provides QDNAseq bin annotations for the

human genome build hg19.

Depends R (>= 3.2.1), QDNAseq

biocViews ExperimentData, OrganismData, Homo_sapiens_Data

License GPL

URL https://github.com/tgac-vumc/QDNAseq.hg19

BugReports https://github.com/tgac-vumc/QDNAseq.hg19/issues

NeedsCompilation no

git_url https://git.bioconductor.org/packages/QDNAseq.hg19

git_branch RELEASE_3_22

git_last_commit b299eca

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

QDNAseq.hg19-package .
.
hg19.1000kbp.SR50 .
.
.
hg19.100kbp.SR50 .
.
.
.
hg19.10kbp.SR50 .
.
.
.
hg19.15kbp.SR50 .
.
.
.
hg19.1kbp.SR50 .
.
.
hg19.30kbp.SR50 .
.
.
.
hg19.500kbp.SR50 .
.
.
.
hg19.50kbp.SR50 .
.
.
.
hg19.5kbp.SR50 .

.
.
.
.
.
.
.
.
.

2
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
2
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
6
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
8
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11

Index

13

1

2

hg19.1000kbp.SR50

QDNAseq.hg19-package

Package QDNAseq.hg19

Description

This package provides QDNAseq binannotations for the mouse genome build hg19 for bin sizes 1,
5, 10, 15, 30, 50, 100, 500 and 1000 kbp (kilobasepair).

The datasets are named as follows:

hg19.1kbp.SR50
hg19.5kbp.SR50
hg19.10kbp.SR50
hg19.15kbp.SR50
hg19.30kbp.SR50
hg19.50kbp.SR50
hg19.100kbp.SR50
hg19.500kbp.SR50
hg19.1000kbp.SR50

License

This package is licensed under GPL.

Author(s)

Daoud Sie

Examples

data("hg19.30kbp.SR50")
assign("bins", get("hg19.30kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=30, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

hg19.1000kbp.SR50

Hg19 1000kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 1000kbp bins generated as described in Scheinin
et al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,

• start: Base pair start position,

• end: Base pair end position,

hg19.1000kbp.SR50

3

• bases: Percentage of non-N nucleotides (of full bin size),

• gc: Percentage of C and G nucleotides (of non-N nucleotides),

• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (see references),

• residual: Median loess residual calculated from 1000 Genomes (see references),

• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

An integrated map of genetic variation from 1,092 human genomes. 1000 Genomes Project Con-
sortium, Abecasis GR, Auton A, Brooks LD, DePristo MA, Durbin RM, Handsaker RE, Kang HM,
Marth GT, McVean GA 2012 Nature Nov 1; 491(7422):56–65.

An integrated encyclopedia of DNA elements in the human genome. ENCODE Project Consortium
2012 Nature Sep 6; 489(7414):57–74.

Examples

data("hg19.1000kbp.SR50")
assign("bins", get("hg19.1000kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=1000, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

4

hg19.100kbp.SR50

hg19.100kbp.SR50

Hg19 100kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 100kbp bins generated as described in Scheinin
et al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,

• start: Base pair start position,

• end: Base pair end position,

• bases: Percentage of non-N nucleotides (of full bin size),

• gc: Percentage of C and G nucleotides (of non-N nucleotides),

• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (see references),

• residual: Median loess residual calculated from 1000 Genomes (see references),

• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

An integrated map of genetic variation from 1,092 human genomes. 1000 Genomes Project Con-
sortium, Abecasis GR, Auton A, Brooks LD, DePristo MA, Durbin RM, Handsaker RE, Kang HM,
Marth GT, McVean GA 2012 Nature Nov 1; 491(7422):56–65.

An integrated encyclopedia of DNA elements in the human genome. ENCODE Project Consortium
2012 Nature Sep 6; 489(7414):57–74.

hg19.10kbp.SR50

Examples

5

data("hg19.100kbp.SR50")
assign("bins", get("hg19.100kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=100, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

hg19.10kbp.SR50

Hg19 10kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 10kbp bins generated as described in Scheinin
et al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,
• start: Base pair start position,
• end: Base pair end position,
• bases: Percentage of non-N nucleotides (of full bin size),
• gc: Percentage of C and G nucleotides (of non-N nucleotides),
• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (see references),
• residual: Median loess residual calculated from 1000 Genomes (see references),
• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

An integrated map of genetic variation from 1,092 human genomes. 1000 Genomes Project Con-
sortium, Abecasis GR, Auton A, Brooks LD, DePristo MA, Durbin RM, Handsaker RE, Kang HM,
Marth GT, McVean GA 2012 Nature Nov 1; 491(7422):56–65.

An integrated encyclopedia of DNA elements in the human genome. ENCODE Project Consortium
2012 Nature Sep 6; 489(7414):57–74.

hg19.15kbp.SR50

6

Examples

data("hg19.10kbp.SR50")
assign("bins", get("hg19.10kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=10, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

hg19.15kbp.SR50

Hg19 15kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 15kbp bins generated as described in Scheinin
et al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,
• start: Base pair start position,
• end: Base pair end position,
• bases: Percentage of non-N nucleotides (of full bin size),
• gc: Percentage of C and G nucleotides (of non-N nucleotides),
• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (see references),
• residual: Median loess residual calculated from 1000 Genomes (see references),
• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

An integrated map of genetic variation from 1,092 human genomes. 1000 Genomes Project Con-
sortium, Abecasis GR, Auton A, Brooks LD, DePristo MA, Durbin RM, Handsaker RE, Kang HM,
Marth GT, McVean GA 2012 Nature Nov 1; 491(7422):56–65.

An integrated encyclopedia of DNA elements in the human genome. ENCODE Project Consortium
2012 Nature Sep 6; 489(7414):57–74.

hg19.1kbp.SR50

Examples

7

data("hg19.15kbp.SR50")
assign("bins", get("hg19.15kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=15, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

hg19.1kbp.SR50

Hg19 1kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 1kbp bins generated as described in Scheinin et
al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,
• start: Base pair start position,
• end: Base pair end position,
• bases: Percentage of non-N nucleotides (of full bin size),
• gc: Percentage of C and G nucleotides (of non-N nucleotides),
• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (see references),
• residual: Median loess residual calculated from 1000 Genomes (see references),
• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

An integrated map of genetic variation from 1,092 human genomes. 1000 Genomes Project Con-
sortium, Abecasis GR, Auton A, Brooks LD, DePristo MA, Durbin RM, Handsaker RE, Kang HM,
Marth GT, McVean GA 2012 Nature Nov 1; 491(7422):56–65.

An integrated encyclopedia of DNA elements in the human genome. ENCODE Project Consortium
2012 Nature Sep 6; 489(7414):57–74.

hg19.30kbp.SR50

8

Examples

data("hg19.1kbp.SR50")
assign("bins", get("hg19.1kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=1, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

hg19.30kbp.SR50

Hg19 30kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 30kbp bins generated as described in Scheinin
et al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,
• start: Base pair start position,
• end: Base pair end position,
• bases: Percentage of non-N nucleotides (of full bin size),
• gc: Percentage of C and G nucleotides (of non-N nucleotides),
• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (see references),
• residual: Median loess residual calculated from 1000 Genomes (see references),
• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

An integrated map of genetic variation from 1,092 human genomes. 1000 Genomes Project Con-
sortium, Abecasis GR, Auton A, Brooks LD, DePristo MA, Durbin RM, Handsaker RE, Kang HM,
Marth GT, McVean GA 2012 Nature Nov 1; 491(7422):56–65.

An integrated encyclopedia of DNA elements in the human genome. ENCODE Project Consortium
2012 Nature Sep 6; 489(7414):57–74.

hg19.500kbp.SR50

Examples

9

data("hg19.30kbp.SR50")
assign("bins", get("hg19.30kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=30, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

hg19.500kbp.SR50

Hg19 500kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 500kbp bins generated as described in Scheinin
et al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,
• start: Base pair start position,
• end: Base pair end position,
• bases: Percentage of non-N nucleotides (of full bin size),
• gc: Percentage of C and G nucleotides (of non-N nucleotides),
• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (see references),
• residual: Median loess residual calculated from 1000 Genomes (see references),
• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

An integrated map of genetic variation from 1,092 human genomes. 1000 Genomes Project Con-
sortium, Abecasis GR, Auton A, Brooks LD, DePristo MA, Durbin RM, Handsaker RE, Kang HM,
Marth GT, McVean GA 2012 Nature Nov 1; 491(7422):56–65.

An integrated encyclopedia of DNA elements in the human genome. ENCODE Project Consortium
2012 Nature Sep 6; 489(7414):57–74.

hg19.50kbp.SR50

10

Examples

data("hg19.500kbp.SR50")
assign("bins", get("hg19.500kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=500, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

hg19.50kbp.SR50

Hg19 50kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 50kbp bins generated as described in Scheinin
et al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,
• start: Base pair start position,
• end: Base pair end position,
• bases: Percentage of non-N nucleotides (of full bin size),
• gc: Percentage of C and G nucleotides (of non-N nucleotides),
• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (see references),
• residual: Median loess residual calculated from 1000 Genomes (see references),
• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

An integrated map of genetic variation from 1,092 human genomes. 1000 Genomes Project Con-
sortium, Abecasis GR, Auton A, Brooks LD, DePristo MA, Durbin RM, Handsaker RE, Kang HM,
Marth GT, McVean GA 2012 Nature Nov 1; 491(7422):56–65.

An integrated encyclopedia of DNA elements in the human genome. ENCODE Project Consortium
2012 Nature Sep 6; 489(7414):57–74.

hg19.5kbp.SR50

Examples

11

data("hg19.50kbp.SR50")
assign("bins", get("hg19.50kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=50, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

hg19.5kbp.SR50

Hg19 5kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 5kbp bins generated as described in Scheinin et
al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,
• start: Base pair start position,
• end: Base pair end position,
• bases: Percentage of non-N nucleotides (of full bin size),
• gc: Percentage of C and G nucleotides (of non-N nucleotides),
• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (see references),
• residual: Median loess residual calculated from 1000 Genomes (see references),
• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

An integrated map of genetic variation from 1,092 human genomes. 1000 Genomes Project Con-
sortium, Abecasis GR, Auton A, Brooks LD, DePristo MA, Durbin RM, Handsaker RE, Kang HM,
Marth GT, McVean GA 2012 Nature Nov 1; 491(7422):56–65.

An integrated encyclopedia of DNA elements in the human genome. ENCODE Project Consortium
2012 Nature Sep 6; 489(7414):57–74.

12

Examples

hg19.5kbp.SR50

data("hg19.5kbp.SR50")
assign("bins", get("hg19.5kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=5, genome="hg19")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

Index

∗ datasets

hg19.1000kbp.SR50, 2
hg19.100kbp.SR50, 4
hg19.10kbp.SR50, 5
hg19.15kbp.SR50, 6
hg19.1kbp.SR50, 7
hg19.30kbp.SR50, 8
hg19.500kbp.SR50, 9
hg19.50kbp.SR50, 10
hg19.5kbp.SR50, 11

∗ package

QDNAseq.hg19-package, 2

AnnotatedDataFrame, 3–11

hg19.1000kbp.SR50, 2
hg19.100kbp.SR50, 4
hg19.10kbp.SR50, 5
hg19.15kbp.SR50, 6
hg19.1kbp.SR50, 7
hg19.30kbp.SR50, 8
hg19.500kbp.SR50, 9
hg19.50kbp.SR50, 10
hg19.5kbp.SR50, 11

QDNAseq.hg19 (QDNAseq.hg19-package), 2
QDNAseq.hg19-package, 2

13

