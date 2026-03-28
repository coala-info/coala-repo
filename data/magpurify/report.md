# magpurify CWL Generation Report

## magpurify_phylo-markers

### Tool Description
Find taxonomic discordant contigs using a database of phylogenetic marker genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/snayfach/MAGpurify
- **Package**: https://anaconda.org/channels/bioconda/packages/magpurify/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/magpurify/overview
- **Total Downloads**: 21.6K
- **Last updated**: 2025-08-14
- **GitHub**: https://github.com/snayfach/MAGpurify
- **Stars**: N/A
### Original Help Text
```text
usage: magpurify phylo-markers [-h] [--db DB] [--continue]
                               [--max_target_seqs MAX_TARGET_SEQS]
                               [--cutoff_type {strict,sensitive,none}]
                               [--seq_type {dna,protein,both,either}]
                               [--hit_type {all_hits,top_hit}]
                               [--exclude_clades EXCLUDE_CLADES [EXCLUDE_CLADES ...]]
                               [--bin_fract BIN_FRACT]
                               [--contig_fract CONTIG_FRACT] [--allow_noclass]
                               [--threads THREADS]
                               fna out

Find taxonomic discordant contigs using a database of phylogenetic marker
genes.

positional arguments:
  fna                   Path to input genome in FASTA format
  out                   Output directory to store results and intermediate
                        files

options:
  -h, --help            show this help message and exit
  --db DB               Path to reference database. By default, the
                        MAGPURIFYDB environmental variable is used (default:
                        None)
  --continue            Go straight to quality estimation and skip all
                        previous steps (default: False)
  --max_target_seqs MAX_TARGET_SEQS
                        Maximum number of targets reported in BLAST table
                        (default: 1)
  --cutoff_type {strict,sensitive,none}
                        Use strict or sensitive %ID cutoff for taxonomically
                        annotating genes (default: strict)
  --seq_type {dna,protein,both,either}
                        Choose to search genes versus DNA or protein database
                        (default: protein)
  --hit_type {all_hits,top_hit}
                        Transfer taxonomy of all hits or top hit per gene
                        (default: top_hit)
  --exclude_clades EXCLUDE_CLADES [EXCLUDE_CLADES ...]
                        List of clades to exclude (ex: s__1300164.4) (default:
                        None)
  --bin_fract BIN_FRACT
                        Min fraction of genes in bin that agree with consensus
                        taxonomy for bin annotation (default: 0.7)
  --contig_fract CONTIG_FRACT
                        Min fraction of genes in that disagree with bin
                        taxonomy for filtering (default: 1.0)
  --allow_noclass       Allow a bin to be unclassfied and flag any classified
                        contigs (default: False)
  --threads THREADS     Number of CPUs to use (default: 1)
```


## magpurify_clade-markers

### Tool Description
Find taxonomic discordant contigs using a database of clade-specific marker genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/snayfach/MAGpurify
- **Package**: https://anaconda.org/channels/bioconda/packages/magpurify/overview
- **Validation**: PASS

### Original Help Text
```text
usage: magpurify clade-markers [-h] [--db DB]
                               [--exclude_clades EXCLUDE_CLADES [EXCLUDE_CLADES ...]]
                               [--min_bin_fract MIN_BIN_FRACT]
                               [--min_contig_fract MIN_CONTIG_FRACT]
                               [--min_gene_fract MIN_GENE_FRACT]
                               [--min_genes MIN_GENES]
                               [--lowest_rank {s,g,f,o,c,p,k}]
                               [--threads THREADS]
                               fna out

Find taxonomic discordant contigs using a database of clade-specific marker
genes.

positional arguments:
  fna                   Path to input genome in FASTA format
  out                   Output directory to store results and intermediate
                        files

options:
  -h, --help            show this help message and exit
  --db DB               Path to reference database. By default, the MAGPURIFY
                        environmental variable is used (default: None)
  --exclude_clades EXCLUDE_CLADES [EXCLUDE_CLADES ...]
                        List of clades to exclude (ex: s__Variovorax_sp_CF313)
                        (default: None)
  --min_bin_fract MIN_BIN_FRACT
                        Min fraction of bin length supported by contigs that
                        agree with consensus taxonomy (default: 0.6)
  --min_contig_fract MIN_CONTIG_FRACT
                        Min fraction of classified contig length that agree
                        with consensus taxonomy (default: 0.75)
  --min_gene_fract MIN_GENE_FRACT
                        Min fraction of classified genes that agree with
                        consensus taxonomy (default: 0.0)
  --min_genes MIN_GENES
                        Min number of genes that agree with consensus taxonomy
                        (default=rank-specific-cutoffs) (default: None)
  --lowest_rank {s,g,f,o,c,p,k}
                        Lowest rank for bin classification (default: None)
  --threads THREADS     Number of CPUs to use (default: 1)
```


## magpurify_conspecific

### Tool Description
Find contigs that fail to align to closely related genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/snayfach/MAGpurify
- **Package**: https://anaconda.org/channels/bioconda/packages/magpurify/overview
- **Validation**: PASS

