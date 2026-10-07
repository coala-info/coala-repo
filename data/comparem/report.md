# comparem CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| comparem_aa_usage | PASS |  |
| comparem_aai | PASS |  |
| comparem_aai_wf | Failed | image problem: the image has BusyBox sort, which rejects --parallel, so the DIAMOND hit table is never sorted and AAI finds 0 orthologs between two Bacteroides fragilis assemblies. |
| comparem_call_genes | PASS |  |
| comparem_classify | PASS |  |
| comparem_classify_wf | Failed | image problem: the image has BusyBox sort, which rejects --parallel, so the DIAMOND hit table is never sorted and classify finds only 3 orthologs between two Bacteroides fragilis assemblies (658 with a sorted table). |
| comparem_codon_usage | PASS |  |
| comparem_diss | PASS |  |
| comparem_hclust | PASS |  |
| comparem_kmer_usage | PASS |  |
| comparem_lgt_codon | PASS |  |
| comparem_lgt_di | PASS |  |
| comparem_similarity | Failed | image problem: the image has BusyBox sort, which rejects --parallel, so the DIAMOND hit table is never sorted (hits_sorted.tsv is left unsorted, which breaks the aai and classify steps). |
| comparem_stop_usage | PASS |  |

## comparem_aai_wf

### Tool Description
Calculate AAI between all pairs of genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem aai_wf [-h] [-e EVALUE] [-p PER_IDENTITY] [-a PER_ALN_LEN]
                       [-x FILE_EXT] [--proteins] [--force_table FORCE_TABLE]
                       [--blastp] [--sensitive] [--keep_headers] [--keep_rbhs]
                       [--tmp_dir TMP_DIR] [-c CPUS] [--silent]
                       input_files output_dir

Calculate AAI between all pairs of genomes

positional arguments:
  input_files           genome files
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -e, --evalue EVALUE   e-value cutoff for identifying initial blast hits
                        (default: 0.001)
  -p, --per_identity PER_IDENTITY
                        percent identity for defining homology (default: 30.0)
  -a, --per_aln_len PER_ALN_LEN
                        percent alignment length of query sequence for
                        defining homology (default: 70.0)
  -x, --file_ext FILE_EXT
                        extension of files to process (default: fna)
  --proteins            indicates the input files contain protein sequences
  --force_table FORCE_TABLE
                        force use of specific translation table
  --blastp              use blastp instead of DIAMOND
  --sensitive           use sensitive mode of DIAMOND
  --keep_headers        indicates FASTA headers already have the format
                        <genome_id>~<gene_id>
  --keep_rbhs           create file with reciprocal best hits
  --tmp_dir TMP_DIR     specify alternative directory for temporary files
                        (default: /tmp)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_classify_wf

### Tool Description
Identify similar genomes based on AAI value.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem classify_wf [-h] [-k NUM_TOP_TARGETS] [-t TAXONOMY_FILE]
                            [-e EVALUE] [-p PER_IDENTITY] [-a PER_ALN_LEN]
                            [-x FILE_EXT] [--proteins]
                            [--force_table FORCE_TABLE] [--blastp]
                            [--sensitive] [--keep_headers] [--keep_rbhs]
                            [--tmp_dir TMP_DIR] [-c CPUS] [--silent]
                            query_files target_files output_dir

Identify similar genomes based on AAI value.

positional arguments:
  query_files           query genome files
  target_files          target genome files
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -k, --num_top_targets NUM_TOP_TARGETS
                        number of top scoring target genomes to report per
                        query genome (default: 1)
  -t, --taxonomy_file TAXONOMY_FILE
                        file indicating taxonomic identification of all target
                        genomes
  -e, --evalue EVALUE   e-value cutoff for identifying initial blast hits
                        (default: 0.001)
  -p, --per_identity PER_IDENTITY
                        percent identity for defining homology (default: 30.0)
  -a, --per_aln_len PER_ALN_LEN
                        percent alignment length of query sequence for
                        defining homology (default: 70.0)
  -x, --file_ext FILE_EXT
                        extension of files to process (default: fna)
  --proteins            indicates the input files contain protein sequences
  --force_table FORCE_TABLE
                        force use of specific translation table
  --blastp              use blastp instead of DIAMOND
  --sensitive           use sensitive mode of DIAMOND
  --keep_headers        indicates FASTA headers already have the format
                        <genome_id>~<gene_id>
  --keep_rbhs           create file with reciprocal best hits
  --tmp_dir TMP_DIR     specify alternative directory for temporary files
                        (default: /tmp)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_call_genes

### Tool Description
Identify genes within genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem call_genes [-h] [-x FILE_EXT] [--force_table FORCE_TABLE]
                           [-c CPUS] [--silent]
                           input_genomes output_dir

Identify genes within genomes.

positional arguments:
  input_genomes         genome files to process
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -x, --file_ext FILE_EXT
                        extension of files to process (default: fna)
  --force_table FORCE_TABLE
                        force use of specific translation table
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_similarity

