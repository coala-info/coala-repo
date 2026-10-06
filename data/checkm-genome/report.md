# checkm-genome CWL Generation Report

## checkm-genome_checkm

### Tool Description
CheckM is a tool for assessing the quality of microbial genome bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Total Downloads**: 113.2K
- **Last updated**: 2025-08-14
- **GitHub**: https://github.com/Ecogenomics/CheckM
- **Stars**: N/A
### Original Help Text
```text
...::: CheckM v1.2.4 :::...

  Lineage-specific marker set:
    tree         -> Place bins in the reference genome tree
    tree_qa      -> Assess phylogenetic markers found in each bin
    lineage_set  -> Infer lineage-specific marker sets for each bin

  Taxonomic-specific marker set:
    taxon_list   -> List available taxonomic-specific marker sets
    taxon_set    -> Generate taxonomic-specific marker set

  Apply marker set to genome bins:
    analyze      -> Identify marker genes in bins
    qa           -> Assess bins for contamination and completeness

  Common workflows (combines above commands):
    lineage_wf   -> Runs tree, lineage_set, analyze, qa
    taxonomy_wf  -> Runs taxon_set, analyze, qa

  Reference distribution plots:
    gc_plot      -> Create GC histogram and delta-GC plot
    coding_plot  -> Create coding density (CD) histogram and delta-CD plot
    tetra_plot   -> Create tetranucleotide distance (TD) histogram and delta-TD plot
    dist_plot    -> Create image with GC, CD, and TD distribution plots together

  General plots:
    nx_plot      -> Create Nx-plots
    len_hist     -> Sequence length histogram
    marker_plot  -> Plot position of marker genes on sequences
    gc_bias_plot -> Plot bin coverage as a function of GC

  Bin exploration and modification:
    unique       -> Ensure no sequences are assigned to multiple bins
    merge        -> Identify bins with complementary sets of marker genes
    outliers     -> [Experimental] Identify outlier in bins relative to reference distributions
    modify       -> [Experimental] Modify sequences in a bin

  Utility functions:
    unbinned     -> Identify unbinned sequences
    coverage     -> Calculate coverage of sequences
    tetra        -> Calculate tetranucleotide signature of sequences
    profile      -> Calculate percentage of reads mapped to each bin
    ssu_finder   -> Identify SSU (16S/18S) rRNAs in sequences

  Use 'checkm data setRoot <checkm_data_dir>' to specify the location of CheckM database files.

  Usage: checkm <command> -h for command specific help
```

## checkm-genome_checkm lineage_wf

### Tool Description
Runs tree, lineage_set, analyze, qa

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm lineage_wf [-h] [-r] [--ali] [--nt] [-g] [-u UNIQUE] [-m MULTI]
                         [--force_domain] [--no_refinement]
                         [--individual_markers] [--skip_adj_correction]
                         [--skip_pseudogene_correction]
                         [--aai_strain AAI_STRAIN] [-a ALIGNMENT_FILE]
                         [--ignore_thresholds] [-e E_VALUE] [-l LENGTH]
                         [-f FILE] [--tab_table] [-x EXTENSION] [-t THREADS]
                         [--pplacer_threads PPLACER_THREADS] [-q]
                         [--tmpdir TMPDIR]
                         bin_input output_dir

Runs tree, lineage_set, analyze, qa

positional arguments:
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to write output files

