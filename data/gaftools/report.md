# gaftools CWL Generation Report

## gaftools_find_path

### Tool Description
Find the genomic sequence of a given connected GFA path.

### Metadata
- **Docker Image**: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/marschall-lab/gaftools
- **Package**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Total Downloads**: 601
- **Last updated**: 2026-01-28
- **GitHub**: https://github.com/marschall-lab/gaftools
- **Stars**: N/A
### Original Help Text
```text
usage: gaftools find_path [-h] [-p PATH] [--paths_file PATHS_FILE] [-k]
                          [-o OUTPUT] [-f]
                          GFA

Find the genomic sequence of a given connected GFA path.

positional arguments:
  GFA                   GFA file (can be bgzip-compressed)

optional arguments:
  -h, --help            show this help message and exit
  -p PATH, --path PATH  GFA node path to retrieve the sequence (e.g.,
                        ">s82312<s82313") with the quotes
  --paths_file PATHS_FILE
                        File containing the paths to retrieve the sequences
                        for, each path on new line
  -k, --keep-going      Keep going after instead of stopping when a path does
                        not exist
  -o OUTPUT, --output OUTPUT
                        Output file. If omitted, use standard output.
  -f, --fasta           Flag to output the sequence as a FASTA file with the
                        seqeunce named seq_<node path>
gaftools error: argument -h/--help: ignored explicit argument 'elp'
```


## gaftools_gfa2rgfa

### Tool Description
Converting a GFA file to rGFA format using the W-lines and the acyclic reference path. (e.g., minigraph-based graphs)

### Metadata
- **Docker Image**: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/marschall-lab/gaftools
- **Package**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gaftools gfa2rgfa [-h] [--reference-name REFERENCE NAME]
                         [--reference-tagged] [--seqfile SEQFILE]
                         [--output rGFA]
                         GFA

Converting a GFA file to rGFA format using the W-lines and the acyclic reference path. (e.g., minigraph-based graphs)

positional arguments:
  GFA                   GFA file (can be bgzip-compressed). This GFA should
                        have a W-line corresponding to the reference genome or
                        the reference nodes have to be tagged already.

optional arguments:
  -h, --help            show this help message and exit
  --reference-name REFERENCE NAME
                        The name of the reference genome given in the W-line.
                        Default: CHM13
  --reference-tagged    Flag to denote reference nodes are already tagged in
                        the GFA.
  --seqfile SEQFILE     File containing the sequence in which assemblies were
                        given. Provide the seqfile given as part of running
                        minigraph-cactus (only the first column is required).
                        It has the format:
                        <assembly_name><tab><assembly_path>. If not provided,
                        the order of assemblies will be taken from the GFA
                        file. User-defined order of assemblies can also be
                        given. There should be W lines for each assembly in
                        the GFA.
  --output rGFA         Output rGFA (bgzipped if the file ends with .gz). If
                        omitted, use standard output.
gaftools error: argument -h/--help: ignored explicit argument 'elp'
```


## gaftools_index

### Tool Description
Index a GAF file for the view functionality.

### Metadata
- **Docker Image**: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/marschall-lab/gaftools
- **Package**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gaftools index [-h] [-o OUTPUT] GAF rGFA

Index a GAF file for the view functionality.

This script creates an inverse look-up table where:
    - key: the node information
    - value: the offsets in the GAF file where the node is present

positional arguments:
  GAF                   GAF file (can be bgzip-compressed)
  rGFA                  rGFA file (can be bgzip-compressed)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output GAF View Index (GVI) file. Default: <GAF
                        file>.gvi
gaftools error: argument -h/--help: ignored explicit argument 'elp'
```


## gaftools_order_gfa

### Tool Description
Order bubbles in the GFA by adding BO and NO tags.

### Metadata
- **Docker Image**: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/marschall-lab/gaftools
- **Package**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gaftools order_gfa [-h] [--chromosome-order CHROMOSOME_ORDER]
                          [--without-sequence] [--outdir OUTDIR] [--by-chrom]
                          [--ignore-branching] [--output-scaffold]
                          GRAPH

Order bubbles in the GFA by adding BO and NO tags.

The BO (Bubble Order) tags order bubbles in the GFA.
The NO (Node Order) tags order the nodes in a bubble (in a lexicographic order).

positional arguments:
  GRAPH                 Input rGFA file

optional arguments:
  -h, --help            show this help message and exit
  --chromosome-order CHROMOSOME_ORDER
                        Order in which to arrange chromosomes in terms of BO
                        sorting. By default, it is arranged in the
                        lexicographic order of identified component names.
                        Expecting comma-separated list. Example:
                        'chr1,chr2,chr3'
  --without-sequence    Strip sequences from the output graph (for less memory
                        usage and easier visualization). Default = False
  --outdir OUTDIR       Output Directory to store all the GFA and CSV files.
                        Default location is a "out" folder from the directory
                        of execution.
  --by-chrom            Outputs each chromosome as a separate GFA, otherwise,
                        all chromosomes in one GFA file
  --ignore-branching    Force the order even when branching paths occur in the
                        scaffold graph. Alternative alleles will not be
                        ordered
  --output-scaffold     Output the scaffold graph in GFA format. The scaffold
                        graph is the graph created from collapsing all the
                        biconnected components.
