# medicc2 CWL Generation Report

## medicc2

### Tool Description
medicc2 is a tool for inferring copy number alterations and phylogenetic trees from tumor sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/medicc2:1.1.2--py310h8ea774a_1
- **Homepage**: https://bitbucket.org/schwarzlab/medicc2
- **Package**: https://anaconda.org/channels/bioconda/packages/medicc2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/medicc2/overview
- **Total Downloads**: 40.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: medicc2 [-h] [--version] [--input-type {f,t,fasta,tsv}]
               [--input-allele-columns INPUT_ALLELE_COLUMNS]
               [--input-chr-separator INPUT_CHR_SEPARATOR] [--tree USER_TREE]
               [--topology-only] [--normal-name NORMAL_NAME]
               [--exclude-samples EXCLUDE_SAMPLES]
               [--filter-segment-length FILTER_SEGMENT_LENGTH]
               [--bootstrap-method BOOTSTRAP_METHOD]
               [--bootstrap-nr BOOTSTRAP_NR] [--prefix PREFIX] [--no-wgd]
               [--plot {auto,bars,heatmap,both,none}] [--no-plot-tree]
               [--total-copy-numbers] [-j N_CORES] [--events]
               [--chromosomes-bed CHROMOSOMES_BED] [--regions-bed REGIONS_BED]
               [-v] [-vv] [--silent] [--maxcn MAXCN]
               [--prune-weight PRUNE_WEIGHT] [--fst FST]
               [--fst-chr-separator FST_CHR_SEPARATOR] [--wgd-x2]
               input_file output_dir

positional arguments:
  input_file            a path to the input file
  output_dir            a path to the output folder

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --input-type {f,t,fasta,tsv}, -i {f,t,fasta,tsv}
                        Choose the type of input: f for FASTA, t for TSV
                        (default: TSV)
  --input-allele-columns INPUT_ALLELE_COLUMNS, -a INPUT_ALLELE_COLUMNS
                        Name of the CN columns (comma separated) if using TSV
                        input format (default: 'cn_a, cn_b'). This also
                        adjusts the number of alleles considered (min. 1, max.
                        2).
  --input-chr-separator INPUT_CHR_SEPARATOR
                        Character used to separate chromosomes in the input
                        data (condensed FASTA only, default: "X").
  --tree USER_TREE      Do not reconstruct tree, use provided tree instead (in
                        newick format) and only perform ancestral
                        reconstruction (default: None).
  --topology-only, -s   Output only tree topology, without reconstructing
                        ancestors (default: False).
  --normal-name NORMAL_NAME, -n NORMAL_NAME
                        ID of the sample to be treated as the normal sample.
                        Trees are rooted at this sample for ancestral
                        reconstruction (default: "diploid"). If the sample ID
                        is not found, an artificial normal sample of the same
                        name is created with CN states = 1 for each allele.
  --exclude-samples EXCLUDE_SAMPLES, -x EXCLUDE_SAMPLES
                        Comma separated list of sample IDs to exclude.
  --filter-segment-length FILTER_SEGMENT_LENGTH
                        Removes segments that are smaller than specified
                        length.
  --bootstrap-method BOOTSTRAP_METHOD
                        Bootstrap method. Has to be either 'chr-wise' or
                        'segment-wise'
  --bootstrap-nr BOOTSTRAP_NR
                        Number of bootstrap runs to perform
  --prefix PREFIX, -p PREFIX
                        Output prefix to be used (default: input filename).
  --no-wgd              Enable whole-genome doubling events (default: False).
  --plot {auto,bars,heatmap,both,none}
                        Type of copy-number plot to save. 'bars' is
                        recommended for <50 samples, heatmap for more samples,
                        'auto' will decide based on the number of samples,
                        'both' will plot both and 'none' will plot neither.
                        (default: auto).
  --no-plot-tree        Disable plotting of tree (default: False).
  --total-copy-numbers  Run for total copy number data instead of allele-
                        specific data (default: False).
  -j N_CORES, --n-cores N_CORES
                        Number of cores to run on
  --events              Whether to infer copy-number events (default: False).
  --chromosomes-bed CHROMOSOMES_BED
                        BED file for chromosome regions
  --regions-bed REGIONS_BED
                        BED file for regions of interests
  -v, --verbose         Enable verbose output (default: False).
  -vv, --debug          Enable more verbose output (default: False).
  --silent              Hide all output (default: False).
  --maxcn MAXCN         Expert option: maximum CN at which the input is
                        capped. Does not change FST. The maximum possible
                        value is 8. Default: 8
  --prune-weight PRUNE_WEIGHT
                        Expert option: Prune weight in ancestor
                        reconstruction. Values >0 might result in more
                        accurate ancestors but will require more time and
                        memory. Default: 0
  --fst FST             Expert option: path to an alternative FST.
  --fst-chr-separator FST_CHR_SEPARATOR
                        Expert option: character used to separate chromosomes
                        in the FST (default: "X").
  --wgd-x2              Expert option: Treat WGD as a x2 operation (default:
                        False).
```

