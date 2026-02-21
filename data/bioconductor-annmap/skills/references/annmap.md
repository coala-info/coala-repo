annmap: The base component for a framework of
Genome analysis tools

Tim Yates, Crispin J Miller

October 29, 2025

Important

The annmap package has similar methods to the deprecated exonmap pack-
age. We have tried to keep things as close as possible, but some functions,
parameters and returned results are crucially different. Please make sure
you have read the migration section on page 2 to see how to migrate your
code from exonmap to annmap.

Contents

1 Introduction

2 Migration from exonmap

2.1 Working with features previously in the ’other features’ database . . . .
2.2 Range query parameter order
. . . . . . . . . . . . . . . . . . . . . . . .
2.3 Gene plots . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

2
2
2
2

1 Introduction

annmap provides access to the genome annotation in the Annmap database (http://
annmap.cruk.manchester.ac.uk).
It is designed to be a base layer for interrogating
genome and probeset annotation, and to be extensible, so that later packages for Microar-
ray Expression analysis, deep sequencing, or proteomics data analysis can be added to
extend the functionality of annmap.

The functions provided by annmap can be divided into five main groups:

1. Connect/disconnect to an instance of the database

2. Find genome features within a particular set of coordinates (e.g. geneInRange())

3. Find genome features by name (e.g. geneDetails())

4. Map between genome features (e.g. geneToExon())

5. Handle Affymetrix microarray annotation

1

For detailed examples showing how these tasks are performed, please see the cook-

book document, supplied along with this package.

2 Migration from exonmap

2.1 Working with features previously in the ’other features’ database

In exonmap if you wanted to find mappings to EST genes, you were required to pass a
subset=’est’ parameter to the method of interest. EST genes are now integrated into
the same database with the other features, so now there are seperate EST functions for
you to call (probesetToEstGene, etc).

2.2 Range query parameter order

The parameter order for InRange queries has changed. The four parameters required are
now in the order:

1. chr – Chromosome name as a character vector

2. start – Numeric start location

3. end – Numeric stop location

4. strand – Numeric strand direction ( -1 or 1 )

Alternatively, you can now pass a data.frame, a GRanges object or an IRanges object.

2.3 Gene plots

In exonmap there exist the functions gene.graph, gene.strip, and genePlot. These do
not exist in the annmap package. Please see the cookbook pdf supplied with this package
for alternatives.

2

