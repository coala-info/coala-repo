# hocort CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hocort_index_bbmap | PASS |  |
| hocort_index_bowtie2 | PASS |  |
| hocort_index_bwamem2 | PASS |  |
| hocort_index_hisat2 | PASS |  |
| hocort_index_minimap2 | PASS |  |
| hocort_map_bbmap | PASS |  |
| hocort_map_bowtie2 | PASS |  |
| hocort_map_bwamem2 | PASS |  |
| hocort_map_hisat2 | PASS |  |
| hocort_map_minimap2 | PASS |  |

## hocort_index_bowtie2

### Tool Description
build a Bowtie2 index for host read removal

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort index Bowtie2 [-h] -i <fasta> -o <index>

Bowtie2 aligner

optional arguments:
  -h, --help            show this help message and exit
  -i <fasta>, --input <fasta>
                        str: path to sequence files (required)
  -o <index>, --output <index>
                        str: path to output index (dir/basename) (required)
```

## hocort_index_hisat2

### Tool Description
build a HISAT2 index for host read removal

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort index HISAT2 [-h] [--threads <int>] -i <fasta> -o <index>

HISAT2 aligner

optional arguments:
  -h, --help            show this help message and exit
  -i <fasta>, --input <fasta>
                        str: path to sequence files (required)
  -o <index>, --output <index>
                        str: path to output index (dir/basename) (required)
  -t <int>, --threads <int>
                        int: number of threads (default: max available on
                        machine)
```

## hocort_index_bwamem2

### Tool Description
build a BWA-MEM2 index for host read removal

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort index BWA_MEM2 [-h] -i <fasta> -o <index>

BWA_MEM2 aligner

optional arguments:
  -h, --help            show this help message and exit
  -i <fasta>, --input <fasta>
                        str: path to sequence files (required)
  -o <index>, --output <index>
                        str: path to output index (dir/basename) (required)
```

## hocort_index_minimap2

### Tool Description
build a Minimap2 index for host read removal

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort index Minimap2 [-h] [--threads <int>] [--preset <type>] -i <fasta> -o <index>

Minimap2 aligner

optional arguments:
  -h, --help            show this help message and exit
  -i <fasta>, --input <fasta>
                        str: path to sequence files (required)
  -o <index>, --output <index>
                        str: path to output index (dir/basename) (required)
  -t <int>, --threads <int>
                        int: number of threads (default: max available on
                        machine)
  -p {illumina,nanopore,pacbio}, --preset {illumina,nanopore,pacbio}
                        str: type of reads (default: illumina)
```

## hocort_index_bbmap

### Tool Description
build a BBMap index for host read removal

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort index BBMap [-h] [--threads <int>] -i <fasta> -o <index>

BBMap aligner

optional arguments:
  -h, --help            show this help message and exit
  -i <fasta>, --input <fasta>
                        str: path to sequence files (required)
  -o <index>, --output <index>
                        str: path to output index (dir/basename) (required)
  -t <int>, --threads <int>
                        int: number of threads (default: max available on
                        machine)
```

## hocort_map_bowtie2

### Tool Description
map reads to a Bowtie2 index and output mapped/unmapped reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort map Bowtie2 [-h] [--threads <int>] [--filter <bool>] [--preset <str>] [-c=<str>] -x <idx> -i <fastq_1> [<fastq_2>] -o <fastq_1> [<fastq_2>]

Bowtie2 pipeline

optional arguments:
  -h, --help            show this help message and exit
  -x <idx>, --index <idx>
                        str: path to Bowtie2 index (required)
  -i <fastq_1> [<fastq_2> ...], --input <fastq_1> [<fastq_2> ...]
                        str: path to sequence files, max 2 (required)
  -o <fastq_1> [<fastq_2> ...], --output <fastq_1> [<fastq_2> ...]
                        str: path to output files, max 2 (required)
  -t <int>, --threads <int>
                        int: number of threads (default: max available on
                        machine)
  -p {local,end-to-end}, --preset {local,end-to-end}
                        str: operation mode (default: end-to-end)
  -f {true,false}, --filter {true,false}
                        str: set to false to output mapped sequences, true to
                        output unmapped sequences (default: true)
  -c <str>, --config <str>
                        str: used to pass along arguments to the aligner, use
                        with caution, usage: -c="list arguments here"
```

## hocort_map_hisat2

### Tool Description
map reads to a HISAT2 index and output mapped/unmapped reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort map HISAT2 [-h] [--threads <int>] [--filter <bool>] [-c=<str>] -x <idx> -i <fastq_1> [<fastq_2>] -o <fastq_1> [<fastq_2>]

HISAT2 pipeline

