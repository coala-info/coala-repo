# galah CWL Generation Report

## galah_cluster-validate

### Tool Description
Verify clustering results

### Metadata
- **Docker Image**: quay.io/biocontainers/galah:0.4.2--hc1c3326_2
- **Homepage**: https://github.com/wwood/galah
- **Package**: https://anaconda.org/channels/bioconda/packages/galah/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/galah/overview
- **Total Downloads**: 21.0K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/wwood/galah
- **Stars**: N/A
### Original Help Text
```text
Verify clustering results

Usage: galah cluster-validate [OPTIONS] --cluster-file <cluster-file>

Options:
      --cluster-file <cluster-file>
          Output of 'cluster' subcommand
      --ani <ani>
          ANI to validate against [default: 99]
      --min-aligned-fraction <min-aligned-fraction>
          Min aligned fraction of two genomes for clustering [default: 50]
  -t, --threads <threads>
          [default: 1]
  -v, --verbose
          Print extra debug logging information
      --quiet
          Unless there is an error, do not print logging information
  -h, --help
          Print help
```


## galah_cluster

### Tool Description
Cluster (dereplicate) genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/galah:0.4.2--hc1c3326_2
- **Homepage**: https://github.com/wwood/galah
- **Package**: https://anaconda.org/channels/bioconda/packages/galah/overview
- **Validation**: PASS

### Original Help Text
```text
galah cluster
              Cluster (dereplicate) genomes

Example: Dereplicate at 95% (after pre-clustering at 90%) a directory of .fna
FASTA files and create a new directory of symlinked FASTA files of

epresentatives:

  galah cluster --genome-fasta-directory input_genomes/ 
    --output-representative-fasta-directory output_directory/

Example: Dereplicate a set of genomes with paths specified in genomes.txt at
95% ANI, after a preclustering at 90% using the MinHash finch method, and
output the cluster definition to clusters.tsv:

  galah cluster --ani 95 --precluster-ani 90 --precluster-method finch
    --genome-fasta-list genomes.txt 
    --output-cluster-definition clusters.tsv

Example: Dereplicate a set of genome representatives against a set of reference genomes,
output the cluster definition to clusters.tsv:
Note: assumes that each group (inputs and references) is already dereplicated previously.
Galah will only form clusters across the two groups (input <-> reference), never within a
group. Uses less memory than clustering together.

  galah cluster --genome-fasta-list genome_reps.txt
    --reference-genomes-list reference_genomes.txt
    --output-cluster-definition clusters.tsv

Example: Dereplicate a set of contigs within FASTA files using small-genomes settings
(recommended for contigs < 20kb). Can be used for virus or plasmid clustering:

  galah cluster --cluster-contigs --small-contigs --genome-fasta-files contigs.fasta 
    --output-cluster-definition contig_clusters.tsv

See galah cluster --full-help for further options and further detail.
```

