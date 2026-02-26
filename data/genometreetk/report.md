# genometreetk CWL Generation Report

## genometreetk_ssu_tree

### Tool Description
Infer 16S tree spanning GTDB genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: genometreetk ssu_tree [-h] [--genome_list GENOME_LIST]
                             [--min_ssu_length MIN_SSU_LENGTH]
                             [--min_scaffold_length MIN_SCAFFOLD_LENGTH]
                             [--min_quality MIN_QUALITY]
                             [--max_contigs MAX_CONTIGS] [--min_N50 MIN_N50]
                             [--align_method {ssu_align,mothur}]
                             [--disable_tax_filter] [-c CPUS] [--silent]
                             gtdb_metadata_file gtdb_ssu_file output_dir

Infer 16S tree spanning GTDB genomes.

positional arguments:
  gtdb_metadata_file    metadata file from GTDB (CSV format)
  gtdb_ssu_file         file with 16S sequences (FASTA format)
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  --genome_list GENOME_LIST
                        explicit list of genomes to use
  --min_ssu_length MIN_SSU_LENGTH
                        minimum length of 16S sequence to be include in tree
                        (default: 1200)
  --min_scaffold_length MIN_SCAFFOLD_LENGTH
                        minimum length of scaffold containing 16S sequence to
                        be include in tree (default: 0)
  --min_quality MIN_QUALITY
                        minimum quality (completeness - 5*contamination) for a
                        genome to be included in tree [0, 100] (default: 50)
  --max_contigs MAX_CONTIGS
                        maximum contigs comprising a genome for it to be
                        included in tree (default: 500)
  --min_N50 MIN_N50     minimum N50 of contigs for a genome to be include in
                        tree (default: 5000)
  --align_method {ssu_align,mothur}
                        method to use for creating multiple sequence alignment
                        (default: ssu_align)
  --disable_tax_filter  disable filtering of sequences with incongruent
                        taxonomy
  -c, --cpus CPUS       number of cpus (default: 1)
  --silent              suppress output
```


## genometreetk_lsu_tree

### Tool Description
Infer 23S tree spanning GTDB genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk lsu_tree [-h] [--genome_list GENOME_LIST]
                             [--min_lsu_length MIN_LSU_LENGTH]
                             [--min_scaffold_length MIN_SCAFFOLD_LENGTH]
                             [--min_quality MIN_QUALITY]
                             [--max_contigs MAX_CONTIGS] [--min_N50 MIN_N50]
                             [--disable_tax_filter] [-c CPUS] [--silent]
                             gtdb_metadata_file gtdb_lsu_file output_dir

Infer 23S tree spanning GTDB genomes.

positional arguments:
  gtdb_metadata_file    metadata file from GTDB (CSV format)
  gtdb_lsu_file         file with 23S sequences (FASTA format)
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  --genome_list GENOME_LIST
                        explicit list of genomes to use
  --min_lsu_length MIN_LSU_LENGTH
                        minimum length of 23S sequence to be include in tree
                        (default: 1800)
  --min_scaffold_length MIN_SCAFFOLD_LENGTH
                        minimum length of scaffold containing 23S sequence to
                        be include in tree (default: 0)
  --min_quality MIN_QUALITY
                        minimum quality (completeness - 5*contamination) for a
                        genome to be included in tree [0, 100] (default: 50)
  --max_contigs MAX_CONTIGS
                        maximum contigs comprising a genome for it to be
                        included in tree (default: 500)
  --min_N50 MIN_N50     minimum N50 of contigs for a genome to be include in
                        tree (default: 5000)
  --disable_tax_filter  disable filtering of sequences with incongruent
                        taxonomy
  -c, --cpus CPUS       number of cpus (default: 1)
  --silent              suppress output
```


## genometreetk_rna_tree

### Tool Description
Infer a concatenated 16S + 23S tree spanning GTDB genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk rna_tree [-h] [-c CPUS] [--silent]
                             ssu_msa ssu_tree lsu_msa lsu_tree output_dir

Infer a concatenated 16S + 23S tree spanning GTDB genomes.

positional arguments:
  ssu_msa          FASTA file with MSA of 16S rRNA gene sequences
  ssu_tree         decorated 16S tree
  lsu_msa          FASTA file with MSA of 23S rRNA gene sequences
  lsu_tree         decorated 23S tree
  output_dir       output directory

