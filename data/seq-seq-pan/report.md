# seq-seq-pan CWL Generation Report

## seq-seq-pan_subcommand

### Tool Description
A tool for pangenome analysis and sequence manipulation.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Total Downloads**: 51.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: seqseqpan.py [-h] subcommand ...
seqseqpan.py: error: argument subcommand: invalid choice: 'subcommand' (choose from 'blockcountsplit', 'extract', 'join', 'maf', 'map', 'mapall', 'merge', 'realign', 'reconstruct', 'remove', 'resolve', 'separate', 'split', 'xmfa')
```


## seq-seq-pan_blockcountsplit

### Tool Description
Split XMFA of 2 genomes into 3 XMFA files: blocks with both genomes and genome-specific blocks for each genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py blockcountsplit [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME
                                    -x XMFA_F

Split XMFA of 2 genomes into 3 XMFA files: blocks with both genomes and
genome-specific blocks for each genome.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
```


## seq-seq-pan_genomes

### Tool Description
A tool for pan-genome analysis and sequence processing.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py [-h] subcommand ...
seqseqpan.py: error: argument subcommand: invalid choice: 'genomes' (choose from 'blockcountsplit', 'extract', 'join', 'maf', 'map', 'mapall', 'merge', 'realign', 'reconstruct', 'remove', 'resolve', 'separate', 'split', 'xmfa')
```


## seq-seq-pan_extract

### Tool Description
Extract sequence for whole genome or genomic interval.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py extract [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x
                            XMFA_F -g GENOME_DESC_F -e REGION

Extract sequence for whole genome or genomic interval.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
  -g GENOME_DESC_F, --genome_desc GENOME_DESC_F
                        File containing genome description (name/chromosomes)
                        for .MAF file creation and 'split' task. Format:
                        'genome id<TAB>name<TAB>length' Length information is
                        only necessary for FASTA files containing more than
                        one chromosome. Multiple chromosomes of a genome must
                        be listed in the same order as in original FASTA file.
  -e REGION, --extractregion REGION
                        Region to extract in the form genome_nr:start-end (one
                        based and inclusive) or only genome_nr for full
                        sequence.
```


## seq-seq-pan_join

