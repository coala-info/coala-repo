# refinem CWL Generation Report

## refinem_scaffold_stats

### Tool Description
Calculate statistics for scaffolds.

### Metadata
- **Docker Image**: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
- **Homepage**: http://pypi.python.org/pypi/refinem/
- **Package**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Total Downloads**: 15.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/RefineM
- **Stars**: N/A
### Original Help Text
```text
usage: refinem scaffold_stats [-h] [-x GENOME_EXT] [--tetra_file TETRA_FILE]
                              [--coverage_file COVERAGE_FILE] [-r]
                              [-a COV_MIN_ALIGN] [-e COV_MAX_EDIT_DIST]
                              [-c CPUS] [--silent]
                              scaffold_file genome_nt_dir output_dir
                              [bam_files [bam_files ...]]

Calculate statistics for scaffolds.

positional arguments:
  scaffold_file         scaffolds binned to generate putative genomes
  genome_nt_dir         directory containing nucleotide scaffolds for each
                        genome
  output_dir            output directory
  bam_files             BAM files to parse for coverage profile

optional arguments:
  -h, --help            show this help message and exit
  -x, --genome_ext GENOME_EXT
                        extension of genomes (other files in directory are
                        ignored) (default: fna)
  --tetra_file TETRA_FILE
                        file containing tetranucleotide signatures information
  --coverage_file COVERAGE_FILE
                        file containing coverage profile information
  -r, --cov_all_reads   use all reads to estimate coverage instead of just
                        proper pairs
  -a, --cov_min_align COV_MIN_ALIGN
                        minimum alignment length as percentage of read length
                        (default: 0.98)
  -e, --cov_max_edit_dist COV_MAX_EDIT_DIST
                        maximum edit distance as percentage of read length
                        (default: 0.02)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output of logger
```


## refinem_genome_stats

### Tool Description
Calculate statistics for genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
- **Homepage**: http://pypi.python.org/pypi/refinem/
- **Package**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refinem genome_stats [-h] [-c CPUS] [--silent]
                            scaffold_stats_file output_file

Calculate statistics for genomes.

positional arguments:
  scaffold_stats_file   file with statistics for each scaffold
  output_file           output file with genome statistics

optional arguments:
  -h, --help            show this help message and exit
  -c CPUS, --cpus CPUS  number of CPUs to use (default: 1)
  --silent              suppress output of logger (default: False)
```


## refinem_outliers

### Tool Description
Identify scaffolds with divergent genomic characteristics.

### Metadata
- **Docker Image**: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
- **Homepage**: http://pypi.python.org/pypi/refinem/
- **Package**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refinem outliers [-h] [--gc_perc int] [--td_perc int]
                        [--cov_corr COV_CORR] [--cov_perc int] [-r {any,all}]
                        [--create_plots] [--individual_plots]
                        [--image_type {eps,pdf,png,ps,svg}]
                        [--point_size POINT_SIZE]
                        [--highlight_file HIGHLIGHT_FILE]
                        [--links_file LINKS_FILE] [--dpi DPI]
                        [--label_font_size LABEL_FONT_SIZE]
                        [--tick_font_size TICK_FONT_SIZE] [--width WIDTH]
                        [--height HEIGHT] [--silent]
                        scaffold_stats_file output_dir

Identify scaffolds with divergent genomic characteristics.

positional arguments:
  scaffold_stats_file   file with statistics for each scaffold
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  --gc_perc int         percentile for identify scaffolds with divergent GC
                        content (default: 98)
  --td_perc int         percentile for identify scaffolds with divergent
                        tetranucleotide signatures (default: 98)
  --cov_corr COV_CORR   correlation for identifying scaffolds with divergent
                        coverage profiles (default: -2)
  --cov_perc int        mean absolute percent error for identifying scaffolds
                        with divergent coverage profiles (default: 50)
  -r, --report_type {any,all}
                        report sequences that are outliers in 'all' or 'any'
                        reference distribution (default: any)
  --create_plots        create exploratory plots (currently unstable due to
                        mpld3 limitations)
  --individual_plots    create individual plots for each statistic
  --image_type {eps,pdf,png,ps,svg}
                        desired image type (default: png)
  --point_size POINT_SIZE
                        desired size of points in scatterplot (default: 36)
  --highlight_file HIGHLIGHT_FILE
                        file indicating scaffolds to highlight
  --links_file LINKS_FILE
                        file indicating pairs of scaffolds to join by a line
  --dpi DPI             desired DPI of output image (default: 96)
  --label_font_size LABEL_FONT_SIZE
                        desired font size for labels (default: 12)
  --tick_font_size TICK_FONT_SIZE
                        desired font size for tick markers (default: 10)
  --width WIDTH         width of output image (default: 12)
  --height HEIGHT       height of output image (default: 6)
  --silent              suppress output of logger
```


