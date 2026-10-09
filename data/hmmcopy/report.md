# hmmcopy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hmmcopy_fastaToRead | PASS |  |
| hmmcopy_gcCounter | PASS |  |
| hmmcopy_generateMap.pl | PASS |  |
| hmmcopy_mapCounter | PASS |  |
| hmmcopy_readCounter | PASS |  |

## Metadata
- **Skill**: generated

## hmmcopy_gcCounter

### Tool Description
Calculates GC content for a given FASTA file. (Note: The provided input text contained a system error message rather than help text; arguments are derived from standard tool documentation).

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
- **Homepage**: http://compbio.bccrc.ca/software/hmmcopy/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmcopy/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2557959064: no space left on device
```

## hmmcopy_readCounter

### Tool Description
HMMcopy readCounter.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
- **Homepage**: http://compbio.bccrc.ca/software/hmmcopy/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmcopy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: readCounter [options] <BAM file>

Options:
    -s, --seg                 Outputs in SEG format
    -w, --window <int>        Specify the size of non-overlapping windows [1000]
    -q, --quality <int>       Specify the mapping quality value below which reads are ignored

    -l, --list                List all chromosomes in BAM reference file
    -c, --chromosome <string> Specify the entries and order of sequences to analyze [ALL],
                              the <string> should be a comma-delimited list (NO spaces)

    -b, --build               Build BAM index for file (same index format as SAMtools)

Example:
    readCounter -w 100 -c 1,3,5,X aligned_reads.bam > readcounts.wig

Author: Daniel Lai <jujubix@cs.ubc.ca>
```

## hmmcopy_mapCounter

### Tool Description
HMMcopy mapCounter.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
- **Homepage**: http://compbio.bccrc.ca/software/hmmcopy/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmcopy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mapCounter [options] <BigWig file>

Options:
    -s, --seg                 Outputs in SEG format
    -w, --window <int>        Specify the size of non-overlapping windows [1000]
    -l, --list                List all chromosomes in BigWig file
    -c, --chromosome <string> Specify the entries and order of sequences to analyze [ALL],
                              the <string> should be a comma-delimited list (NO spaces)
    -h, --help                This help message

Example:
    mapCounter -w 100000 -c 1,3,5,X hg18.bw > hg18.map.wig

Author: Daniel Lai <jujubix@cs.ubc.ca>
```

## hmmcopy_generateMap.pl

### Tool Description
HMMcopy generateMap.pl.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
- **Homepage**: http://compbio.bccrc.ca/software/hmmcopy/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmcopy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/generateMap.pl [options] <FASTA reference>
Options:
    -o, --output <string>   Output (also takes 'stdout') [default: <FASTA reference>.map.bw]
    -w, --window <int>      Specify the fragment size to calculate mappability values [35]

    -i, --index <string>    Location of a ready built bowtie index of the FASTA input
    -b, --build             Build bowtie index for given FASTA reference, take caution
                            when using on large genomes, 'bowtie-build' for details

    -h, --help              Prints this message

Example:
    /usr/local/bin/generateMap.pl hg18.fa

Author: Daniel Lai <jujubix@cs.ubc.ca>
```

## hmmcopy_fastaToRead

### Tool Description
HMMcopy fastaToRead.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
- **Homepage**: http://compbio.bccrc.ca/software/hmmcopy/
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmcopy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fastaToRead [options] <FASTA reference>

Options:
    -w, --window <int>       Specify the size of the overlapping reads [1000]
    -l, --list               List all chromosomes in FASTA reference file
    -s, --sequence <string>  Specify the entries and order of sequences to analyze [ALL],
                             the <string> should be a comma-delimited list (NO spaces)
Example:
    ./fastaToRead -w 10 -s 1,3,5,X hg18.fasta > bowtie hg18 -f -

Author: Daniel Lai <jujubix@cs.ubc.ca>
```
