# knot-asm-analysis CWL Generation Report

## knot-asm-analysis_knot

### Tool Description
KNOT is a tool for analyzing contigs and their assembly graphs.

### Metadata
- **Docker Image**: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
- **Homepage**: https://github.com/natir/knot
- **Package**: https://anaconda.org/channels/bioconda/packages/knot-asm-analysis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/knot-asm-analysis/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/natir/knot
- **Stars**: N/A
### Original Help Text
```text
usage: KNOT [-h] -c CONTIGS [-g CONTIGS_GRAPH]
            (-r RAW_READS | -C CORRECT_READS) -o OUTPUT
            [--search-mode {base,node}]
            [--contig-min-length CONTIG_MIN_LENGTH] [--read-type {pb,ont}]
            [--self-lookup] [--help-all]

optional arguments:
  -h, --help            show this help message and exit
  -c CONTIGS, --contigs CONTIGS
                        fasta file than contains contigs
  -g CONTIGS_GRAPH, --contigs_graph CONTIGS_GRAPH
                        contigs graph
  -r RAW_READS, --raw-reads RAW_READS
                        read used for assembly
  -C CORRECT_READS, --correct-reads CORRECT_READS
                        read used for assembly
  -o OUTPUT, --output OUTPUT
                        output prefix
  --search-mode {base,node}
                        what path search optimize, number of base or number of
                        node
  --contig-min-length CONTIG_MIN_LENGTH
                        contig with size lower this parameter are ignored
  --read-type {pb,ont}  type of input read, default pb
  --self-lookup         if it set knot search path between extremity of same
                        contig
  --help-all            show knot help and snakemake help
```


## knot-asm-analysis_knot.analysis

### Tool Description
Generate a report from knot output.

### Metadata
- **Docker Image**: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
- **Homepage**: https://github.com/natir/knot
- **Package**: https://anaconda.org/channels/bioconda/packages/knot-asm-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knot.analysis.generate_report [-h] -i INPUT_PREFIX -o OUTPUT [-c] [-p]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_PREFIX, --input_prefix INPUT_PREFIX
                        prefix of knot output
  -o OUTPUT, --output OUTPUT
                        path where report was write
  -c, --classification  Add path classification in report
  -p, --hamilton-path   Add hamilton path in report
```

