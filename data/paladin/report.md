# paladin CWL Generation Report

## paladin_index

### Tool Description
Index a reference genome or transcriptome for PALADIN alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
- **Homepage**: https://github.com/ToniWestbrook/paladin
- **Package**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Total Downloads**: 23.9K
- **Last updated**: 2025-10-03
- **GitHub**: https://github.com/ToniWestbrook/paladin
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: paladin index [options] <reference.fasta> [annotation.gff]

Options:

    -f     Enable indexing all frames in nucleotide references
    -r<#>  Reference type:
              1: Reference contains nucleotide sequences (requires corresponding .gff annotation)
              2: Reference contains nucleotide sequences (coding only, eg curated transcriptome)
              3: Reference contains protein sequences (UniProt or other source)
              4: Development tests

Examples:

   paladin index -r1 reference.fasta reference.gff
   paladin index -r3 uniprot_sprot.fasta.gz
```


## paladin_prepare

### Tool Description
Prepare a reference database for PALADIN by downloading or using a local copy.

### Metadata
- **Docker Image**: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
- **Homepage**: https://github.com/ToniWestbrook/paladin
- **Package**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: paladin prepare [options]

Options:

    -r <#>         Reference Database:
                     1: UniProtKB Reviewed (Swiss-Prot)
                     2: UniProtKB Clustered 90% (UniRef90)

    -f <ref.fasta> Skip download, use local copy of reference database (may be indexed)
    -P <address>   HTTP or SOCKS proxy address

Examples:

   paladin prepare -r2
   paladin prepare -r1 -f uniprot_sprot.fasta.gz
```


## paladin_align

### Tool Description
Protein alignment tool for functional profiling of metagenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
- **Homepage**: https://github.com/ToniWestbrook/paladin
- **Package**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: paladin align [options] <idxbase> <in.fq>

Gene detection options:

       -q            disable ORF detection and treat input as transcript sequence
       -p            disable ORF detection and treat input as protein sequence
       -b            disable brute force detection
       -J            do not adjust minimum ORF length (constant value) for shorter read lengths
       -f INT        minimum ORF length accepted (as constant value) [250]
       -F FLOAT      minimum ORF length accepted (as percentage of read length) [0.00]
       -z INT[,...]  Genetic code used for translation (-z ? for full list) [1]

Alignment options:

       -t INT        number of threads [1]
       -k INT        minimum seed length [11]
       -d INT        off-diagonal X-dropoff [100]
       -r FLOAT      look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]
       -y INT        seed occurrence for the 3rd round seeding [20]
       -c INT        skip seeds with more than INT occurrences [500]
       -D FLOAT      drop chains shorter than FLOAT fraction of the longest overlapping chain [0.50]
       -W INT        discard a chain if seeded bases shorter than INT [0]
       -m INT        perform at most INT rounds of mate rescues for each read [50]
       -e            discard full-length exact matches

Scoring options:

       -A INT        score for a sequence match, which scales options -TdBOELU unless overridden [1]
       -B INT        penalty for a mismatch [3]
       -O INT[,INT]  gap open penalties for deletions and insertions [0,0]
       -E INT[,INT]  gap extension penalty; a gap of size k cost '{-O} + {-E}*k' [1,1]
       -L INT[,INT]  penalty for 5'- and 3'-end clipping [0,0]
       -U INT        penalty for an unpaired read pair [17]

       -x STR        read type. Setting -x changes multiple parameters unless overriden [null]
                     pacbio: -k17 -W40 -r10 -A1 -B1 -O1 -E1 -L0  (PacBio reads to ref)
                     ont2d: -k14 -W20 -r10 -A1 -B1 -O1 -E1 -L0  (Oxford Nanopore 2D-reads to ref)
                     intractg: -B9 -O16 -L5  (intra-species contigs to ref)

Input/output options:

       -o STR        activate PALADIN reporting using STR as an output file prefix.  Files generated as follows:
                        STR.sam - alignment data (will not be sent to stdout)
                        STR_uniprot.tsv - Tab delimited UniProt report (normal alignment mode)
                        STR_uniprot_primary.tsv - Tab delimited UniProt report, primary alignments (all alignments mode)
                        STR_uniprot_secondary.tsv - Tab delimited UniProt report, secondary alignments (all alignments mode)

       -u INT        report type generated when using reporting and a UniProt reference [1]
                        0: Simple ID summary report
                        1: Detailed report (Contacts uniprot.org)

       -P STR        HTTP or SOCKS proxy address
       -g            generate detected ORF nucleotide sequence FASTA
       -n            keep protein sequence after alignment
       -R STR        read group header line such as '@RG\tID:foo\tSM:bar' [null]
       -H STR/FILE   insert STR to header if it starts with @; or insert lines in FILE [null]
       -j            treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file)

       -v INT        verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]
       -T INT        minimum score to output [15]
       -h INT[,INT]  if there are <INT hits with score >80% of the max score, output all in XA [5,200]
       -a            output all alignments for SE or unpaired PE
       -C            append FASTA/FASTQ comment to SAM output
       -V            output the reference FASTA header in the XR tag
       -Y            use soft clipping for supplementary alignments
       -M            mark shorter split hits as secondary

       -I FLOAT[,FLOAT[,INT[,INT]]]
                     specify the mean, standard deviation (10% of the mean if absent), max
                     (4 sigma from the mean if absent) and min of the insert size distribution.
                     FR orientation only. [inferred]

Note: Please read the man page for detailed description of the command line and options.
```


## paladin_shm

### Tool Description
Manage indices in shared memory

### Metadata
- **Docker Image**: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
- **Homepage**: https://github.com/ToniWestbrook/paladin
- **Package**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bwa shm [-d|-l] [-f tmpFile] [idxbase]

Options: -d       destroy all indices in shared memory
         -l       list names of indices in shared memory
         -f FILE  temporary file to reduce peak memory
```


## paladin_fa2pac

### Tool Description
Convert FASTA to PAC format

### Metadata
- **Docker Image**: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
- **Homepage**: https://github.com/ToniWestbrook/paladin
- **Package**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: bwa fa2pac [-f] <in.fasta> [<out.prefix>]
```


## paladin_pac2bwt

### Tool Description
Generate a BWT from a PAC file using PALADIN

### Metadata
- **Docker Image**: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
- **Homepage**: https://github.com/ToniWestbrook/paladin
- **Package**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: paladin pac2bwt <in.pac> <out.bwt>
```


## paladin_bwtupdate

### Tool Description
Update a BWT index for PALADIN

### Metadata
- **Docker Image**: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
- **Homepage**: https://github.com/ToniWestbrook/paladin
- **Package**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: paladin bwtupdate <the.bwt>
```


## paladin_bwt2sa

### Tool Description
Generate a suffix array (.sa) from a BWT index (.bwt) using PALADIN

### Metadata
- **Docker Image**: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
- **Homepage**: https://github.com/ToniWestbrook/paladin
- **Package**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: paladin bwt2sa [-i 32] <in.bwt> <out.sa>
```


## paladin_Then

### Tool Description
The provided text indicates an unrecognized command error for 'paladin then'. No help documentation or arguments were found in the input.

### Metadata
- **Docker Image**: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
- **Homepage**: https://github.com/ToniWestbrook/paladin
- **Package**: https://anaconda.org/channels/bioconda/packages/paladin/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[main] unrecognized command 'Then'
```


## Metadata
- **Skill**: generated
