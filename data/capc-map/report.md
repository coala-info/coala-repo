# capc-map CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| capc-map_capCdigestfastq | PASS |  |
| capc-map_capClocation2fragment | PASS |  |
| capc-map_capCmain | PASS |  |
| capc-map_capCpair2bg | PASS |  |
| capc-map_capCpileup2binned | PASS |  |
| capc-map_combinereps | PASS |  |
| capc-map_genomedigest | PASS |  |
| capc-map_getchromsizes | PASS |  |
| capc-map_postprocess | PASS |  |

## capc-map_genomedigest

### Tool Description
Generate list of restriction enzyme fragments from a fasta file for the reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
- **Homepage**: https://capc-map.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/capc-map/overview
- **Validation**: PASS

### Original Help Text
```text
usage: capC-MAP genomedigest [-h] -i INPUTFASTA -r ENZYMENAME -o OUTPUTBED

optional arguments:
  -h, --help     show this help message and exit
  -i INPUTFASTA  input fasta file of geneome
  -r ENZYMENAME  name of supported enzyme, or cutting sequence
  -o OUTPUTBED   output bed file of restriction fragments
```

## capc-map_getchromsizes

### Tool Description
Generate a chrom.sizes file from a list of restriction enzyme fragments.

### Metadata
- **Docker Image**: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
- **Homepage**: https://capc-map.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/capc-map/overview
- **Validation**: PASS

### Original Help Text
```text
usage: capC-MAP getchromsizes [-h] -f FRAGMENTSFILE [-o OUTFILE]

optional arguments:
  -h, --help        show this help message and exit
  -f FRAGMENTSFILE  bed file continaing list of restriction enzyme fragments
                    for genome
  -o OUTFILE        output file name (Default: chrom.sizes)
```

## capc-map_postprocess

### Tool Description
Run binning, smoothing or normalization on capture c profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
- **Homepage**: https://capc-map.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/capc-map/overview
- **Validation**: PASS

### Original Help Text
```text
usage: capC-MAP postprocess [-h] -c CONFIGFILE -o OUTDIR

optional arguments:
  -h, --help     show this help message and exit
  -c CONFIGFILE  configuration file
  -o OUTDIR      directory to be created for output
```

## capc-map_combinereps

### Tool Description
Combine multiple replicates into a single data set, and run binning, smoothing or normalization.

### Metadata
- **Docker Image**: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
- **Homepage**: https://capc-map.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/capc-map/overview
- **Validation**: PASS

### Original Help Text
```text
usage: capC-MAP combinereps [-h] -c CONFIGFILE -i INDIR -o OUTDIR

optional arguments:
  -h, --help     show this help message and exit
  -c CONFIGFILE  configuration file
  -i INDIR       directory containing output from capC-MAP for a replicate
                 (option must appear multiple times).
  -o OUTDIR      directory to be created for combined output
```

## capc-map_capCmain

### Tool Description
Main capC-MAP step: find captured fragments and reporters in a name-sorted SAM file and write valid pairs per target.

### Metadata
- **Docker Image**: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
- **Homepage**: https://capc-map.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/capc-map/overview
- **Validation**: PASS

### Original Help Text
```text
Usage :
   capCmain -r frag_file -t targ_file -s sam_file -o name [-e N] [-i]

   Required arguments :
       -r  frag_file   is a bed file of restriction enzyme fragments genome wide
       -t  targ_file   is a bed file of capture targets
       -s  sam_file    is a SAM file containing groups of aligned
                       digested fragments, sorted by name
       -o  name        is the first part of the output file name

   Options :
       -e N            exclusion zone; reporter fragments mapping within N bp of
                       a target fragment are discarder. Default N=500.
       -i              save interchromosomal. If present, interchomosomal
                       interactions will be saved as well as counted.
```

## capc-map_capCdigestfastq

### Tool Description
In silico restriction digest of paired fastq reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
- **Homepage**: https://capc-map.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/capc-map/overview
- **Validation**: PASS

### Original Help Text
```text
Usage :
   capCdigestfastq -1 first_fq -2 second_fq -o output_fq -e SEQ -p X [--long]

   Required arguments :
       -1  first_fq    is the first of the pair of fastq files
       -2  second_fq   is the second of the pair of fastq files
       -o  output_fq   is the name of the output fastq file
       -e  SEQ         is the sequence of the restriction enzyme
                       must be characters ACGT only
       -p  X           is the bp position within SEQ where the
                       cut will occur (first base is 1; Xth base
                       will be the start of the right hand
                       fragment)

   Options :
       --long          option switches on 'long' mode, where only the
                       longest of the restriction fragments in each of
                       the pairs is kept
```

## capc-map_capClocation2fragment

### Tool Description
Find the restriction fragments that contain genomic locations.

### Metadata
- **Docker Image**: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
- **Homepage**: https://capc-map.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/capc-map/overview
- **Validation**: PASS

### Original Help Text
```text
Usage :
   capClocation2fragment -r restfragfile -o outfile [-i inputfile | -l location]

   Required arguments :
       -r  restfragfile    filename for bed file containing the list of restriction fragments
       -o  outfile         filename for output bed file (if not present output with be sent to stdout)

   Options : exactly one the following optional arguments must be present
       -i  inputfile       filename for bed file containing genomic locations
       -l  location        is a single genomic location in format chr1:1234-5678
```

## capc-map_capCpair2bg

### Tool Description
Pile up a capture valid pairs file into a bedGraph.

### Metadata
- **Docker Image**: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
- **Homepage**: https://capc-map.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/capc-map/overview
- **Validation**: PASS

### Original Help Text
```text
Usage :
   capCpair2bg -i pairsfile -o bgfile -n targetname -t chr:start-end [--interchrom]

   Required arguments :
       -i  pairfile       is the input file name; can use this option more
                          than once to combine multiple targets into one
       -o  bgfile         is the file name for the output bedGraph
       -n  targetname     is the name of the target
       -t  chrom:start-end  is the genomic location of the target site; can
                          use this option more than once if multiple pair
                          files are specified.
  Options  :
       --interchrom       flag to specify interchromosomal interactions are present
```

## capc-map_capCpileup2binned

### Tool Description
Bin and/or normalize a capture pile-up bedGraph.

### Metadata
- **Docker Image**: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
- **Homepage**: https://capc-map.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/capc-map/overview
- **Validation**: PASS

### Original Help Text
```text
Usage :
   capCpileup2binned -i pileupfile -o outfile -c chromsizes -t target [-b bin wind] [-n totalreads]

   Required arguments :
       -i  pileupfile  is the input pile-up file name
       -o  outfile     is the file name for the output bedGraph
       -c  chromsizes  is the file name for the list of chromosome sizes
       -t  target      is the name of the target

   Options : one or more of the following optional arguments must be present
       -b  bin wind    pile-up will be up into sliding window bins with step
                       size of 'bin' and window width of 'wind'
       -n  totalreads  pile-up will be normalized to reads per million
                       genome wide; requires total number of reads (available
                       from capC main process report file; includes both inter
                       and intra chromosomal).
```

## Metadata
- **Skill**: generated