gaftools error: argument -h/--help: ignored explicit argument 'elp'
```


## gaftools_phase

### Tool Description
Add phasing information to the GAF file from a haplotag TSV file.

The script uses the TSV file containing the haplotag information generated from WhatsHap's haplotag command.
The H1 and H2 labels for each read are then added to the reads in the GAF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/marschall-lab/gaftools
- **Package**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gaftools phase [-h] [-o OUTPUT] GAF TSV

Add phasing information to the GAF file from a haplotag TSV file.

The script uses the TSV file containing the haplotag information generated from WhatsHap's haplotag command.
The H1 and H2 labels for each read are then added to the reads in the GAF file.

positional arguments:
  GAF                   GAF file (can be bgzip-compressed)
  TSV                   WhatsHap haplotag TSV file. Refer to https://whatshap.
                        readthedocs.io/en/latest/guide.html#whatshap-haplotag

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output GAF file (bgzipped if the file ends with .gz).
                        If omitted, output is directed to stdout.
gaftools error: argument -h/--help: ignored explicit argument 'elp'
```


## gaftools_realign

### Tool Description
Realign a GAF file using wavefront alignment algorithm (WFA).

### Metadata
- **Docker Image**: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/marschall-lab/gaftools
- **Package**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gaftools realign [-h] [-o OUTPUT] [-c CORES] GAF GFA FASTA

Realign a GAF file using wavefront alignment algorithm (WFA).

positional arguments:
  GAF                   GAF file (can be bgzip-compressed)
  GFA                   GFA file (can be bgzip-compressed)
  FASTA                 FASTA file of the read

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output GAF file (bgzipped if the file ends with .gz).
                        If omitted, use standard output.
  -c CORES, --cores CORES
                        Number of cores to use for alignments.
gaftools error: the following arguments are required: GAF, GFA, FASTA
```


## gaftools_sort

### Tool Description
Sort the GAF alignments using BO and NO tags of the corresponding graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/marschall-lab/gaftools
- **Package**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gaftools sort [-h] [--outgaf OUTGAF] [--outind OUTIND] GAF GFA

Sort the GAF alignments using BO and NO tags of the corresponding graph.

positional arguments:
  GAF              GAF File (can be bgzip-compressed)
  GFA              GFA file with the sort keys (BO and NO tagged). This is
                   done with gaftools order_gfa

optional arguments:
  -h, --help       show this help message and exit
  --outgaf OUTGAF  Output GAF (bgzipped if the file ends with .gz). If
                   omitted, use standard output.
  --outind OUTIND  Output GAF Sorting Index file. When --outgaf is not given,
                   no index is created. If it is given and --outind is not
                   specified, it will have same file name with .gsi extension)
gaftools error: argument -h/--help: ignored explicit argument 'elp'
```


## gaftools_stat

### Tool Description
Calculate statistics of the given GAF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/marschall-lab/gaftools
- **Package**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gaftools stat [-h] [-o OUTPUT] [--cigar] GAF

Calculate statistics of the given GAF file.

positional arguments:
  GAF                   GAF file (can be bgzip-compressed)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output file. If omitted, use standard output.
  --cigar               Outputs cigar related statistics (requires more time)
gaftools error: argument -h/--help: ignored explicit argument 'elp'
```


## gaftools_view

### Tool Description
View, subset or convert a GAF file (GAF file should be indexed first, using gaftools index).

The view command allows subsetting the GAF file based on node IDs or regions available.

### Metadata
- **Docker Image**: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/marschall-lab/gaftools
- **Package**: https://anaconda.org/channels/bioconda/packages/gaftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gaftools view [-h] [-g GFA] [-o OUTPUT] [-i INDEX] [-n NODE]
                     [-r REGION] [-f FORMAT]
                     GAF

View, subset or convert a GAF file (GAF file should be indexed first, using gaftools index).

The view command allows subsetting the GAF file based on node IDs or regions available.

positional arguments:
  GAF                   GAF file (can be bgzip-compressed)

optional arguments:
  -h, --help            show this help message and exit
  -g GFA, --gfa GFA     GFA file (can be bggzip-compressed). Required when
                        converting from one coordinate system to another.
  -o OUTPUT, --output OUTPUT
                        Output GAF (bgzipped if the file ends with .gz). If
                        omitted, use standard output.
  -i INDEX, --index INDEX
                        Path to GAF Viewing Index file. This index is created
                        using gaftools index. If path is not provided, it is
                        assumed to be in the same directory as GAF file with
                        the same name and .gvi extension (default location of
                        the index script)
  -n NODE, --node NODE  Nodes to search. Multiple can be provided (Eg.
                        gaftools view .... -n s1 -n s2 -n s3 .....).
  -r REGION, --region REGION
                        Regions to search. Multiple can be provided (Eg.
                        gaftools view .... -r chr1:10-20 -r chr1:50-60 .....).
  -f FORMAT, --format FORMAT
                        format of output path (unstable | stable)
gaftools error: argument -h/--help: ignored explicit argument 'elp'
```


## Metadata
- **Skill**: generated
