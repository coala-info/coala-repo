# recycler CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| recycler_get_simple_cycs.py | PASS |  |
| recycler_make_fasta_from_fastg.py | PASS |  |
| recycler_recycle.py | PASS |  |

## recycler_make_fasta_from_fastg.py

### Tool Description
make_fasta_from_fastg converts fastg assembly graph to fasta format

### Metadata
- **Docker Image**: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
- **Homepage**: https://github.com/Shamir-Lab/Recycler
- **Package**: https://anaconda.org/channels/bioconda/packages/recycler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/recycler/overview
- **Total Downloads**: 20.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Shamir-Lab/Recycler
- **Stars**: N/A
### Original Help Text
```text
usage: make_fasta_from_fastg.py [-h] -g GRAPH [-o OUTPUT]

make_fasta_from_fastg converts fastg assembly graph to fasta format

optional arguments:
  -h, --help            show this help message and exit
  -g GRAPH, --graph GRAPH
                        (spades 3.50+) FASTG file to process [recommended:
                        before_rr.fastg]
  -o OUTPUT, --output OUTPUT
                        output file name for FASTA of cycles
```


## recycler_recycle.py

### Tool Description
Recycler extracts likely plasmids (and other circular DNA elements) from de novo assembly graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
- **Homepage**: https://github.com/Shamir-Lab/Recycler
- **Package**: https://anaconda.org/channels/bioconda/packages/recycler/overview
- **Validation**: PASS

### Original Help Text
```text
usage: recycle.py [-h] -g GRAPH -k MAX_K -b BAM [-l LENGTH] [-m MAX_CV]
                  [-i ISO] [-o OUTPUT_DIR]

Recycler extracts likely plasmids (and other circular DNA elements) from de
novo assembly graphs

optional arguments:
  -h, --help            show this help message and exit
  -g GRAPH, --graph GRAPH
                        (spades 3.50+) assembly graph FASTG file to process;
                        recommended for spades 3.5: before_rr.fastg, for
                        spades 3.6+:assembly_graph.fastg
  -k MAX_K, --max_k MAX_K
                        integer reflecting maximum k value used by the
                        assembler
  -b BAM, --bam BAM     BAM file resulting from aligning reads to contigs
                        file, filtering for best matches
  -l LENGTH, --length LENGTH
                        minimum length required for reporting [default: 1000]
  -m MAX_CV, --max_CV MAX_CV
                        coefficient of variation used for pre-selection
                        [default: 0.5, higher--> less restrictive]
  -i ISO, --iso ISO     True or False value reflecting whether data sequenced
                        was an isolated strain
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory
```


## recycler_get_simple_cycs.py

### Tool Description
Gets simple (single contig) cycles from plasmid metagenomes and writes them to a separate FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
- **Homepage**: https://github.com/Shamir-Lab/Recycler
- **Package**: https://anaconda.org/channels/bioconda/packages/recycler/overview
- **Validation**: PASS

### Original Help Text
```text
[help] get_simple_cycs.py: ok via get_simple_cycs.py --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: get_simple_cycs.py [-h] -i INPUT [-m MIN_LENGTH]

gets simple (single contig) cycles from plasmid metagenomes, leaves rest of
graph as is; outputs these to two separate files

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input (SPAdes 3.50+) FASTG to process
  -m MIN_LENGTH, --min_length MIN_LENGTH
                        Minimum cycle length to keep (shorter cycles put in
                        new graph file; default = 1000)
```

## Metadata
- **Skill**: generated