optional arguments:
  -h, --help            show this help message and exit
  -x <idx>, --index <idx>
                        str: path to HISAT2 index (required)
  -i <fastq_1> [<fastq_2> ...], --input <fastq_1> [<fastq_2> ...]
                        str: path to sequence files, max 2 (.gz compression
                        supported) (required)
  -o <fastq_1> [<fastq_2> ...], --output <fastq_1> [<fastq_2> ...]
                        str: path to output files, max 2 (.gz compression
                        supported) (required)
  -t <int>, --threads <int>
                        int: number of threads (default: max available on
                        machine)
  -f {true,false}, --filter {true,false}
                        str: set to false to output mapped sequences, true to
                        output unmapped sequences (default: true)
  -c <str>, --config <str>
                        str: used to pass along arguments to the aligner, use
                        with caution, usage: -c="list arguments here"
```

## hocort_map_bwamem2

### Tool Description
map reads to a BWA-MEM2 index and output mapped/unmapped reads (gz input not supported)

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort map BWA_MEM2 [-h] [--threads <int>] [--filter <bool>] [-c=<str>] -x <idx> -i <fastq_1> [<fastq_2>] -o <fastq_1> [<fastq_2>]

BWA_MEM2 pipeline

optional arguments:
  -h, --help            show this help message and exit
  -x <idx>, --index <idx>
                        str: path to BWA_MEM2 index (required)
  -i <fastq_1> [<fastq_2> ...], --input <fastq_1> [<fastq_2> ...]
                        str: path to sequence files, max 2 (.gz compression
                        NOT supported) (required)
  -o <fastq_1> [<fastq_2> ...], --output <fastq_1> [<fastq_2> ...]
                        str: path to output files, max 2 (.gz compression
                        supported) (required)
  -t <int>, --threads <int>
                        int: number of threads (default: max available on
                        machine)
  -f {true,false}, --filter {true,false}
                        str: set to false to output mapped sequences, true to
                        output unmapped sequences (default: true)
  -c <str>, --config <str>
                        str: used to pass along arguments to the aligner, use
                        with caution, usage: -c="list arguments here"
```

## hocort_map_minimap2

### Tool Description
map reads to a Minimap2 index and output mapped/unmapped reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort map Minimap2 [-h] [--threads <int>] [--filter <bool>] [--preset <str>] [-c=<str>] -x <idx> -i <fastq_1> [<fastq_2>] -o <fastq_1> [<fastq_2>]

Minimap2 pipeline

optional arguments:
  -h, --help            show this help message and exit
  -x <idx>, --index <idx>
                        str: path to Minimap2 index (required)
  -i <fastq_1> [<fastq_2> ...], --input <fastq_1> [<fastq_2> ...]
                        str: path to sequence files, max 2 (.gz compression
                        supported) (required)
  -o <fastq_1> [<fastq_2> ...], --output <fastq_1> [<fastq_2> ...]
                        str: path to output files, max 2 (.gz compression
                        supported) (required)
  -t <int>, --threads <int>
                        int: number of threads (default: max available on
                        machine)
  -f {true,false}, --filter {true,false}
                        str: set to false to output mapped sequences, true to
                        output unmapped sequences (default: true)
  -p {illumina,nanopore,pacbio}, --preset {illumina,nanopore,pacbio}
                        str: type of reads (default: illumina)
  -c <str>, --config <str>
                        str: used to pass along arguments to the aligner, use
                        with caution, usage: -c="list arguments here"
```

## hocort_map_bbmap

### Tool Description
map reads to a BBMap index and output mapped/unmapped reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
- **Homepage**: https://github.com/ignasrum/hocort
- **Package**: https://anaconda.org/channels/bioconda/packages/hocort/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hocort map BBMap [-h] [--threads <int>] [--filter <bool>] [--preset <type>] [-c=<str>] -x <idx> -i <fastq_1> [<fastq_2>] -o <fastq_1> [<fastq_2>]

BBMap pipeline

optional arguments:
  -h, --help            show this help message and exit
  -x <idx>, --index <idx>
                        str: path to BBMap index (required)
  -i <fastq_1> [<fastq_2> ...], --input <fastq_1> [<fastq_2> ...]
                        str: path to sequence files, max 2 (.gz compression
                        supported) (required)
  -o <fastq_1> [<fastq_2> ...], --output <fastq_1> [<fastq_2> ...]
                        str: path to output files, max 2 (.gz compression
                        supported) (required)
  -t <int>, --threads <int>
                        int: number of threads (default: max available on
                        machine)
  -f {true,false}, --filter {true,false}
                        str: set to false to output mapped sequences, true to
                        output unmapped sequences (default: true)
  -p {illumina,nanopore}, --preset {illumina,nanopore}
                        str: type of reads (default: illumina)
  -c <str>, --config <str>
                        str: used to pass along arguments to the aligner, use
                        with caution, usage: -c="list arguments here"
```

## Metadata
- **Skill**: generated