### Tool Description
Join LCBs from 2 XMFA files, assigning genome_ids as in first XMFA file (-x).

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py join [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x XMFA_F
                         [-o ORDER] -y XMFA_F_2

Join LCBs from 2 XMFA files, assigning genome_ids as in first XMFA file (-x).

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.
  -o ORDER, --order ORDER
                        Ordering of blocks in XMFA/FASTA output (0,1,2,...)
                        [default: 0]

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
  -y XMFA_F_2, --xmfa_two XMFA_F_2
                        XMFA file to be joined with input file.
```


## seq-seq-pan_first

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: seqseqpan.py [-h] subcommand ...
seqseqpan.py: error: argument subcommand: invalid choice: 'first' (choose from 'blockcountsplit', 'extract', 'join', 'maf', 'map', 'mapall', 'merge', 'realign', 'reconstruct', 'remove', 'resolve', 'separate', 'split', 'xmfa')
```


## seq-seq-pan_maf

### Tool Description
Write MAF file from XMFA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py maf [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x XMFA_F -g
                        GENOME_DESC_F

Write MAF file from XMFA file.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
  -g GENOME_DESC_F, --genome_desc GENOME_DESC_F
                        File containing genome description (name/chromosomes)
                        for .MAF file creation and 'split' task. Format:
                        'genome id<TAB>name<TAB>length' Length information is
                        only necessary for FASTA files containing more than
                        one chromosome. Multiple chromosomes of a genome must
                        be listed in the same order as in original FASTA file.
```


## seq-seq-pan_map

### Tool Description
Map positions/coordinates from consensus to sequences, between sequences, ...

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py map [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -c
                        CONSENSUS_F -i COORD_F

Map positions/coordinates from consensus to sequences, between sequences, ...

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -c CONSENSUS_F, --consensus CONSENSUS_F
                        consensus FASTA file used in XMFA
  -i COORD_F, --index COORD_F
                        File with indices to map. First line:
                        source_seq<TAB>dest_seq[,dest_seq2,...] using "c" or
                        sequence number. Then one coordinate per line.
                        Coordinates are 1-based!
```


## seq-seq-pan_between

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: seqseqpan.py [-h] subcommand ...
seqseqpan.py: error: argument subcommand: invalid choice: 'between' (choose from 'blockcountsplit', 'extract', 'join', 'maf', 'map', 'mapall', 'merge', 'realign', 'reconstruct', 'remove', 'resolve', 'separate', 'split', 'xmfa')
```


## seq-seq-pan_mapall

### Tool Description
Map all positions/coordinates from consensus to sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py mapall [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -c
                           CONSENSUS_F -i COORD_F [-t THREADS]

Map all positions/coordinates from consensus to sequences

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -c CONSENSUS_F, --consensus CONSENSUS_F
                        consensus FASTA file used in XMFA
  -i COORD_F, --index COORD_F
                        File with sequences to map. First line:
                        c<TAB>dest_seq[,dest_seq2,...] or
                        source_seq[,source_seq2]<TAB>c. All following lines
                        will be ignored.
  -t THREADS, --threads THREADS
                        Number of threads to use for mapping all positions.
                        Using all available threads if not specified.
```


## seq-seq-pan_merge

### Tool Description
Add small LCBs to end or beginning of surrounding LCBs. Can only be used with two aligned sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py merge [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x XMFA_F
                          [-o ORDER] [-l LCB_LENGTH]

Add small LCBs to end or beginning of surrounding LCBs. Can only be used with
two aligned sequences.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.
  -o ORDER, --order ORDER
                        Ordering of blocks in XMFA/FASTA output (0,1,2,...)
                        [default: 0]
  -l LCB_LENGTH, --length LCB_LENGTH
                        Length of "small LCB". [default: 10]

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
```


## seq-seq-pan_only

### Tool Description
A tool for pan-genome analysis. Note: 'only' is not a valid subcommand; valid subcommands include blockcountsplit, extract, join, maf, map, mapall, merge, realign, reconstruct, remove, resolve, separate, split, and xmfa.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py [-h] subcommand ...
seqseqpan.py: error: argument subcommand: invalid choice: 'only' (choose from 'blockcountsplit', 'extract', 'join', 'maf', 'map', 'mapall', 'merge', 'realign', 'reconstruct', 'remove', 'resolve', 'separate', 'split', 'xmfa')
```


## seq-seq-pan_realign

### Tool Description
Realign sequences of LCBs around consecutive gaps. Can only be used with two aligned sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py realign [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x
                            XMFA_F [-o ORDER] [--blat BLAT_PATH]

Realign sequences of LCBs around consecutive gaps. Can only be used with two
aligned sequences.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.
  -o ORDER, --order ORDER
                        Ordering of blocks in XMFA/FASTA output (0,1,2,...)
                        [default: 0]
  --blat BLAT_PATH      Path to blat binary if not in $PATH.

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
```


## seq-seq-pan_be

### Tool Description
A tool for pan-genome analysis and sequence manipulation.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py [-h] subcommand ...
seqseqpan.py: error: argument subcommand: invalid choice: 'be' (choose from 'blockcountsplit', 'extract', 'join', 'maf', 'map', 'mapall', 'merge', 'realign', 'reconstruct', 'remove', 'resolve', 'separate', 'split', 'xmfa')
```


## seq-seq-pan_reconstruct

### Tool Description
Build alignment of all genomes from .XMFA file with new genome aligned to consensus sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py reconstruct [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x
                                XMFA_F -c CONSENSUS_F [-o ORDER]

Build alignment of all genomes from .XMFA file with new genome aligned to
consensus sequence.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.
  -o ORDER, --order ORDER
                        Ordering of blocks in XMFA/FASTA output (0,1,2,...)
                        [default: 0]

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
  -c CONSENSUS_F, --consensus CONSENSUS_F
                        consensus FASTA file used in XMFA
```


## seq-seq-pan_genome

### Tool Description
A tool for pan-genome analysis and sequence alignment manipulation.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py [-h] subcommand ...
seqseqpan.py: error: argument subcommand: invalid choice: 'genome' (choose from 'blockcountsplit', 'extract', 'join', 'maf', 'map', 'mapall', 'merge', 'realign', 'reconstruct', 'remove', 'resolve', 'separate', 'split', 'xmfa')
```


## seq-seq-pan_remove

### Tool Description
Remove a genome from all LCBs in alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py remove [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x XMFA_F
                           [-o ORDER] -r RM_GENOME

Remove a genome from all LCBs in alignment.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.
  -o ORDER, --order ORDER
                        Ordering of blocks in XMFA/FASTA output (0,1,2,...)
                        [default: 0]

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
  -r RM_GENOME, --removegenome RM_GENOME
                        Number of genome to remove (as shown in XMFA header)
```


## seq-seq-pan_resolve

### Tool Description
Resolve LCBs stretching over delimiter sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py resolve [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x
                            XMFA_F -c CONSENSUS_F [-o ORDER]

Resolve LCBs stretching over delimiter sequences.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.
  -o ORDER, --order ORDER
                        Ordering of blocks in XMFA/FASTA output (0,1,2,...)
                        [default: 0]

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
  -c CONSENSUS_F, --consensus CONSENSUS_F
                        consensus FASTA file used in XMFA
```


## seq-seq-pan_separate

### Tool Description
Separate small multi-sequence LCBs to form genome specific entries.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py separate [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x
                             XMFA_F [-o ORDER] [-l LCB_LENGTH]

Separate small multi-sequence LCBs to form genome specific entries.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.
  -o ORDER, --order ORDER
                        Ordering of blocks in XMFA/FASTA output (0,1,2,...)
                        [default: 0]
  -l LCB_LENGTH, --length LCB_LENGTH
                        Length of "small LCB". [default: 10]

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
```


## seq-seq-pan_split

### Tool Description
Split LCBs according to chromosome annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py split [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x XMFA_F
                          -g GENOME_DESC_F [-o ORDER]

Split LCBs according to chromosome annotation.

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.
  -o ORDER, --order ORDER
                        Ordering of blocks in XMFA/FASTA output (0,1,2,...)
                        [default: 0]

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
  -g GENOME_DESC_F, --genome_desc GENOME_DESC_F
                        File containing genome description (name/chromosomes)
                        for .MAF file creation and 'split' task. Format:
                        'genome id<TAB>name<TAB>length' Length information is
                        only necessary for FASTA files containing more than
                        one chromosome. Multiple chromosomes of a genome must
                        be listed in the same order as in original FASTA file.
```


## seq-seq-pan_xmfa

### Tool Description
Write XMFA file from XMFA file (for reordering or checking validity).

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
- **Homepage**: https://gitlab.com/chrjan/seq-seq-pan
- **Package**: https://anaconda.org/channels/bioconda/packages/seq-seq-pan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqseqpan.py xmfa [-h] [--quiet] -p OUTPUT_P -n OUTPUT_NAME -x XMFA_F
                         [-o ORDER]

Write XMFA file from XMFA file (for reordering or checking validity).

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Suppress warnings.
  -o ORDER, --order ORDER
                        Ordering of blocks in XMFA/FASTA output (0,1,2,...)
                        [default: 0]

required arguments:
  -p OUTPUT_P, --output_path OUTPUT_P
                        path to output directory
  -n OUTPUT_NAME, --name OUTPUT_NAME
                        File prefix and sequence header for output FASTA /
                        XFMA file
  -x XMFA_F, --xmfa XMFA_F
                        XMFA input file
```


## Metadata
- **Skill**: generated
