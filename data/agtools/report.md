# agtools CWL Generation Report

## agtools_stats

### Tool Description
Compute statistics about the graph

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Total Downloads**: 677
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/Vini2/agtools
- **Stars**: N/A
### Original Help Text
```text
Usage: agtools stats [OPTIONS]

  Compute statistics about the graph

Options:
  -g, --graph PATH   path(s) to the assembly graph file(s)  [required]
  -o, --output PATH  path to the output folder  [required]
  -h, --help         Show this message and exit.
```


## agtools_rename

### Tool Description
Rename segments, paths and walks in a GFA file

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools rename [OPTIONS]

  Rename segments, paths and walks in a GFA file

Options:
  -g, --graph PATH   path(s) to the assembly graph file(s)  [required]
  -p, --prefix TEXT  prefix for the graph elements  [default: ""]
  -o, --output PATH  path to the output folder  [required]
  -h, --help         Show this message and exit.
```


## agtools_concat

### Tool Description
Concatenate two or more GFA files

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools concat [OPTIONS]

  Concatenate two or more GFA files

Options:
  -g, --graph PATH   path(s) to the assembly graph file(s)  [required]
  -o, --output PATH  path to the output folder  [required]
  -h, --help         Show this message and exit.
```


## agtools_filter

### Tool Description
Filter segments from GFA file

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools filter [OPTIONS]

  Filter segments from GFA file

Options:
  -g, --graph PATH          path(s) to the assembly graph file(s)  [required]
  -l, --min-length INTEGER  minimum length of segments to keep  [default: 100;
                            required]
  -o, --output PATH         path to the output folder  [required]
  -h, --help                Show this message and exit.
```


## agtools_clean

### Tool Description
Clean a GFA file based on segments in a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools clean [OPTIONS]

  Clean a GFA file based on segments in a FASTA file

Options:
  -g, --graph PATH      path(s) to the assembly graph file(s)  [required]
  -f, --fasta PATH      path to the FASTA file
  -a, --assembler TEXT  assembler name (if assembler used is myloasm)
  -o, --output PATH     path to the output folder  [required]
  -h, --help            Show this message and exit.
```


## agtools_component

### Tool Description
Extract a component containing a given segment

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools component [OPTIONS]

  Extract a component containing a given segment

Options:
  -g, --graph PATH    path(s) to the assembly graph file(s)  [required]
  -s, --segment TEXT  segment ID  [required]
  -o, --output PATH   path to the output folder  [required]
  -h, --help          Show this message and exit.
```


## agtools_fastg2gfa

### Tool Description
Convert FASTG file to GFA format

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools fastg2gfa [OPTIONS]

  Convert FASTG file to GFA format

Options:
  -g, --graph PATH     path(s) to the assembly graph file(s)  [required]
  -k, --ksize INTEGER  k-mer size used for the assembly  [default: 141;
                       required]
  -o, --output PATH    path to the output folder  [required]
  -h, --help           Show this message and exit.
```


## agtools_asqg2gfa

### Tool Description
Convert ASQG file to GFA format

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools asqg2gfa [OPTIONS]

  Convert ASQG file to GFA format

Options:
  -g, --graph PATH   path(s) to the assembly graph file(s)  [required]
  -o, --output PATH  path to the output folder  [required]
  -h, --help         Show this message and exit.
```


## agtools_gfa2dot

### Tool Description
Convert GFA file to DOT format (GraphViz)

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools gfa2dot [OPTIONS]

  Convert GFA file to DOT format (GraphViz)

Options:
  -g, --graph PATH   path(s) to the assembly graph file(s)  [required]
  -ab, --abyss       use the ABySS DOT format for the output
  -o, --output PATH  path to the output folder  [required]
  -h, --help         Show this message and exit.
```


## agtools_gfa2fasta

### Tool Description
Get segments in FASTA format

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools gfa2fasta [OPTIONS]

  Get segments in FASTA format

Options:
  -g, --graph PATH   path(s) to the assembly graph file(s)  [required]
  -o, --output PATH  path to the output folder  [required]
  -h, --help         Show this message and exit.
```


## agtools_gfa2adj

### Tool Description
Get adjacency matrix of the assembly graph

### Metadata
- **Docker Image**: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
- **Homepage**: https://github.com/Vini2/agtools
- **Package**: https://anaconda.org/channels/bioconda/packages/agtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agtools gfa2adj [OPTIONS]

  Get adjacency matrix of the assembly graph

Options:
  -g, --graph PATH         path(s) to the assembly graph file(s)  [required]
  --delimiter [comma|tab]  delimiter for adjacency file. Supports a comma and
                           a tab.  [default: comma]
  -o, --output PATH        path to the output folder  [required]
  -h, --help               Show this message and exit.
```


## Metadata
- **Skill**: generated
