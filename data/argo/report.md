# argo CWL Generation Report

## argo

### Tool Description
species-resolved profiling of antibiotic resistance genes in complex metagenomes through long-read overlapping

### Metadata
- **Docker Image**: quay.io/biocontainers/argo:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/xinehc/argo
- **Package**: https://anaconda.org/channels/bioconda/packages/argo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/argo/overview
- **Total Downloads**: 4.3K
- **Last updated**: 2025-05-07
- **GitHub**: https://github.com/xinehc/argo
- **Stars**: N/A
### Original Help Text
```text
Usage: argo -d DIR -o DIR [-t INT] [--plasmid] [--skip-melon] [--skip-clean]
            [-m INT] [-e FLOAT] [-i FLOAT] [-s FLOAT] [-n INT] [-p FLOAT]
            [-z FLOAT] [-u INT] [-b INT] [-x FLOAT] [-y FLOAT]
            file [file ...]

Argo v0.2.1: species-resolved profiling of antibiotic resistance genes in
complex metagenomes through long-read overlapping

Positional Arguments:
  file               Input fasta <*.fa|*.fasta> or fastq <*.fq|*.fastq> file,
                     gzip optional <*.gz>.

Required Arguments:
  -d, --db DIR       Unzipped database folder, should contains
                     <prot.fa|sarg.fa>, <nucl.*.fa|sarg.*.fa> and metadata
                     files. (default: None)
  -o, --output DIR   Output folder. (default: None)

Optional Arguments:
  -t, --threads INT  Number of threads. [20] (default: 20)
  --plasmid          List ARGs carried by plasmids. (default: False)
  --skip-melon       Skip Melon for genome copy estimation. (default: False)
  --skip-clean       Skip cleaning, keep all temporary <*.tmp> files.
                     (default: False)

Additional Arguments - Filtering:
  -m INT             Max. number of target sequences to report
                     (--max-target-seqs/-k in diamond). (default: 25)
  -e FLOAT           Max. expected value to report alignments (--evalue/-e in
                     diamond). (default: 1e-05)
  -i FLOAT           Min. identity in percentage to report alignments. If "0"
                     then set 90 - 2.5 * 100 * median sequence divergence.
                     (default: 0)
  -s FLOAT           Min. subject cover within a read cluster to report
                     alignments. (default: 90)
  -n INT             Max. number of secondary alignments to report (-N in
                     minimap2). (default: 2147483647)
  -p FLOAT           Min. secondary-to-primary score ratio to report secondary
                     alignments (-p in minimap2). (default: 0.9)
  -z FLOAT           Min. estimated genome copies of a species to report it
                     ARG copies and abundances. (default: 1)
  -u INT             Max. number of ARG-containing reads per chunk for
                     overlapping. If "0" then use a single chunk. (default: 0)

Additional Arguments - Graph Clustering:
  -b INT             Terminal condition - max. iterations. (default: 1000)
  -x FLOAT           MCL parameter - inflation. (default: 2)
  -y FLOAT           MCL parameter - expansion. (default: 2)
```