### Original Help Text
```text
usage: magpurify conspecific [-h] [--mash-dist MASH_DIST]
                             [--max-genomes MAX_GENOMES]
                             [--min-genomes MIN_GENOMES]
                             [--contig-aln CONTIG_ALN]
                             [--contig-pid CONTIG_PID] [--hit-rate HIT_RATE]
                             [--exclude EXCLUDE [EXCLUDE ...]]
                             [--threads THREADS]
                             fna out mash_sketch

Find contigs that fail to align to closely related genomes.

positional arguments:
  fna                   Path to input genome in FASTA format
  out                   Output directory to store results and intermediate
                        files
  mash_sketch           Path to Mash sketch of reference genomes

options:
  -h, --help            show this help message and exit
  --mash-dist MASH_DIST
                        Mash distance to reference genomes (default: 0.05)
  --max-genomes MAX_GENOMES
                        Max number of genomes to use (default: 25)
  --min-genomes MIN_GENOMES
                        Min number of genomes to use (default: 1)
  --contig-aln CONTIG_ALN
                        Minimum fraction of contig aligned to reference
                        (default: 0.5)
  --contig-pid CONTIG_PID
                        Minimum percent identity of contig aligned to
                        reference (default: 95.0)
  --hit-rate HIT_RATE   Hit rate for flagging contigs (default: 0.0)
  --exclude EXCLUDE [EXCLUDE ...]
                        List of references to exclude (default: )
  --threads THREADS     Number of CPUs to use (default: 1)
```


## magpurify_tetra-freq

### Tool Description
Find contigs with outlier tetranucleotide frequency.

### Metadata
- **Docker Image**: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/snayfach/MAGpurify
- **Package**: https://anaconda.org/channels/bioconda/packages/magpurify/overview
- **Validation**: PASS

### Original Help Text
```text
usage: magpurify tetra-freq [-h] [--cutoff CUTOFF] [--weighted-mean] fna out

Find contigs with outlier tetranucleotide frequency.

positional arguments:
  fna              Path to input genome in FASTA format
  out              Output directory to store results and intermediate files

options:
  -h, --help       show this help message and exit
  --cutoff CUTOFF  Cutoff (default: 0.06)
  --weighted-mean  Compute the mean weighted by the contig length (default:
                   False)
```


## magpurify_gc-content

### Tool Description
Find contigs with outlier GC content.

### Metadata
- **Docker Image**: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/snayfach/MAGpurify
- **Package**: https://anaconda.org/channels/bioconda/packages/magpurify/overview
- **Validation**: PASS

### Original Help Text
```text
usage: magpurify gc-content [-h] [--cutoff CUTOFF] [--weighted-mean] fna out

Find contigs with outlier GC content.

positional arguments:
  fna              Path to input genome in FASTA format
  out              Output directory to store results and intermediate files

options:
  -h, --help       show this help message and exit
  --cutoff CUTOFF  Cutoff (default: 15.75)
  --weighted-mean  Compute the mean weighted by the contig length (default:
                   False)
```


## magpurify_coverage

### Tool Description
Find contigs with outlier coverage profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/snayfach/MAGpurify
- **Package**: https://anaconda.org/channels/bioconda/packages/magpurify/overview
- **Validation**: PASS

### Original Help Text
```text
usage: magpurify coverage [-h] [--max-deviation MAX_DEVIATION]
                          [--weighted-mean] [--threads THREADS]
                          fna out bams [bams ...]

Find contigs with outlier coverage profile.

positional arguments:
  fna                   Path to input genome in FASTA format
  out                   Output directory to store results and intermediate
                        files
  bams                  Path to input sorted BAM file(s)

options:
  -h, --help            show this help message and exit
  --max-deviation MAX_DEVIATION
                        Contigs with coverage greater than [max-deviation *
                        mean coverage] or less than [(1/max-deviation) * mean
                        coverage] will be flagged as outliers (default: 5.0)
  --weighted-mean       Compute the mean weighted by the contig length
                        (default: False)
  --threads THREADS     Number of CPUs to use (default: 1)
```


## magpurify_known-contam

### Tool Description
Find contigs that match a database of known contaminants.

### Metadata
- **Docker Image**: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/snayfach/MAGpurify
- **Package**: https://anaconda.org/channels/bioconda/packages/magpurify/overview
- **Validation**: PASS

### Original Help Text
```text
usage: magpurify known-contam [-h] [--db DB] [--pid PID] [--evalue EVALUE]
                              [--qcov QCOV] [--threads THREADS]
                              fna out

Find contigs that match a database of known contaminants.

positional arguments:
  fna                Path to input genome in FASTA format
  out                Output directory to store results and intermediate files

options:
  -h, --help         show this help message and exit
  --db DB            Path to reference database. By default, the IMAGEN_DB
                     environmental variable is used (default: None)
  --pid PID          Minimum % identity to reference (default: 98)
  --evalue EVALUE    Maximum evalue (default: 1e-05)
  --qcov QCOV        Minimum percent query coverage (default: 25)
  --threads THREADS  Number of CPUs to use (default: 1)
```


## magpurify_clean-bin

### Tool Description
Remove putative contaminant contigs from bin.

### Metadata
- **Docker Image**: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/snayfach/MAGpurify
- **Package**: https://anaconda.org/channels/bioconda/packages/magpurify/overview
- **Validation**: PASS

### Original Help Text
```text
usage: magpurify clean-bin [-h] fna out out_fna

Remove putative contaminant contigs from bin.

positional arguments:
  fna         Path to input genome in FASTA format
  out         Output directory to store results and intermediate files
  out_fna     Path to the output FASTA file

options:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: generated
