Package ‘QDNAseq.mm10’
February 26, 2026

Type Package

Title Bin annotation mm10

Version 1.40.0

Date 2015-09-30

Author Daoud Sie [aut, cre]
Maintainer Daoud Sie <d.sie@vumc.nl>

Description This package provides QDNAseq bin annotations for the

mouse genome build mm10.

Depends R (>= 3.2.1), QDNAseq

biocViews ExperimentData, OrganismData, Mus_musculus_Data

License GPL

URL https://github.com/tgac-vumc/QDNAseq.mm10

BugReports https://github.com/tgac-vumc/QDNAseq.mm10/issues

NeedsCompilation no

git_url https://git.bioconductor.org/packages/QDNAseq.mm10

git_branch RELEASE_3_22

git_last_commit 8b406e2

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

2
QDNAseq.mm10-package . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
mm10.1000kbp.SR50 .
.
4
.
mm10.100kbp.SR50 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
mm10.10kbp.SR50 .
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
mm10.15kbp.SR50 .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
mm10.1kbp.SR50 .
.
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
mm10.30kbp.SR50 .
.
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
mm10.500kbp.SR50 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
mm10.50kbp.SR50 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
.
mm10.5kbp.SR50 .

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

Index

13

1

2

mm10.1000kbp.SR50

QDNAseq.mm10-package

Package QDNAseq.mm10

Description

This package provides QDNAseq binannotations for the mouse genome build mm10 for bin sizes
1, 5, 10, 15, 30, 50, 100, 500 and 1000 kbp (kilobasepair).

The datasets are named as follows:

mm10.1kbp.SR50
mm10.5kbp.SR50
mm10.10kbp.SR50
mm10.15kbp.SR50
mm10.30kbp.SR50
mm10.50kbp.SR50
mm10.100kbp.SR50
mm10.500kbp.SR50
mm10.1000kbp.SR50

License

This package is licensed under GPL.

Author(s)

Daoud Sie

Examples

