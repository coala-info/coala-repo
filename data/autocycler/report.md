# autocycler CWL Generation Report

## autocycler_clean

### Tool Description
manual manipulation of the final consensus assebly graph

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-08-13
- **GitHub**: https://github.com/rrwick/Autocycler
- **Stars**: N/A
### Original Help Text
```text
manual manipulation of the final consensus assebly graph

Usage: autocycler clean [OPTIONS] --in_gfa <IN_GFA> --out_gfa <OUT_GFA>

Options:
  -i, --in_gfa <IN_GFA>        Autocycler GFA file (required)
  -o, --out_gfa <OUT_GFA>      Output GFA file (required)
  -r, --remove <REMOVE>        Tig numbers to remove from the input graph
  -d, --duplicate <DUPLICATE>  Tig numbers to duplicate in the input graph
  -m, --min_depth <MIN_DEPTH>  Automatically remove tigs up to this depth
  -h, --help                   Print help
  -V, --version                Print version
```


## autocycler_cluster

### Tool Description
cluster contigs in the unitig graph based on similarity

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
cluster contigs in the unitig graph based on similarity

Usage: autocycler cluster [OPTIONS] --autocycler_dir <AUTOCYCLER_DIR>

Options:
  -a, --autocycler_dir <AUTOCYCLER_DIR>
          Autocycler directory containing input_assemblies.gfa file (required)
      --cutoff <CUTOFF>
          cutoff distance threshold for hierarchical clustering [default: 0.2]
      --min_assemblies <MIN_ASSEMBLIES>
          exclude clusters with fewer than this many assemblies [default: automatic]
      --max_contigs <MAX_CONTIGS>
          refuse to run if mean contigs per assembly exceeds this value [default: 25]
      --manual <MANUAL>
          manually define clusters using tree node numbers [default: automatic]
  -h, --help
          Print help
  -V, --version
          Print version
```


## autocycler_combine

### Tool Description
combine Autocycler GFAs into one assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
combine Autocycler GFAs into one assembly

Usage: autocycler combine --autocycler_dir <AUTOCYCLER_DIR> --in_gfas <IN_GFAS>...

Options:
  -a, --autocycler_dir <AUTOCYCLER_DIR>  Autocycler directory (required)
  -i, --in_gfas <IN_GFAS>...             Autocycler cluster GFA files (one or more required)
  -h, --help                             Print help
  -V, --version                          Print version
```


## autocycler_compress

### Tool Description
compress input contigs into a unitig graph

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
compress input contigs into a unitig graph

Usage: autocycler compress [OPTIONS] --assemblies_dir <ASSEMBLIES_DIR> --autocycler_dir <AUTOCYCLER_DIR>

Options:
  -i, --assemblies_dir <ASSEMBLIES_DIR>
          Directory containing input assemblies (required)
  -a, --autocycler_dir <AUTOCYCLER_DIR>
          Autocycler directory to be created (required)
      --kmer <KMER>
          K-mer size for De Bruijn graph [default: 51]
      --max_contigs <MAX_CONTIGS>
          refuse to run if mean contigs per assembly exceeds this value [default: 25]
  -t, --threads <THREADS>
          Number of CPU threads [default: 8]
  -h, --help
          Print help
  -V, --version
          Print version
```


## autocycler_decompress

### Tool Description
decompress contigs from a unitig graph

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
decompress contigs from a unitig graph

Usage: autocycler decompress [OPTIONS] --in_gfa <IN_GFA>

Options:
  -i, --in_gfa <IN_GFA>      Autocycler GFA file (required)
  -o, --out_dir <OUT_DIR>    Directory where decompressed sequences will be saved (either -o or -f
                             is required)
  -f, --out_file <OUT_FILE>  FASTA file where decompressed sequences will be saved (either -o or -f
                             is required)
  -h, --help                 Print help
  -V, --version              Print version
```


## autocycler_dotplot

### Tool Description
generate an all-vs-all dotplot from a unitig graph

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
generate an all-vs-all dotplot from a unitig graph

Usage: autocycler dotplot [OPTIONS] --input <INPUT> --out_png <OUT_PNG>

Options:
  -i, --input <INPUT>      Input Autocycler GFA file, FASTA file or directory (required)
  -o, --out_png <OUT_PNG>  File path where dotplot PNG will be saved (required)
      --res <RES>          Size (in pixels) of dotplot image [default: 2000]
      --kmer <KMER>        K-mer size to use in dotplot [default: 32]
  -h, --help               Print help
  -V, --version            Print version
```


## autocycler_gfa2fasta

### Tool Description
convert an Autocycler GFA file to FASTA format

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
convert an Autocycler GFA file to FASTA format

Usage: autocycler gfa2fasta --in_gfa <IN_GFA> --out_fasta <OUT_FASTA>

Options:
  -i, --in_gfa <IN_GFA>        Input Autocycler GFA file (required)
  -o, --out_fasta <OUT_FASTA>  Output FASTA file (required)
  -h, --help                   Print help
  -V, --version                Print version
```


