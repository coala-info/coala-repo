# knot-asm-analysis CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| knot-asm-analysis_knot | Not completed | pipeline, skipped: knot runs a Snakemake workflow; baseCommand fixed from KNOT to knot |
| knot-asm-analysis_knot.analysis | PASS |  |
| knot-asm-analysis_knot.analysis.classifications | PASS |  |
| knot-asm-analysis_knot.analysis.hamilton_path | PASS |  |
| knot-asm-analysis_knot.extremity_search | PASS |  |
| knot-asm-analysis_knot.filter_tig | PASS |  |
| knot-asm-analysis_knot.path_search | PASS |  |
| knot-asm-analysis_knot.sg_generation | PASS |  |

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


## knot-asm-analysis_knot.analysis.classifications

### Tool Description
usage: knot.analysis.classifications [-h] -i INPUT -o OUTPUT [-t THRESHOLD]

### Metadata
- **Docker Image**: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
- **Homepage**: https://github.com/natir/knot
- **Package**: https://anaconda.org/channels/bioconda/packages/knot-asm-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knot.analysis.classifications [-h] -i INPUT -o OUTPUT [-t THRESHOLD]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        path to the AAG
  -o OUTPUT, --output OUTPUT
                        path where classification report was write
  -t THRESHOLD, --threshold THRESHOLD
                        path length threshold
```

## knot-asm-analysis_knot.analysis.hamilton_path

### Tool Description
usage: knot.analysis.classifications [-h] -i INPUT -o OUTPUT [-c]

### Metadata
- **Docker Image**: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
- **Homepage**: https://github.com/natir/knot
- **Package**: https://anaconda.org/channels/bioconda/packages/knot-asm-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knot.analysis.classifications [-h] -i INPUT -o OUTPUT [-c]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        path to the AAG
  -o OUTPUT, --output OUTPUT
                        path where hamilton path was write
  -c, --circular        genome is circular
```

## knot-asm-analysis_knot.extremity_search

### Tool Description
usage: knot.extremity_search [-h] read2tig read2read output

### Metadata
- **Docker Image**: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
- **Homepage**: https://github.com/natir/knot
- **Package**: https://anaconda.org/channels/bioconda/packages/knot-asm-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knot.extremity_search [-h] read2tig read2read output

positional arguments:
  read2tig    read mapped against asm
  read2read   SG graph
  output      file where extremity are writed

optional arguments:
  -h, --help  show this help message and exit
```

## knot-asm-analysis_knot.filter_tig

### Tool Description
usage: filter_contig [-h] [-t THRESHOLD] input output

### Metadata
- **Docker Image**: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
- **Homepage**: https://github.com/natir/knot
- **Package**: https://anaconda.org/channels/bioconda/packages/knot-asm-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_contig [-h] [-t THRESHOLD] input output

positional arguments:
  input                 input fasta
  output                output fasta

optional arguments:
  -h, --help            show this help message and exit
  -t THRESHOLD, --threshold THRESHOLD
                        Only sequence with size upper than threshold are write
                        in output default 100.000
```

## knot-asm-analysis_knot.path_search

### Tool Description
usage: knot.path_search [-h] [--search-mode {base,node}] [--self-lookup]

### Metadata
- **Docker Image**: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
- **Homepage**: https://github.com/natir/knot
- **Package**: https://anaconda.org/channels/bioconda/packages/knot-asm-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knot.path_search [-h] [--search-mode {base,node}] [--self-lookup]
                        search result ovl_graph read2asm asm_graph tig2tig

positional arguments:
  search
  result
  ovl_graph
  read2asm
  asm_graph
  tig2tig

optional arguments:
  -h, --help            show this help message and exit
  --search-mode {base,node}
                        what path search optimize, number of base or number of
                        node (default: base)
  --self-lookup         if it set knot search path between extremity of same
                        contig (default: False)
```

## knot-asm-analysis_knot.sg_generation

### Tool Description
usage: knot.sg_generation [-h] reads2contig input output

### Metadata
- **Docker Image**: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
- **Homepage**: https://github.com/natir/knot
- **Package**: https://anaconda.org/channels/bioconda/packages/knot-asm-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knot.sg_generation [-h] reads2contig input output

positional arguments:
  reads2contig
  input
  output

optional arguments:
  -h, --help    show this help message and exit
```

## Metadata
- **Skill**: generated
