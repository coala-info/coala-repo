# crass CWL Generation Report

## crass

### Tool Description
CRisprASSembler (crass) - A tool for identifying and assembling CRISPR loci from metagenomic sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/crass:1.0.1--hcb2000e_7
- **Homepage**: https://mummer4.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/crass/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crass/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-08-28
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
CRisprASSembler (crass)
version 1 subversion 0 revison 1 (1.0.1)

---------------------------------------------------------------
Copyright (C) 2011-2015 Connor Skennerton & Michael Imelfort
Copyright (C) 2016      Connor Skennerton
This program comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions: See the source for more details
---------------------------------------------------------------
Compiler Options:
RENDERING = 1
DEBUG = 0
MEMCHECK = 0
ASSEMBER = 1
VERBOSE_LOGGER = 0
Search Debugger =  0

Usage:  crass  [options] { inputFile ...}

General Options:
-h --help                    This help message
-l --logLevel        <INT>   Output a log file and set a log level [1 - 4]
-o --outDir          <DIR>   Output directory [default: .]
-V --version                 Program and version information
-g --logToScreen             Print the logging information to screen rather than a file

CRISPR Identification Options:
-d --minDR           <INT>   Minimim length of the direct repeat
                             to search for [Default: 23]
-D --maxDR           <INT>   Maximim length of the direct repeat
                             to search for [Default: 47]
-n --minNumRepeats   <INT>   Total number of direct repeats in a CRISPR for
                             it to be considered real [Default: 2]
-s --minSpacer       <INT>   Minimim length of the spacer to search for [Default: 26]
-S --maxSpacer       <INT>   Maximim length of the spacer to search for [Default: 50]
-w --windowLength    <INT>   The length of the search window. Can only be
                             a number between 6 - 9 [Default: 8]
CRISPR Assembly Options:
-f --covCutoff       <INT>   Remove groups with less than x spacers [Default: 3]
-k --kmerCount       <INT>   The number of the kmers that need to be
                             shared for clustering [Default: 6]
-K --graphNodeLen    <INT>   Length of the kmers used to make crispr nodes [Default: 7]

Output Options: 
-a --layoutAlgorithm  <TYPE>  Graphviz layout algorithm to use for printing spacer graphs. The following are available:
                              	neato
                              	dot [Default]
                              	fdp
                              	sfdp
                              	circo
                              	twopi
-b --numBins          <INT>   The number of colour bins for the output graph.
                              Default is to have as many colours as there are
                              different values for the coverage of Nodes in the graph
-c --graphColour     <TYPE>   Defines the range of colours to use for the output graph
                              the different types available are:
                              red-blue, blue-red, green-red-blue, red-blue-green
-L --longDescription          Set if you want the spacer sequence printed along with the ID in the spacer graph. [Default: false]
-G --showSingltons            Set if you want to print singleton spacers in the spacer graph [Default: false]
-r --noRendering              Stops rendering of .gv files even if the RENDERING preprocessor macro is set [Default: false]
```


## Metadata
- **Skill**: not generated
