Package ‘gaschYHS’
February 12, 2026

Title ExpressionSet for response of yeast to heat shock and other

environmental stresses

Version 1.48.0

Author Audrey Gasch and colleagues

Description Data from PMID 11102521

Maintainer Vince Carey <stvjc@channing.harvard.edu>

License Artistic-2.0

URL http://genome-www.stanford.edu/yeast_stress/data/rawdata/complete_dataset.txt

Depends R (>= 2.14.0), Biobase (>= 2.5.5)

biocViews ExperimentData, Genome, Saccharomyces_cerevisiae_Data

git_url https://git.bioconductor.org/packages/gaschYHS

git_branch RELEASE_3_22

git_last_commit 8f92e00

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

gaschYHS .

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

gaschYHS

Description

Data from PMID 11102521, Transcriptional responses of yeast to
environmental stress, A Gasch and colleagues (2001)

1

3

This ExpressionSet provides data on expression ratios for 173 yeast chips involving a variety of
environmental stresses.

Usage

data(gaschYHS); data(fig3)

1

2

Format

gaschYHS

The format is an ExpressionSet. There is a feature data component.

Details

fig3.rda in data folder comes from

http://genome-www.stanford.edu/yeast_stress/data/figure3/figure3.cdt

as of 22 April 2012, with a read.delim, check.names=FALSE.

Source

http://genome-www.stanford.edu/yeast_stress/data/rawdata/complete_dataset.txt

References

Use annotate::pmid2MIAME(1102521)

Examples

library(Biobase)
data(gaschYHS)
gaschYHS

Index

∗ datasets

gaschYHS, 1

ExpressionSet, 2

fig3 (gaschYHS), 1

gaschYHS, 1

3