options:
  -h, --help            show this help message and exit
  -r, --reduced_tree    use reduced tree (requires <16GB of memory) for determining lineage of each bin
  --ali                 generate HMMER alignment file for each bin
  --nt                  generate nucleotide gene sequences for each bin
  -g, --genes           bins contain genes as amino acids instead of nucleotide contigs
  -u, --unique UNIQUE   minimum number of unique phylogenetic markers required to use lineage-specific marker set (default: 10)
  -m, --multi MULTI     maximum number of multi-copy phylogenetic markers before defaulting to domain-level marker set (default: 10)
  --force_domain        use domain-level sets for all bins
  --no_refinement       do not perform lineage-specific marker set refinement
  --individual_markers  treat marker as independent (i.e., ignore co-located set structure)
  --skip_adj_correction
                        do not exclude adjacent marker genes when estimating contamination
  --skip_pseudogene_correction
                        skip identification and filtering of pseudogenes
  --aai_strain AAI_STRAIN
                        AAI threshold used to identify strain heterogeneity (default: 0.9)
  -a, --alignment_file ALIGNMENT_FILE
                        produce file showing alignment of multi-copy genes and their AAI identity
  --ignore_thresholds   ignore model-specific score thresholds
  -e, --e_value E_VALUE
                        e-value cut off (default: 1e-10)
  -l, --length LENGTH   percent overlap between target and query (default: 0.7)
  -f, --file FILE       print results to file (default: stdout)
  --tab_table           print tab-separated values table
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  -t, --threads THREADS
                        number of threads (default: 1)
  --pplacer_threads PPLACER_THREADS
                        number of threads used by pplacer (memory usage increases linearly with additional threads) (default: 1)
  -q, --quiet           suppress console output
  --tmpdir TMPDIR       specify an alternative directory for temporary files

Example: checkm lineage_wf ./bins ./output
```

## checkm-genome_checkm taxonomy_wf

### Tool Description
Runs taxon_set, analyze, qa

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm taxonomy_wf [-h] [--ali] [--nt] [-g] [--individual_markers]
                          [--skip_adj_correction]
                          [--skip_pseudogene_correction]
                          [--aai_strain AAI_STRAIN] [-a ALIGNMENT_FILE]
                          [--ignore_thresholds] [-e E_VALUE] [-l LENGTH]
                          [-c COVERAGE_FILE] [-f FILE] [--tab_table]
                          [-x EXTENSION] [-t THREADS] [-q] [--tmpdir TMPDIR]
                          {life,domain,phylum,class,order,family,genus,species}
                          taxon bin_input output_dir

Runs taxon_set, analyze, qa

positional arguments:
  {life,domain,phylum,class,order,family,genus,species}
                        taxonomic rank
  taxon                 taxon of interest
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to write output files

options:
  -h, --help            show this help message and exit
  --ali                 generate HMMER alignment file for each bin
  --nt                  generate nucleotide gene sequences for each bin
  -g, --genes           bins contain genes as amino acids instead of nucleotide contigs
  --individual_markers  treat marker as independent (i.e., ignore co-located set structure)
  --skip_adj_correction
                        do not exclude adjacent marker genes when estimating contamination
  --skip_pseudogene_correction
                        skip identification and filtering of pseudogenes
  --aai_strain AAI_STRAIN
                        AAI threshold used to identify strain heterogeneity (default: 0.9)
  -a, --alignment_file ALIGNMENT_FILE
                        produce file showing alignment of multi-copy genes and their AAI identity
  --ignore_thresholds   ignore model-specific score thresholds
  -e, --e_value E_VALUE
                        e-value cut off (default: 1e-10)
  -l, --length LENGTH   percent overlap between target and query (default: 0.7)
  -c, --coverage_file COVERAGE_FILE
                        file containing coverage of each sequence; coverage information added to table type 2 (see coverage command)
  -f, --file FILE       print results to file (default: stdout)
  --tab_table           print tab-separated values table
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  -t, --threads THREADS
                        number of threads (default: 1)
  -q, --quiet           suppress console output
  --tmpdir TMPDIR       specify an alternative directory for temporary files

Example: checkm taxonomy_wf domain Bacteria ./bins ./output
```

## checkm-genome_checkm qa

### Tool Description
Assess bins for contamination and completeness.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm qa [-h] [-o {1,2,3,4,5,6,7,8,9}]
                 [--exclude_markers EXCLUDE_MARKERS] [--individual_markers]
                 [--skip_adj_correction] [--skip_pseudogene_correction]
                 [--aai_strain AAI_STRAIN] [-a ALIGNMENT_FILE]
                 [--ignore_thresholds] [-e E_VALUE] [-l LENGTH]
                 [-c COVERAGE_FILE] [-f FILE] [--tab_table] [-t THREADS] [-q]
                 [--tmpdir TMPDIR]
                 marker_file analyze_dir