## refinem_taxon_profile

### Tool Description
Generate taxonomic profile of genes across scaffolds within a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
- **Homepage**: http://pypi.python.org/pypi/refinem/
- **Package**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refinem taxon_profile [-h] [-p PER_TO_CLASSIFY] [-e EVALUE]
                             [-i PER_IDENTITY] [-a PER_ALN_LEN]
                             [-x PROTEIN_EXT] [--tmpdir TMPDIR] [-c CPUS]
                             [--silent]
                             genome_prot_dir scaffold_stats_file db_file
                             taxonomy_file output_dir

Generate taxonomic profile of genes across scaffolds within a genome.

positional arguments:
  genome_prot_dir       directory containing amino acid genes for each genome
  scaffold_stats_file   file with statistics for each scaffold
  db_file               DIAMOND database of reference genomes
  taxonomy_file         taxonomic assignment of each reference genomes
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -p, --per_to_classify PER_TO_CLASSIFY
                        minimum percentage of genes to assign a scaffold to a
                        taxonomic group (default: 20.0)
  -e, --evalue EVALUE   e-value of valid hits (default: 0.001)
  -i, --per_identity PER_IDENTITY
                        percent identity of valid hits (default: 30.0)
  -a, --per_aln_len PER_ALN_LEN
                        minimum percent coverage of query sequence for
                        reporting an alignment (default: 50.0)
  -x, --protein_ext PROTEIN_EXT
                        extension of amino acid gene files (other files in
                        directory are ignored) (default: faa)
  --tmpdir TMPDIR       specify alternative directory for temporary files
                        (default: /tmp)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output of logger
```


## refinem_taxon_filter

### Tool Description
Identify scaffolds with divergent taxonomic classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
- **Homepage**: http://pypi.python.org/pypi/refinem/
- **Package**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refinem taxon_filter [-h] [--consensus_taxon CONSENSUS_TAXON]
                            [--trusted_scaffold TRUSTED_SCAFFOLD]
                            [--common_taxa COMMON_TAXA]
                            [--congruent_scaffold CONGRUENT_SCAFFOLD]
                            [--min_classified_per MIN_CLASSIFIED_PER]
                            [--min_classified MIN_CLASSIFIED]
                            [--consensus_scaffold CONSENSUS_SCAFFOLD]
                            [-c CPUS] [--silent]
                            taxon_profile_dir output_file

Identify scaffolds with divergent taxonomic classification.

positional arguments:
  taxon_profile_dir     directory with results of taxon_profile command
  output_file           file indicating divergent scaffolds

optional arguments:
  -h, --help            show this help message and exit
  --consensus_taxon CONSENSUS_TAXON
                        threshold for accepting a consensus taxon (default:
                        50.0)
  --trusted_scaffold TRUSTED_SCAFFOLD
                        threshold for treating a scaffold as trusted (default:
                        50.0)
  --common_taxa COMMON_TAXA
                        threshold for treating a taxon as common (default:
                        5.0)
  --congruent_scaffold CONGRUENT_SCAFFOLD
                        threshold for treating a scaffold as congruent
                        (default: 10.0)
  --min_classified_per MIN_CLASSIFIED_PER
                        minimum percentage of genes with a classification to
                        filter a scaffold (default: 25.0)
  --min_classified MIN_CLASSIFIED
                        minimum number of classified genes required to filter
                        a scaffold (default: 5)
  --consensus_scaffold CONSENSUS_SCAFFOLD
                        threshold of consensus taxon for filtering a scaffold
                        (default: 50.0)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output of logger
```


## refinem_ssu_erroneous

### Tool Description
Identify scaffolds with erroneous 16S rRNA genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
- **Homepage**: http://pypi.python.org/pypi/refinem/
- **Package**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refinem ssu_erroneous [-h] [-x GENOME_EXT] [--evalue EVALUE]
                             [--concatenate CONCATENATE]
                             [--common_taxon COMMON_TAXON]
                             [--ssu_min_len SSU_MIN_LEN]
                             [--ssu_domain SSU_DOMAIN]
                             [--ssu_phylum SSU_PHYLUM] [--ssu_class SSU_CLASS]
                             [--ssu_order SSU_ORDER] [--ssu_family SSU_FAMILY]
                             [--ssu_genus SSU_GENUS] [-c CPUS] [--silent]
                             genome_nt_dir taxon_profile_dir ssu_db
                             ssu_taxonomy_file output_dir