## autocycler_helper

### Tool Description
helper commands for long-read assemblers

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
helper commands for long-read assemblers

Usage: autocycler helper [OPTIONS] --reads <READS> <TASK>

Arguments:
  <TASK>  Task (required positional) [possible values: genome_size, canu, flye, hifiasm, lja,
          metamdbg, miniasm, myloasm, necat, nextdenovo, plassembler, raven, redbean]

Options:
  -r, --reads <READS>                  Input long reads in FASTQ format (required)
  -o, --out_prefix <OUT_PREFIX>        Output prefix (required for all tasks except genome_size)
  -g, --genome_size <GENOME_SIZE>      Estimated genome size (required for some tasks)
  -t, --threads <THREADS>              Number of CPU threads [default: 8]
  -d, --dir <DIR>                      Working directory [default: use a temporary directory]
      --read_type <READ_TYPE>          Read type [default: ont_r10] [possible values: ont_r9,
                                       ont_r10, pacbio_clr, pacbio_hifi]
      --min_depth_abs <MIN_DEPTH_ABS>  Exclude contigs with read depth less than this absolute value
      --min_depth_rel <MIN_DEPTH_REL>  Exclude contigs with read depth less than this fraction of
                                       the longest contig's depth
      --args <ARGS>...                 Additional arguments for the task
  -h, --help                           Print help
  -V, --version                        Print version
```


## autocycler_resolve

### Tool Description
resolve repeats in the the unitig graph

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
resolve repeats in the the unitig graph

Usage: autocycler resolve [OPTIONS] --cluster_dir <CLUSTER_DIR>

Options:
  -c, --cluster_dir <CLUSTER_DIR>  Autocycler directory (required)
      --verbose                    Enable verbose output
  -h, --help                       Print help
  -V, --version                    Print version
```


## autocycler_subsample

### Tool Description
subsample a long-read set

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
subsample a long-read set

Usage: autocycler subsample [OPTIONS] --reads <READS> --out_dir <OUT_DIR> --genome_size <GENOME_SIZE>

Options:
  -r, --reads <READS>                    Input long reads in FASTQ format (required)
  -o, --out_dir <OUT_DIR>                Output directory (required)
  -g, --genome_size <GENOME_SIZE>        Estimated genome size (required)
  -c, --count <COUNT>                    Number of subsampled read sets to output [default: 4]
  -d, --min_read_depth <MIN_READ_DEPTH>  Minimum allowed read depth [default: 25.0]
  -s, --seed <SEED>                      Seed for random number generator [default: 0]
  -h, --help                             Print help
  -V, --version                          Print version
```


## autocycler_table

### Tool Description
create TSV line from YAML files

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
create TSV line from YAML files

Usage: autocycler table [OPTIONS]

Options:
  -a, --autocycler_dir <AUTOCYCLER_DIR>
          Autocycler directory (if absent, a header line will be output)
  -n, --name <NAME>
          Sample name [default: blank]
  -f, --fields <FIELDS>
          Comma-delimited list of YAML fields to include [default: "input_read_count,
          input_read_bases, input_read_n50, pass_cluster_count, fail_cluster_count,
          overall_clustering_score, untrimmed_cluster_size, untrimmed_cluster_distance,
          trimmed_cluster_size, trimmed_cluster_median, trimmed_cluster_mad,
          consensus_assembly_bases, consensus_assembly_unitigs, consensus_assembly_fully_resolved"]
  -s, --sigfigs <SIGFIGS>
          Significant figures to use for floating point numbers [default: 3]
  -h, --help
          Print help
  -V, --version
          Print version
```


## autocycler_trim

### Tool Description
trim contigs in a cluster

### Metadata
- **Docker Image**: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Autocycler
- **Package**: https://anaconda.org/channels/bioconda/packages/autocycler/overview
- **Validation**: PASS

### Original Help Text
```text
trim contigs in a cluster

Usage: autocycler trim [OPTIONS] --cluster_dir <CLUSTER_DIR>

Options:
  -c, --cluster_dir <CLUSTER_DIR>    Autocycler cluster directory containing 1_untrimmed.gfa file
                                     (required)
      --min_identity <MIN_IDENTITY>  Minimum alignment identity for trimming alignments [default:
                                     0.75]
      --max_unitigs <MAX_UNITIGS>    Maximum unitigs used for overlap alignment, set to 0 to disable
                                     trimming [default: 5000]
      --mad <MAD>                    Allowed variability in cluster length, measured in median
                                     absolute deviations, set to 0 to disable exclusion of length
                                     outliers [default: 5.0]
  -t, --threads <THREADS>            Number of CPU threads [default: 8]
  -h, --help                         Print help
  -V, --version                      Print version
```


## Metadata
- **Skill**: generated