optional arguments:
  -h, --help       show this help message and exit
  -c, --cpus CPUS  number of cpus (default: 1)
  --silent         suppress output
```


## genometreetk_rna_dump

### Tool Description
Dump all 5S, 16S, and 23S sequences to files.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk rna_dump [-h] [--min_5S_len MIN_5S_LEN]
                             [--min_16S_ar_len MIN_16S_AR_LEN]
                             [--min_16S_bac_len MIN_16S_BAC_LEN]
                             [--min_23S_len MIN_23S_LEN]
                             [--min_contig_len MIN_CONTIG_LEN]
                             [--include_user] [--genome_list GENOME_LIST]
                             [--silent]
                             genomic_file gtdb_taxonomy output_dir

Dump all 5S, 16S, and 23S sequences to files.

positional arguments:
  genomic_file          file indicating path to GTDB genomes
  gtdb_taxonomy         file indicating taxonomy of each genome
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  --min_5S_len MIN_5S_LEN
                        minimum length of 5S rRNA gene to include (default:
                        80)
  --min_16S_ar_len MIN_16S_AR_LEN
                        minimum length of archaeal 16S rRNA gene to include
                        (default: 900)
  --min_16S_bac_len MIN_16S_BAC_LEN
                        minimum length of bacterial 16S rRNA gene to include
                        (default: 1200)
  --min_23S_len MIN_23S_LEN
                        minimum length of 23S rRNA gene to include (default:
                        1900)
  --min_contig_len MIN_CONTIG_LEN
                        minimum contig length (default: 0)
  --include_user        include user genomes
  --genome_list GENOME_LIST
                        restrict selection to genomes in list
  --silent              suppress output
```


## genometreetk_derep_tree

### Tool Description
Dereplicate tree to taxa of interest.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk derep_tree [-h] [--taxa_to_retain TAXA_TO_RETAIN]
                               [--msa_file MSA_FILE] [--keep_unclassified]
                               [--silent]
                               input_tree lineage_of_interest outgroup
                               gtdb_metadata output_dir

Dereplicate tree to taxa of interest.

positional arguments:
  input_tree            tree to dereplicate
  lineage_of_interest   named lineage where all taxa should be retain
  outgroup              named lineage to use as outgroup
  gtdb_metadata         GTDB metadata for taxa in tree
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  --taxa_to_retain TAXA_TO_RETAIN
                        number of taxa to sample from dereplicated lineages
                        (default: 2)
  --msa_file MSA_FILE   multiple sequence alignment to dereplicate
  --keep_unclassified   keep all taxa in unclassified lineages
  --silent              suppress output
```


## genometreetk_bootstrap

### Tool Description
Bootstrap multiple sequence alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk bootstrap [-h] [--boot_dir BOOT_DIR] [-b {nt,prot}]
                              [-m {wag,lg,jtt}] [-g] [-r NUM_REPLICATES]
                              [-f FRACTION] [-c CPUS] [--silent]
                              input_tree msa_file output_dir

Bootstrap multiple sequence alignment.

positional arguments:
  input_tree            tree inferred from original data
  msa_file              file containing multiple sequence alignment (or 'NONE'
                        if '--boot_dir' is given)
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  --boot_dir BOOT_DIR   directory containing pre-computed bootstrap trees
                        (must have '.tree', '.tre', or '.treefile' extension)
  -b, --base_type {nt,prot}
                        indicates if bases are nucleotides or amino acids
                        (default: prot)
  -m, --model {wag,lg,jtt}
                        model of evolution to use (default: wag)
  -g, --gamma           indicates that the GAMMA model should be used
  -r, --num_replicates NUM_REPLICATES
                        number of bootstrap replicates to perform (default:
                        100)
  -f, --fraction FRACTION
                        fraction of alignment to subsample (default: 1.0)
  -c, --cpus CPUS       number of cpus (default: 1)
  --silent              suppress output
```


## genometreetk_jk_markers

### Tool Description
Jackknife marker genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk jk_markers [-h] [--jk_dir JK_DIR] [-m {wag,jtt}]
                               [-p PERC_MARKERS] [-r NUM_REPLICATES] [-c CPUS]
                               [--silent]
                               input_tree msa_file marker_info_file mask_file
                               output_dir