Assess bins for contamination and completeness.

positional arguments:
  marker_file           marker file specified during analyze command
  analyze_dir           directory specified during analyze command

options:
  -h, --help            show this help message and exit
  -o, --out_format {1,2,3,4,5,6,7,8,9}
                        desired output: (default: 1)
                          1. summary of bin completeness and contamination
                          2. extended summary of bin statistics (includes GC, genome size, ...)
                          3. summary of bin quality for increasingly basal lineage-specific marker sets
                          4. list of marker genes and their counts
                          5. list of bin id, marker gene id, gene id
                          6. list of marker genes present multiple times in a bin
                          7. list of marker genes present multiple times on the same scaffold
                          8. list indicating position of each marker gene within a bin
                          9. FASTA file of marker genes identified in each bin
  --exclude_markers EXCLUDE_MARKERS
                        file specifying markers to exclude from marker sets
  --individual_markers  treat marker as independent (i.e., ignore co-located set structure)
  --skip_adj_correction
                        do not exclude adjacent marker genes when estimating contamination
  --skip_pseudogene_correction
                        skip identification and filtering of pseudogenes
  --aai_strain AAI_STRAIN
                        AAI threshold used to identify strain heterogeneity (default: 0.9)
  -a, --alignment_file ALIGNMENT_FILE
                        produce file showing alignment of multi-copy genes and their AAI identity
  --ignore_thresholds   ignore model-specific score thresholds
  -e, --e_value E_VALUE
                        e-value cut off (default: 1e-10)
  -l, --length LENGTH   percent overlap between target and query (default: 0.7)
  -c, --coverage_file COVERAGE_FILE
                        file containing coverage of each sequence; coverage information added to table type 2 (see coverage command)
  -f, --file FILE       print results to file (default: stdout)
  --tab_table           print tab-separated values table
  -t, --threads THREADS
                        number of threads (default: 1)
  -q, --quiet           suppress console output
  --tmpdir TMPDIR       specify an alternative directory for temporary files

Note: lineage_wf and taxonomy_wf produce a marker file in the specified output directory. The
        lineage workflow produced a marker file called lineage.ms, while the taxonomy workflow
        produces a marker file called <taxon>.ms (e.g. Bacteria.ms).

Example: checkm qa ./output/lineage.ms ./output
```

## checkm-genome_checkm ssu_finder

### Tool Description
Identify SSU (16S/18S) rRNAs in sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm ssu_finder [-h] [-x EXTENSION] [-e EVALUE] [-c CONCATENATE]
                         [-t THREADS] [-q]
                         seq_file bin_input output_dir

Identify SSU (16S/18S) rRNAs in sequences.

positional arguments:
  seq_file              sequences used to generate bins (fasta format)
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to write output files

options:
  -h, --help            show this help message and exit
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  -e, --evalue EVALUE   e-value threshold for identifying hits (default: 1e-05)
  -c, --concatenate CONCATENATE
                        concatenate hits that are within the specified number of base pairs (default: 200)
  -t, --threads THREADS
                        number of threads (default: 1)
  -q, --quiet           suppress console output

Example: checkm ssu_finder seqs.fna ./bins ./ssu_finder
```

## checkm-genome_checkm analyze

### Tool Description
Identify marker genes in bins and calculate genome statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm analyze [-h] [--ali] [--nt] [-g] [-x EXTENSION] [-t THREADS]
                      [-q] [--tmpdir TMPDIR]
                      marker_file bin_input output_dir

Identify marker genes in bins and calculate genome statistics.

positional arguments:
  marker_file           markers for assessing bins (marker set or HMM file)
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to write output files

options:
  -h, --help            show this help message and exit
  --ali                 generate HMMER alignment file for each bin
  --nt                  generate nucleotide gene sequences for each bin
  -g, --genes           bins contain genes as amino acids instead of nucleotide contigs
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  -t, --threads THREADS
                        number of threads (default: 1)
  -q, --quiet           suppress console output
  --tmpdir TMPDIR       specify an alternative directory for temporary files

Example: checkm analyze lineage.ms ./bins ./output
```

## Metadata
- **Skill**: generated
