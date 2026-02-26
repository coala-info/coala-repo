# dwgsim CWL Generation Report

## dwgsim

### Tool Description
short read simulator

### Metadata
- **Docker Image**: quay.io/biocontainers/dwgsim:1.1.14--h96c455f_2
- **Homepage**: https://github.com/nh13/DWGSIM
- **Package**: https://anaconda.org/channels/bioconda/packages/dwgsim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dwgsim/overview
- **Total Downloads**: 19.2K
- **Last updated**: 2025-06-27
- **GitHub**: https://github.com/nh13/DWGSIM
- **Stars**: N/A
### Original Help Text
```text
Program: dwgsim (short read simulator)
Version: 0.1.14
Contact: Nils Homer <dnaa-help@lists.sourceforge.net>

Usage:   dwgsim [options] <in.ref.fa> <out.prefix>

Options:
         -e FLOAT      per base/color/flow error rate of the first read [from 0.020 to 0.020 by 0.000]
         -E FLOAT      per base/color/flow error rate of the second read [from 0.020 to 0.020 by 0.000]
         -i            use the inner distance instead of the outer distance for pairs [False]
         -d INT        outer distance between the two ends for pairs [500]
         -s INT        standard deviation of the distance for pairs [50.000]
         -N INT        number of read pairs (-1 to disable) [-1]
         -C FLOAT      mean coverage across available positions (-1 to disable) [100.00]
         -1 INT        length of the first read [70]
         -2 INT        length of the second read [70]
         -r FLOAT      rate of mutations [0.0010]
         -F FLOAT      frequency of given mutation to simulate low fequency somatic mutations [0.5000]
                           NB: freqeuncy F refers to the first strand of mutation, therefore mutations 
                           on the second strand occur with a frequency of 1-F 
         -R FLOAT      fraction of mutations that are indels [0.10]
         -X FLOAT      probability an indel is extended [0.30]
         -I INT        the minimum length indel [1]
         -y FLOAT      probability of a random DNA read [0.05]
         -n INT        maximum number of Ns allowed in a given read [0]
         -c INT        generate reads for [0]:
                           0: Illumina
                           1: SOLiD
                           2: Ion Torrent
         -S INT        generate paired end reads with orientation [0]:
                           0: default (opposite strand for Illumina, same strand for SOLiD/Ion Torrent)
                           1: same strand (mate pair)
                           2: opposite strand (paired end)
         -A INT        generate paired end reads with read one [0]:
                           0: default (both, random)
                           1: forward genomic strand
                           2: reverse genomic strand
         -f STRING     the flow order for Ion Torrent data [(null)]
         -B            use a per-base error rate for Ion Torrent data [False]
         -H            haploid mode [False]
         -z INT        random seed (-1 uses the current time) [-1]
         -M            generate a mutations file only [False]
         -m FILE       the mutations txt file to re-create [not using]
         -b FILE       the bed-like file set of candidate mutations [(null)]
         -v FILE       the vcf file set of candidate mutations (use pl tag for strand) [(null)]
         -x FILE       the bed of regions to cover [not using]
         -P STRING     a read prefix to prepend to each read name [not using]
         -q STRING     a fixed base quality to apply (single character) [not using]
         -Q FLOAT      standard deviation of the base quality scores [2.00]
         -s INT        standard deviation of the distance for pairs [50.000]
         -o INT        output type for the FASTQ files [0]:
                           0: interleaved (bfast) and per-read-end (bwa)
                           1: per-read-end (bwa) only
                           2: interleaved (bfast) only
         -h            print this message

Note: For SOLiD mate pair reads and BFAST, the first read is F3 and the second is R3. For SOLiD mate pair reads
and BWA, the reads in the first file are R3 the reads annotated as the first read etc.

Note: The longest supported insertion is 4294967295.
```