### Tool Description
Perform sequence similarity search between genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem similarity [-h] [-e EVALUE] [-p PER_IDENTITY] [-a PER_ALN_LEN]
                           [-x FILE_EXT] [--blastp] [--sensitive]
                           [--keep_headers] [--tmp_dir TMP_DIR] [-c CPUS]
                           [--silent]
                           query_proteins target_proteins output_dir

Perform sequence similarity search between genes.

positional arguments:
  query_proteins        query protein files to process
  target_proteins       target protein files to process
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -e, --evalue EVALUE   maximum e-value for reporting an alignments (default:
                        0.001)
  -p, --per_identity PER_IDENTITY
                        minimum percent identity for reporting an alignment
                        (default: 30.0)
  -a, --per_aln_len PER_ALN_LEN
                        minimum percent coverage of query sequence for
                        reporting an alignment (default: 70.0)
  -x, --file_ext FILE_EXT
                        extension of files to process (default: faa)
  --blastp              use Blastp-fast instead of DIAMOND
  --sensitive           use sensitive mode of DIAMOND
  --keep_headers        indicates FASTA headers already have the format
                        <genome_id>~<gene_id>
  --tmp_dir TMP_DIR     specify alternative directory for temporary files
                        (default: /tmp)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_aai

### Tool Description
Calculate the AAI between all genome pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem aai [-h] [-e EVALUE] [-p PER_IDENTITY] [-a PER_ALN_LEN]
                    [--keep_rbhs] [-c CPUS] [--silent]
                    query_gene_file sorted_hit_table output_dir

Calculate the AAI between all genome pairs.

positional arguments:
  query_gene_file       file with all query genes
  sorted_hit_table      sorted file indicating genes passing sequence
                        similarity criteria
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -e, --evalue EVALUE   maximum e-value for reporting an alignments (default:
                        0.001)
  -p, --per_identity PER_IDENTITY
                        minimum percent identity for reporting an alignment
                        (default: 30.0)
  -a, --per_aln_len PER_ALN_LEN
                        minimum percent coverage of query sequence for
                        reporting an alignment (default: 70.0)
  --keep_rbhs           create file with reciprocal best hits
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_classify

### Tool Description
Identify similar genomes based on AAI value.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem classify [-h] [-k NUM_TOP_TARGETS] [-t TAXONOMY_FILE]
                         [-e EVALUE] [-p PER_IDENTITY] [-a PER_ALN_LEN]
                         [-x FILE_EXT] [--keep_rbhs] [-c CPUS] [--silent]
                         query_gene_file target_gene_file sorted_hit_table
                         output_dir

Identify similar genomes based on AAI value.

positional arguments:
  query_gene_file       file with all query genes
  target_gene_file      file with all target genes
  sorted_hit_table      sorted file indicating genes passing sequence
                        similarity criteria
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -k, --num_top_targets NUM_TOP_TARGETS
                        number of top scoring target genomes to report per
                        query genome (default: 1)
  -t, --taxonomy_file TAXONOMY_FILE
                        file indicating taxonomic identification of all target
                        genomes
  -e, --evalue EVALUE   e-value cutoff for identifying initial blast hits
                        (default: 0.001)
  -p, --per_identity PER_IDENTITY
                        percent identity for defining homology (default: 30.0)
  -a, --per_aln_len PER_ALN_LEN
                        percent alignment length of query sequence for
                        defining homology (default: 70.0)
  -x, --file_ext FILE_EXT
                        extension of files to process (default: fna)
  --keep_rbhs           create file with reciprocal best hits
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_aa_usage

### Tool Description
Calculate amino acid usage within each genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem aa_usage [-h] [--counts] [-x FILE_EXT] [-c CPUS] [--silent]
                         protein_gene_files output_file

Calculate amino acid usage within each genome.

positional arguments:
  protein_gene_files    input files with genes in amino acid space
  output_file           output file indicating amino acid usage for each
                        genome

optional arguments:
  -h, --help            show this help message and exit
  --counts              output raw counts instead of frequencies
  -x, --file_ext FILE_EXT
                        extension of files to process (default: faa)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_codon_usage

### Tool Description
Calculate codon usage within each genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem codon_usage [-h] [--counts] [-x FILE_EXT] [--keep_ambiguous]
                            [-c CPUS] [--silent]
                            nucleotide_gene_files output_file

Calculate codon usage within each genome.

positional arguments:
  nucleotide_gene_files
                        input files with genes in nucleotide space
  output_file           output file indicating codon usage of each genome

optional arguments:
  -h, --help            show this help message and exit
  --counts              output raw counts instead of frequencies
  -x, --file_ext FILE_EXT
                        extension of files to process (default: fna)
  --keep_ambiguous      keep codons with ambiguous bases
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_kmer_usage

### Tool Description
Calculate kmer usage within each genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem kmer_usage [-h] [--counts] [-k K] [-x FILE_EXT] [-c CPUS]
                           [--silent]
                           genome_files output_file

Calculate kmer usage within each genome.

positional arguments:
  genome_files          input files with genomes in nucleotide space
  output_file           output file indicating kmer usage of each genome

