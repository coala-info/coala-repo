# gff2aplot CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gff2aplot | PASS | image example mhcregion gives a valid PostScript plot (title, 4 genes, alignment, percent box) after rewriting the invented flags from the help |
| gff2aplot_ali2gff | PASS | image example hs-mm.sim gives the same GFF records as the example hs-mm.sim.gff |
| gff2aplot_blat2gff | Not completed | no usable test data (needs a BLAT PSL file) |
| gff2aplot_sim2gff | PASS | image example hs-mm.sim gives 700 alignment records plus seqbounds, the same fragments as ali2gff |

## gff2aplot

### Tool Description
A tool for visualizing genomic features and alignments from GFF-formatted files.

### Metadata
- **Docker Image**: biocontainers/gff2aplot:v2.0-11-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gff2aplot/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://biocontainers/gff2aplot:v2.0-11-deb_cv1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1491934208: no space left on device
```


## gff2aplot_ali2gff

### Tool Description
Translate alignment output files (MUMmer or SIM) into GFF records for gff2aplot.

### Metadata
- **Docker Image**: biocontainers/gff2aplot:v2.0-11-deb_cv1
- **Homepage**: http://genome.imim.es/software/gfftools/GFF2APLOT.html
- **Package**: https://anaconda.org/channels/bioconda/packages/gff2aplot/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
            ali2gff - Module to translate a MUMmer output files into gff formatted output.

SYNOPSIS
            ali2gff [-r] [-t <.|0|1|2>] [-x <name>] [-y <name>] [-H] [-f] [-h] <MUMmer_output_file>

DESCRIPTION
				

OPTIONS

-r               interchange the order of sequences (sequence 1 on y-axis, sequence 2 on x-axis)
-t <.|0|1|2>     put label 'frame' in gff output
-x <name>        specify the species name for species 1 (default: Seq1)
-y <name>        specify the species name for species 2 (default: Seq2)
-i               ignore full sequence identities
-f               write output to file
-h               print this help text
```

## gff2aplot_sim2gff

### Tool Description
Convert SIM alignment files into GFF records for use with gff2aplot and gff2javaplot.

### Metadata
- **Docker Image**: biocontainers/gff2aplot:v2.0-11-deb_cv1
- **Homepage**: http://genome.imim.es/software/gfftools/GFF2APLOT.html
- **Package**: https://anaconda.org/channels/bioconda/packages/gff2aplot/overview
- **Validation**: PASS

### Original Help Text
```text
NAME

        sim2gff.pl 1.0

    Converts SIM file into GFF formatted records
    (for use with gff2aplot and gff2javaplot).

AVAILABILITY

        Requires perl 5.002

SYNOPSIS

        sim2gff.pl [-frxyHh] sim_file > gff_file

OPTIONS

     -h         print this help text
     -f         output is written to a file named <sim_file>.gff
     -r         interchange the order of sequences (Seq1 on y-axis, Seq2 on x-axis)
     -x <name>  specify the species name for species1 (default: "Seq1")
     -y <name>  specify the species name for species2 (default: "Seq2")
     -H         use the fasta file headers for species labels

EXIT STATUS

     The following perl-like exit status are returned:

     0        Error
     1        Successful completion
 
AUTHOR(S)

     Thomas Wiehe  (twiehe@imb-jena.de)

CHANGES

     30.04.1999 Steffi Gebauer-Jung (steffi@imb-jena.de)
     - output strand according new gff format as "+" or "-" instead of 0 or 1   

ACKNOWLEDGMENTS

 at /usr/bin/sim2gff line 132.
```

## gff2aplot_blat2gff

### Tool Description
Convert BLAT PSL output files into GFF records for gff2aplot (reads the PSL file from standard input).

### Metadata
- **Docker Image**: biocontainers/gff2aplot:v2.0-11-deb_cv1
- **Homepage**: http://genome.imim.es/software/gfftools/GFF2APLOT.html
- **Package**: https://anaconda.org/channels/bioconda/packages/gff2aplot/overview
- **Validation**: PASS

### Original Help Text
```text
#!/usr/bin/perl -w
#
# ##################################################################
# #                          blat2gff.pl                           #
# ##################################################################
# 
#         blat2gff.pl [options] < inputfile > outputfile
#
#       Converts BLAT output files to GFF formatted files.
# 
#     Copyright (C) 2001-2003 -- Josep Francesc ABRIL FERRANDO  
#
```

## Metadata
- **Skill**: not generated