Jackknife marker genes.

positional arguments:
  input_tree            tree inferred from original data
  msa_file              file containing multiple sequence alignment
  marker_info_file      file indicating length of each gene in concatenated
                        alignment
  mask_file             file indicating masking of multiple sequence alignment
  output_dir            output directory)

optional arguments:
  -h, --help            show this help message and exit
  --jk_dir JK_DIR       directory containing pre-computed jackknife trees
                        (must have '.tree' or '.tre' extension)
  -m, --model {wag,jtt}
                        model of evolution to use (default: wag)
  -p, --perc_markers PERC_MARKERS
                        percentage of markers to keep (default: 0.5)
  -r, --num_replicates NUM_REPLICATES
                        number of jackknife replicates to perform (default:
                        100)
  -c, --cpus CPUS       number of cpus (default: 1)
  --silent              suppress output
```


## genometreetk_jk_taxa

### Tool Description
Jackknife ingroup taxa.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk jk_taxa [-h] [--outgroup_ids OUTGROUP_IDS] [-m {wag,jtt}]
                            [-p PERC_TAXA] [-r NUM_REPLICATES] [-c CPUS]
                            [--silent]
                            input_tree msa_file output_dir

Jackknife ingroup taxa.

positional arguments:
  input_tree            tree inferred from original data
  msa_file              file containing multiple sequence alignment
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  --outgroup_ids OUTGROUP_IDS
                        file indicating outgroup taxa
  -m, --model {wag,jtt}
                        model of evolution to use (default: wag)
  -p, --perc_taxa PERC_TAXA
                        percentage of taxa to keep (default: 0.5)
  -r, --num_replicates NUM_REPLICATES
                        number of jackknife replicates to perform (default:
                        100)
  -c, --cpus CPUS       number of cpus (default: 1)
  --silent              suppress output
```


## genometreetk_combine

### Tool Description
Combine all support values into a single tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk combine [-h] [-s {average,minimum}] [--silent]
                            bootstrap_tree jk_marker_tree jk_taxa_tree
                            output_tree

Combine all support values into a single tree.

positional arguments:
  bootstrap_tree        tree with bootstrap support values
  jk_marker_tree        tree with jackknife marker support values
  jk_taxa_tree          tree with jackknife taxa support values
  output_tree           output tree

optional arguments:
  -h, --help            show this help message and exit
  -s, --support_type {average,minimum}
                        type of support values to compute (default: average)
  --silent              suppress output
```


## genometreetk_midpoint

### Tool Description
Reroot tree at midpoint.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk midpoint [-h] [--silent] input_tree output_tree

Reroot tree at midpoint.

positional arguments:
  input_tree   tree to reroot
  output_tree  output tree

optional arguments:
  -h, --help   show this help message and exit
  --silent     suppress output
```


## genometreetk_outgroup

### Tool Description
Reroot tree with outgroup.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk outgroup [-h] [--silent]
                             input_tree taxonomy_file outgroup_taxon
                             output_tree

Reroot tree with outgroup.

positional arguments:
  input_tree      tree to reroot
  taxonomy_file   file indicating taxonomy string for genomes
  outgroup_taxon  taxon to use as outgroup (e.g., d__Archaea)
  output_tree     output tree

optional arguments:
  -h, --help      show this help message and exit
  --silent        suppress output
```


## genometreetk_fill_ranks

### Tool Description
Ensure taxonomy strings contain all 7 canonical ranks.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk fill_ranks [-h] [--silent] input_taxonomy output_taxonomy

Ensure taxonomy strings contain all 7 canonical ranks.

positional arguments:
  input_taxonomy   input taxonomy file
  output_taxonomy  output taxonomy file

optional arguments:
  -h, --help       show this help message and exit
  --silent         suppress output
```


## genometreetk_propagate

### Tool Description
Propagate labels to all genomes in a cluster.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk propagate [-h] [--silent]
                              input_taxonomy metadata_file output_taxonomy

Propagate labels to all genomes in a cluster.

positional arguments:
  input_taxonomy   input taxonomy file
  metadata_file    metadata file for all genomes in the GTDB
  output_taxonomy  output taxonomy file