Identify scaffolds with erroneous 16S rRNA genes.

positional arguments:
  genome_nt_dir         directory containing nucleotide scaffolds for each
                        genome
  taxon_profile_dir     directory with results of taxon_profile command
  ssu_db                BLAST database of 16S rRNA genes
  ssu_taxonomy_file     taxonomy file for genes in the 16S rRNA database
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -x, --genome_ext GENOME_EXT
                        extension of genomes (other files in directory are
                        ignored) (default: fna)
  --evalue EVALUE       e-value threshold for identifying and classifying 16S
                        rRNA genes (default: 1e-05)
  --concatenate CONCATENATE
                        concatenate hits within the specified number of base
                        pairs (default: 200)
  --common_taxon COMMON_TAXON
                        threshold for defining a taxon as common (default:
                        10.0)
  --ssu_min_len SSU_MIN_LEN
                        minimum length of SSU 16S gene fragment to consider
                        for classification (default: 600)
  --ssu_domain SSU_DOMAIN
                        percent identity threshold for accepting domain
                        classification of SSU (default: 83.68)
  --ssu_phylum SSU_PHYLUM
                        percent identity threshold for accepting phylum
                        classification of SSU (default: 86.35)
  --ssu_class SSU_CLASS
                        percent identity threshold for accepting class
                        classification of SSU (default: 89.2)
  --ssu_order SSU_ORDER
                        percent identity threshold for accepting order
                        classification of SSU (default: 92.25)
  --ssu_family SSU_FAMILY
                        percent identity threshold for accepting family
                        classification of SSU (default: 96.4)
  --ssu_genus SSU_GENUS
                        percent identity threshold for accepting genus
                        classification of SSU (default: 98.7)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output of logger
```


## refinem_modify_bin

### Tool Description
Modify scaffolds in a single bin.

### Metadata
- **Docker Image**: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
- **Homepage**: http://pypi.python.org/pypi/refinem/
- **Package**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refinem modify_bin [-h] [-m MIN_LEN] [-a ADD] [-r REMOVE]
                          [-o OUTLIER_FILE] [--silent]
                          scaffold_file genome_file output_genome

Modify scaffolds in a single bin.

positional arguments:
  scaffold_file         scaffolds binned to generate putative genomes
  genome_file           genome to be modified
  output_genome         modified genome

optional arguments:
  -h, --help            show this help message and exit
  -m, --min_len MIN_LEN
                        minimum length of scaffold to allow it to be added to
                        a genome
  -a, --add ADD         ID of scaffold to add to genome (may specify multiple
                        times)
  -r, --remove REMOVE   ID of scaffold to remove from bin (may specify
                        multiple times)
  -o, --outlier_file OUTLIER_FILE
                        remove all scaffolds identified as outliers (see
                        outlier command)
  --silent              suppress output of logger
```


## refinem_filter_bins

### Tool Description
Remove scaffolds across a set of bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
- **Homepage**: http://pypi.python.org/pypi/refinem/
- **Package**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refinem filter_bins [-h] [-x GENOME_EXT] [--modified_only] [--silent]
                           genome_nt_dir filter_file output_dir

Remove scaffolds across a set of bins.

positional arguments:
  genome_nt_dir         directory containing nucleotide scaffolds for each
                        genome
  filter_file           file specifying scaffolds to remove
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -x, --genome_ext GENOME_EXT
                        extension of genomes (other files in directory are
                        ignored) (default: fna)
  --modified_only       only copy modified bins to the output folder
  --silent              suppress output of logger
```


## refinem_call_genes

### Tool Description
Identify genes within genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
- **Homepage**: http://pypi.python.org/pypi/refinem/
- **Package**: https://anaconda.org/channels/bioconda/packages/refinem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refinem call_genes [-h] [-u UNBINNED_FILE] [-x GENOME_EXT] [-c CPUS]
                          [--silent]
                          genome_nt_dir output_dir

Identify genes within genomes.

positional arguments:
  genome_nt_dir         directory containing nucleotide scaffolds for each
                        genome
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -u, --unbinned_file UNBINNED_FILE
                        call genes on unbinned scaffolds
  -x, --genome_ext GENOME_EXT
                        extension of genomes (other files in directory are
                        ignored) (default: fna)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output of logger
```