optional arguments:
  -h, --help            show this help message and exit
  --counts              output raw counts instead of frequencies
  -k K                  length of kmers, e.g., 4 -> tetranucleotides (default:
                        4)
  -x, --file_ext FILE_EXT
                        extension of files to process (default: fna)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_stop_usage

### Tool Description
Calculate stop codon usage within each genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem stop_usage [-h] [--counts] [--mean_gene_length] [-x FILE_EXT]
                           [-c CPUS] [--silent]
                           nucleotide_gene_files output_file

Calculate stop codon usage within each genome.

positional arguments:
  nucleotide_gene_files
                        input files with genes in nucleotide space
  output_file           output file indicating stop codon usage of each genome

optional arguments:
  -h, --help            show this help message and exit
  --counts              output raw counts instead of frequencies
  --mean_gene_length    report mean gene length for genes with each stop codon
  -x, --file_ext FILE_EXT
                        extension of files to process (default: fna)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_lgt_di

### Tool Description
Calculate dinuceotide (3rd,1st) usage of genes to identify putative LGT events.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem lgt_di [-h] [-x FILE_EXT] [--crit_value CRIT_VALUE] [-c CPUS]
                       [--silent]
                       nucleotide_gene_files output_dir

Calculate dinuceotide (3rd,1st) usage of genes to identify putative LGT
events.

positional arguments:
  nucleotide_gene_files
                        input files with genes in nucleotide space
  output_dir            output directory to write dinucleotide usage for each
                        gene in each genome

optional arguments:
  -h, --help            show this help message and exit
  -x, --file_ext FILE_EXT
                        extension of files to process (default: fna)
  --crit_value CRIT_VALUE
                        critical value for defining deviant genes (default:
                        0.001)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_lgt_codon

### Tool Description
Calculate codon usage of genes to identify putative LGT events.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem lgt_codon [-h] [-x FILE_EXT] [-c CPUS] [--silent]
                          nucleotide_gene_files output_dir

Calculate codon usage of genes to identify putative LGT events.

positional arguments:
  nucleotide_gene_files
                        input files with genes in nucleotide space
  output_dir            output directory to write dinucleotide usage for each
                        gene in each genome

optional arguments:
  -h, --help            show this help message and exit
  -x, --file_ext FILE_EXT
                        extension of files to process (default: fna)
  -c, --cpus CPUS       number of CPUs to use (default: 1)
  --silent              suppress output
```


## comparem_diss

### Tool Description
Calculate the dissimilarity between usage profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem diss [-h]
                     [--metric {euclidean,minkowski,cityblock,seuclidean,sqeuclidean,cosine,correlation,hamming,jaccard,chebyshev,canberra,braycurtis,mahalanobis,yule,matching,dice,kulsinski,rogerstanimoto,russellrao,sokalmichener,sokalsneath,wminkowski}]
                     [--full_matrix] [--silent]
                     profile_file output_file

Calculate the dissimilarity between usage profiles.

positional arguments:
  profile_file          file with usage profile for each genome
  output_file           output file with pairwise dissimilarity between
                        genomes

optional arguments:
  -h, --help            show this help message and exit
  --metric {euclidean,minkowski,cityblock,seuclidean,sqeuclidean,cosine,correlation,hamming,jaccard,chebyshev,canberra,braycurtis,mahalanobis,yule,matching,dice,kulsinski,rogerstanimoto,russellrao,sokalmichener,sokalsneath,wminkowski}
                        distance metric to use (default: euclidean)
  --full_matrix         output full dissimilarity matrix
  --silent              suppress output
```


## comparem_hclust

### Tool Description
Perform hierarchical clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparem:0.1.2--py_0
- **Homepage**: https://github.com/dparks1134/CompareM
- **Package**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparem/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/CompareM
- **Stars**: N/A
### Original Help Text
```text
usage: comparem hclust [-h]
                       [--method {single,complete,average,weighted,centroid,median,ward}]
                       [--similarity] [--max_sim_value MAX_SIM_VALUE]
                       [--name_col1 NAME_COL1] [--name_col2 NAME_COL2]
                       [--value_col VALUE_COL] [--silent]
                       pairwise_value_file output_tree

Perform hierarchical clustering.

positional arguments:
  pairwise_value_file   file with pairwise similarity or dissimilarity values
                        between genomes
  output_tree           name for output hierarchical cluster tree

optional arguments:
  -h, --help            show this help message and exit
  --method {single,complete,average,weighted,centroid,median,ward}
                        clustering method to use. (default: average)
  --similarity          indicates file contain similarity values
  --max_sim_value MAX_SIM_VALUE
                        maximum similarity value (default: 100)
  --name_col1 NAME_COL1
                        index of first column with genome names (default: 0)
  --name_col2 NAME_COL2
                        index of second column with genome names (default: 1)
  --value_col VALUE_COL
                        index of column with similarity or dissimilarity
                        values (default: 2)
  --silent              suppress output
```


## Metadata
- **Skill**: not generated