optional arguments:
  -h, --help       show this help message and exit
  --silent         suppress output
```


## genometreetk_strip

### Tool Description
Remove taxonomic labels from a tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk strip [-h] [--silent] input_tree output_tree

Remove taxonomic labels from a tree.

positional arguments:
  input_tree   tree to strip
  output_tree  output tree

optional arguments:
  -h, --help   show this help message and exit
  --silent     suppress output
```


## genometreetk_rm_support

### Tool Description
Remove support values from tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk rm_support [-h] [--silent] input_tree output_tree

Remove support values from tree.

positional arguments:
  input_tree   tree to strip
  output_tree  output tree

optional arguments:
  -h, --help   show this help message and exit
  --silent     suppress output
```


## genometreetk_pull

### Tool Description
Create taxonomy file from a decorated tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk pull [-h] [--no_validation] [--silent]
                         input_tree output_taxonomy

Create taxonomy file from a decorated tree.

positional arguments:
  input_tree       decorated tree
  output_taxonomy  output taxonomy file

optional arguments:
  -h, --help       show this help message and exit
  --no_validation  do not assume decorated nodes adhear to standard taxonomy
  --silent         suppress output
```


## genometreetk_append

### Tool Description
Append taxonomy to extant tree labels.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk append [-h] [--silent]
                           input_tree input_taxonomy output_tree

Append taxonomy to extant tree labels.

positional arguments:
  input_tree      input tree to decorate
  input_taxonomy  input taxonomy file
  output_tree     output tree with taxonomy appended to extant taxon labels

optional arguments:
  -h, --help      show this help message and exit
  --silent        suppress output
```


## genometreetk_prune

### Tool Description
Prune tree to a specific set of extant taxa.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk prune [-h] [--silent]
                          input_tree taxa_to_retain output_tree

Prune tree to a specific set of extant taxa.

positional arguments:
  input_tree      input tree in Newick format
  taxa_to_retain  input file specify taxa to retain
  output_tree     pruned output tree

optional arguments:
  -h, --help      show this help message and exit
  --silent        suppress output
```


## genometreetk_pd

### Tool Description
Calculate phylogenetic diversity of specified taxa.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk pd [-h] [--per_taxa_pg_file PER_TAXA_PG_FILE] [--silent]
                       tree taxa_list

Calculate phylogenetic diversity of specified taxa.

positional arguments:
  tree                  newick tree
  taxa_list             list of ingroup taxa, one per line, to calculated PD
                        over

optional arguments:
  -h, --help            show this help message and exit
  --per_taxa_pg_file PER_TAXA_PG_FILE
                        file to record phylogenetic gain of each ingroup taxa
                        relative to the outgroup
  --silent              suppress output
```


## genometreetk_pd_clade

### Tool Description
Calculate phylogenetic diversity of named groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk pd_clade [-h] [--silent]
                             decorated_tree taxa_list output_file

Calculate phylogenetic diversity of named groups.

positional arguments:
  decorated_tree  tree with labeled internal nodes
  taxa_list       list of ingroup taxa, one per line, to calculated PD over
  output_file     output file

optional arguments:
  -h, --help      show this help message and exit
  --silent        suppress output
```


## genometreetk_arb_records

### Tool Description
Create an ARB records file from GTDB metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/genometreetk:0.1.6--py_2
- **Homepage**: http://pypi.python.org/pypi/genometreetk/
- **Package**: https://anaconda.org/channels/bioconda/packages/genometreetk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genometreetk arb_records [-h] [--msa_file MSA_FILE]
                                [--taxonomy_file TAXONOMY_FILE]
                                [--genome_list GENOME_LIST] [--silent]
                                metadata_file output_file

Create an ARB records file from GTDB metadata.

positional arguments:
  metadata_file         metadata file for all genomes in the GTDB
  output_file           output file with ARB records

optional arguments:
  -h, --help            show this help message and exit
  --msa_file MSA_FILE   aligned sequences to include in ARB records
  --taxonomy_file TAXONOMY_FILE
                        taxonomy information to include in ARB records
  --genome_list GENOME_LIST
                        create ARB records only for genome IDs in file
  --silent              suppress output
```


## Metadata
- **Skill**: generated