data("mm10.30kbp.SR50")
assign("bins", get("mm10.30kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=30, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

mm10.1000kbp.SR50

Mm10 1000kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 1000kbp bins generated as described in Scheinin
et al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,

• start: Base pair start position,

• end: Base pair end position,

mm10.1000kbp.SR50

3

• bases: Percentage of non-N nucleotides (of full bin size),

• gc: Percentage of C and G nucleotides (of non-N nucleotides),

• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (unused, ENCODE blacklist data

is not available for mouse),

• residual: Median loess residual calculated from normal C57BL/6J mouse samples from Gn-

erre et al. (see references),

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

High-quality draft assemblies of mammalian genomes from massively parallel sequence data. Gn-
erre S, Maccallum I, Przybylski D, Ribeiro F, Burton J, Walker B, Sharpe T, Hall G, Shea T, Sykes
S, Berlin A, Aird D, Costello M, Daza R, Williams L, Nicol R, Gnirke A, Nusbaum C, Lander E,
Jaffe D 2011 Proceedings of the National Academy of Sciences of the United States of America vol:
108 no. 4 1512–1518 doi: 10.1073/pnas.1017351108

Examples

data("mm10.1000kbp.SR50")
assign("bins", get("mm10.1000kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=1000, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

4

mm10.100kbp.SR50

mm10.100kbp.SR50

Mm10 100kbp bin annotations

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

• blacklist: Percent overlap with ENCODE blacklisted regions (unused, ENCODE blacklist data

is not available for mouse),

• residual: Median loess residual calculated from normal C57BL/6J mouse samples from Gn-

erre et al. (see references),

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

High-quality draft assemblies of mammalian genomes from massively parallel sequence data. Gn-
erre S, Maccallum I, Przybylski D, Ribeiro F, Burton J, Walker B, Sharpe T, Hall G, Shea T, Sykes
S, Berlin A, Aird D, Costello M, Daza R, Williams L, Nicol R, Gnirke A, Nusbaum C, Lander E,
Jaffe D 2011 Proceedings of the National Academy of Sciences of the United States of America vol:
108 no. 4 1512–1518 doi: 10.1073/pnas.1017351108

mm10.10kbp.SR50

Examples

5

data("mm10.100kbp.SR50")
assign("bins", get("mm10.100kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=100, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

mm10.10kbp.SR50

Mm10 10kbp bin annotations

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

• blacklist: Percent overlap with ENCODE blacklisted regions (unused, ENCODE blacklist data

is not available for mouse),

• residual: Median loess residual calculated from normal C57BL/6J mouse samples from Gn-

erre et al. (see references),

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

6

mm10.15kbp.SR50

High-quality draft assemblies of mammalian genomes from massively parallel sequence data. Gn-
erre S, Maccallum I, Przybylski D, Ribeiro F, Burton J, Walker B, Sharpe T, Hall G, Shea T, Sykes
S, Berlin A, Aird D, Costello M, Daza R, Williams L, Nicol R, Gnirke A, Nusbaum C, Lander E,
Jaffe D 2011 Proceedings of the National Academy of Sciences of the United States of America vol:
108 no. 4 1512–1518 doi: 10.1073/pnas.1017351108

Examples

data("mm10.10kbp.SR50")
assign("bins", get("mm10.10kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=10, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

mm10.15kbp.SR50

Mm10 15kbp bin annotations

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

• blacklist: Percent overlap with ENCODE blacklisted regions (unused, ENCODE blacklist data

is not available for mouse),

• residual: Median loess residual calculated from normal C57BL/6J mouse samples from Gn-

erre et al. (see references),

• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

mm10.1kbp.SR50

References

7

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

High-quality draft assemblies of mammalian genomes from massively parallel sequence data. Gn-
erre S, Maccallum I, Przybylski D, Ribeiro F, Burton J, Walker B, Sharpe T, Hall G, Shea T, Sykes
S, Berlin A, Aird D, Costello M, Daza R, Williams L, Nicol R, Gnirke A, Nusbaum C, Lander E,
Jaffe D 2011 Proceedings of the National Academy of Sciences of the United States of America vol:
108 no. 4 1512–1518 doi: 10.1073/pnas.1017351108

Examples

data("mm10.15kbp.SR50")
assign("bins", get("mm10.15kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=15, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

mm10.1kbp.SR50

Mm10 1kbp bin annotations

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

• blacklist: Percent overlap with ENCODE blacklisted regions (unused, ENCODE blacklist data

is not available for mouse),

• residual: Median loess residual calculated from normal C57BL/6J mouse samples from Gn-

erre et al. (see references),

• use: Whether the bin should be used in subsequent analysis steps,

Value

Returns an AnnotatedDataFrame object.

8

Author(s)

Daoud Sie

References

mm10.30kbp.SR50

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

High-quality draft assemblies of mammalian genomes from massively parallel sequence data. Gn-
erre S, Maccallum I, Przybylski D, Ribeiro F, Burton J, Walker B, Sharpe T, Hall G, Shea T, Sykes
S, Berlin A, Aird D, Costello M, Daza R, Williams L, Nicol R, Gnirke A, Nusbaum C, Lander E,
Jaffe D 2011 Proceedings of the National Academy of Sciences of the United States of America vol:
108 no. 4 1512–1518 doi: 10.1073/pnas.1017351108

Examples

data("mm10.1kbp.SR50")
assign("bins", get("mm10.1kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=1, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

mm10.30kbp.SR50

Mm10 30kbp bin annotations

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

• blacklist: Percent overlap with ENCODE blacklisted regions (unused, ENCODE blacklist data

is not available for mouse),

• residual: Median loess residual calculated from normal C57BL/6J mouse samples from Gn-

erre et al. (see references),

• use: Whether the bin should be used in subsequent analysis steps,

mm10.500kbp.SR50

Value

Returns an AnnotatedDataFrame object.

Author(s)

Daoud Sie

References

9

DNA copy number analysis of fresh and formalin-fixed specimens by shallow whole-genome se-
quencing with identification and exclusion of problematic regions in the genome assembly. Scheinin
I, Sie D, Bengtsson H, van de Wiel M, Olshen A, van Thuijl H, van Essen H, Eijk P, Rustenburg F,
Meijer G, Reijneveld J, Wesseling P, Pinkel D, Albertson D, Ylstra B 2014 Genome Research vol:
24 (12) pp: 1–11

Fast Computation and Applications of Genome Mappability. Derrien T, Estelle J, Sola S, Knowles
D, Raineri E, Guigo R, Ribeca P January 19, 2012 PLOS ONE doi: 10.1371/journal.pone.0030377

High-quality draft assemblies of mammalian genomes from massively parallel sequence data. Gn-
erre S, Maccallum I, Przybylski D, Ribeiro F, Burton J, Walker B, Sharpe T, Hall G, Shea T, Sykes
S, Berlin A, Aird D, Costello M, Daza R, Williams L, Nicol R, Gnirke A, Nusbaum C, Lander E,
Jaffe D 2011 Proceedings of the National Academy of Sciences of the United States of America vol:
108 no. 4 1512–1518 doi: 10.1073/pnas.1017351108

Examples

data("mm10.30kbp.SR50")
assign("bins", get("mm10.30kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=30, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

mm10.500kbp.SR50

Mm10 500kbp bin annotations

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

• blacklist: Percent overlap with ENCODE blacklisted regions (unused, ENCODE blacklist data

is not available for mouse),

• residual: Median loess residual calculated from normal C57BL/6J mouse samples from Gn-

erre et al. (see references),

• use: Whether the bin should be used in subsequent analysis steps,

mm10.50kbp.SR50

10

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

High-quality draft assemblies of mammalian genomes from massively parallel sequence data. Gn-
erre S, Maccallum I, Przybylski D, Ribeiro F, Burton J, Walker B, Sharpe T, Hall G, Shea T, Sykes
S, Berlin A, Aird D, Costello M, Daza R, Williams L, Nicol R, Gnirke A, Nusbaum C, Lander E,
Jaffe D 2011 Proceedings of the National Academy of Sciences of the United States of America vol:
108 no. 4 1512–1518 doi: 10.1073/pnas.1017351108

Examples

data("mm10.500kbp.SR50")
assign("bins", get("mm10.500kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=500, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

mm10.50kbp.SR50

Mm10 50kbp bin annotations

Description

Bin annotations are caclulated for non overlapping 50kbp bins generated as described in Scheinin
et al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,

• start: Base pair start position,

• end: Base pair end position,

• bases: Percentage of non-N nucleotides (of full bin size),

mm10.5kbp.SR50

11

• gc: Percentage of C and G nucleotides (of non-N nucleotides),

• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (unused, ENCODE blacklist data

is not available for mouse),

• residual: Median loess residual calculated from normal C57BL/6J mouse samples from Gn-

erre et al. (see references),

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

High-quality draft assemblies of mammalian genomes from massively parallel sequence data. Gn-
erre S, Maccallum I, Przybylski D, Ribeiro F, Burton J, Walker B, Sharpe T, Hall G, Shea T, Sykes
S, Berlin A, Aird D, Costello M, Daza R, Williams L, Nicol R, Gnirke A, Nusbaum C, Lander E,
Jaffe D 2011 Proceedings of the National Academy of Sciences of the United States of America vol:
108 no. 4 1512–1518 doi: 10.1073/pnas.1017351108

Examples

data("mm10.50kbp.SR50")
assign("bins", get("mm10.50kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=50, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

mm10.5kbp.SR50

Mm10 5kbp bin annotations

12

Description

mm10.5kbp.SR50

Bin annotations are caclulated for non overlapping 5kbp bins generated as described in Scheinin et
al. (see references). The annotated data frame contains:

• chromosome: Chromosome name,

• start: Base pair start position,

• end: Base pair end position,

• bases: Percentage of non-N nucleotides (of full bin size),

• gc: Percentage of C and G nucleotides (of non-N nucleotides),

• mappability: Average mappability of 50mers with a maximum of 2 mismatches as described

in by Derrien et al. (see references),

• blacklist: Percent overlap with ENCODE blacklisted regions (unused, ENCODE blacklist data

is not available for mouse),

• residual: Median loess residual calculated from normal C57BL/6J mouse samples from Gn-

erre et al. (see references),

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

High-quality draft assemblies of mammalian genomes from massively parallel sequence data. Gn-
erre S, Maccallum I, Przybylski D, Ribeiro F, Burton J, Walker B, Sharpe T, Hall G, Shea T, Sykes
S, Berlin A, Aird D, Costello M, Daza R, Williams L, Nicol R, Gnirke A, Nusbaum C, Lander E,
Jaffe D 2011 Proceedings of the National Academy of Sciences of the United States of America vol:
108 no. 4 1512–1518 doi: 10.1073/pnas.1017351108

Examples

data("mm10.5kbp.SR50")
assign("bins", get("mm10.5kbp.SR50"))
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

# or

bins <- getBinAnnotations(binSize=5, genome="mm10")
## Not run: readCounts <- binReadCounts(bins=bins, path="./bam")

Index

∗ datasets

mm10.1000kbp.SR50, 2
mm10.100kbp.SR50, 4
mm10.10kbp.SR50, 5
mm10.15kbp.SR50, 6
mm10.1kbp.SR50, 7
mm10.30kbp.SR50, 8
mm10.500kbp.SR50, 9
mm10.50kbp.SR50, 10
mm10.5kbp.SR50, 11

∗ package

QDNAseq.mm10-package, 2

AnnotatedDataFrame, 3–7, 9–12

mm10.1000kbp.SR50, 2
mm10.100kbp.SR50, 4
mm10.10kbp.SR50, 5
mm10.15kbp.SR50, 6
mm10.1kbp.SR50, 7
mm10.30kbp.SR50, 8
mm10.500kbp.SR50, 9
mm10.50kbp.SR50, 10
mm10.5kbp.SR50, 11

QDNAseq.mm10 (QDNAseq.mm10-package), 2
QDNAseq.mm10-package, 2

13

