# checkm-genome CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| checkm-genome_checkm_analyze | PASS |  |
| checkm-genome_checkm_lineage_wf | PASS |  |
| checkm-genome_checkm_qa | PASS |  |
| checkm-genome_checkm_ssu_finder | PASS |  |
| checkm-genome_checkm_taxonomy_wf | PASS |  |
| checkm-genome_coding_plot | PASS |  |
| checkm-genome_coverage | Failed | tool bug: CheckM 1.2.4 imports pysam only inside run(), so the BAM worker crashes with NameError: name 'pysam' is not defined. |
| checkm-genome_dist_plot | PASS |  |
| checkm-genome_gc_bias_plot | Failed | tool bug: CheckM 1.2.4 coverage windows code crashes with NameError: name 'pysam' is not defined when reading the BAM. |
| checkm-genome_gc_plot | PASS |  |
| checkm-genome_len_hist | PASS |  |
| checkm-genome_lineage_set | PASS |  |
| checkm-genome_marker_plot | PASS |  |
| checkm-genome_merge | PASS |  |
| checkm-genome_modify | PASS |  |
| checkm-genome_nx_plot | PASS |  |
| checkm-genome_outliers | PASS |  |
| checkm-genome_profile | PASS |  |
| checkm-genome_taxon_list | PASS |  |
| checkm-genome_taxon_set | PASS |  |
| checkm-genome_tetra | PASS |  |
| checkm-genome_tetra_plot | PASS |  |
| checkm-genome_tree | PASS |  |
| checkm-genome_tree_qa | PASS |  |
| checkm-genome_unbinned | PASS |  |
| checkm-genome_unique | PASS |  |

## checkm-genome_checkm_lineage_wf

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

## checkm-genome_checkm_taxonomy_wf

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

## checkm-genome_checkm_qa

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

## checkm-genome_checkm_ssu_finder

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

## checkm-genome_checkm_analyze

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

## checkm-genome_tree

### Tool Description
Place bins in the genome tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm tree [-h] [-r] [--ali] [--nt] [-g] [-x EXTENSION] [-t THREADS]
                   [--pplacer_threads PPLACER_THREADS] [-q] [--tmpdir TMPDIR]
                   bin_input output_dir

Place bins in the genome tree.

positional arguments:
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to write output files

options:
  -h, --help            show this help message and exit
  -r, --reduced_tree    use reduced tree (requires <16GB of memory) for determining lineage of each bin
  --ali                 generate HMMER alignment file for each bin
  --nt                  generate nucleotide gene sequences for each bin
  -g, --genes           bins contain genes as amino acids instead of nucleotide contigs
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  -t, --threads THREADS
                        number of threads (default: 1)
  --pplacer_threads PPLACER_THREADS
                        number of threads used by pplacer (memory usage increases linearly with additional threads) (default: 1)
  -q, --quiet           suppress console output
  --tmpdir TMPDIR       specify an alternative directory for temporary files

Example: checkm tree ./bins ./output
```


## checkm-genome_tree_qa

### Tool Description
Assess phylogenetic markers found in each bin.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm tree_qa [-h] [-o {1,2,3,4,5}] [-f FILE] [--tab_table] [-q]
                      [--tmpdir TMPDIR]
                      tree_dir

Assess phylogenetic markers found in each bin.

positional arguments:
  tree_dir              directory specified during tree command

options:
  -h, --help            show this help message and exit
  -o, --out_format {1,2,3,4,5}
                        desired output: (default: 1)
                          1. brief summary of genome tree placement
                          2. detailed summary of genome tree placement including lineage-specific statistics
                          3. genome tree in Newick format decorated with IMG genome ids
                          4. genome tree in Newick format decorated with taxonomy strings
                          5. multiple sequence alignment of reference genomes and bins
  -f, --file FILE       print results to file (default: stdout)
  --tab_table           print tab-separated values table
  -q, --quiet           suppress console output
  --tmpdir TMPDIR       specify an alternative directory for temporary files

Example: checkm tree_qa ./output
```


## checkm-genome_lineage_set

### Tool Description
Infer lineage-specific marker sets for each bin.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm lineage_set [-h] [-u UNIQUE] [-m MULTI] [--force_domain]
                          [--no_refinement] [-q] [--tmpdir TMPDIR]
                          tree_dir marker_file

Infer lineage-specific marker sets for each bin.

positional arguments:
  tree_dir             directory specified during tree command
  marker_file          output file describing marker set for each bin

options:
  -h, --help           show this help message and exit
  -u, --unique UNIQUE  minimum number of unique phylogenetic markers required to use lineage-specific marker set (default: 10)
  -m, --multi MULTI    maximum number of multi-copy phylogenetic markers before defaulting to domain-level marker set (default: 10)
  --force_domain       use domain-level sets for all bins
  --no_refinement      do not perform lineage-specific marker set refinement
  -q, --quiet          suppress console output
  --tmpdir TMPDIR      specify an alternative directory for temporary files

Example: checkm lineage_set ./output lineage.ms
```


## checkm-genome_taxon_list

### Tool Description
List available taxonomic-specific marker sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm taxon_list [-h]
                         [--rank {ALL,life,domain,phylum,class,order,family,genus,species}]
                         [--tmpdir TMPDIR]

List available taxonomic-specific marker sets.

options:
  -h, --help            show this help message and exit
  --rank {ALL,life,domain,phylum,class,order,family,genus,species}
                        restrict list to specified taxonomic rank (default: ALL)
  --tmpdir TMPDIR       specify an alternative directory for temporary files

Example: checkm taxon_list --rank phylum
```


## checkm-genome_taxon_set

### Tool Description
Generate taxonomic-specific marker set.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm taxon_set [-h] [-q] [--tmpdir TMPDIR]
                        {life,domain,phylum,class,order,family,genus,species}
                        taxon marker_file

Generate taxonomic-specific marker set.

positional arguments:
  {life,domain,phylum,class,order,family,genus,species}
                        taxonomic rank
  taxon                 taxon of interest
  marker_file           output file describing taxonomic-specific marker set

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress console output
  --tmpdir TMPDIR       specify an alternative directory for temporary files

Example: checkm taxon_set domain Bacteria bacteria.ms
```


## checkm-genome_gc_plot

### Tool Description
Create GC histogram and delta-GC plot.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm gc_plot [-h] [--image_type {eps,pdf,png,ps,svg}] [--dpi DPI]
                      [--font_size FONT_SIZE] [-x EXTENSION] [--width WIDTH]
                      [--height HEIGHT] [-w GC_WINDOW_SIZE] [-b GC_BIN_WIDTH]
                      [-q]
                      bin_input output_dir dist_value [dist_value ...]

Create GC histogram and delta-GC plot.

positional arguments:
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to hold plots
  dist_value            reference distribution(s) to plot; integer between 0 and 100

options:
  -h, --help            show this help message and exit
  --image_type {eps,pdf,png,ps,svg}
                        desired image type (default: png)
  --dpi DPI             desired DPI of output image (default: 600)
  --font_size FONT_SIZE
                        Desired font size (default: 8)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  --width WIDTH         width of output image (default: 6.5)
  --height HEIGHT       height of output image (default: 3.5)
  -w, --gc_window_size GC_WINDOW_SIZE
                        window size used to calculate GC histogram (default: 5000)
  -b, --gc_bin_width GC_BIN_WIDTH
                        width of GC bars in histogram (default: 0.01)
  -q, --quiet           suppress console output

Example: checkm gc_plot ./bins ./plots 95
```


## checkm-genome_coding_plot

### Tool Description
Create coding density (CD) histogram and delta-CD plot.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm coding_plot [-h] [--image_type {eps,pdf,png,ps,svg}] [--dpi DPI]
                          [--font_size FONT_SIZE] [-x EXTENSION]
                          [--width WIDTH] [--height HEIGHT]
                          [-w CD_WINDOW_SIZE] [-b CD_BIN_WIDTH] [-q]
                          results_dir bin_input output_dir dist_value
                          [dist_value ...]

Create coding density (CD) histogram and delta-CD plot.

positional arguments:
  results_dir           directory specified during qa command
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to hold plots
  dist_value            reference distribution(s) to plot; integer between 0 and 100

options:
  -h, --help            show this help message and exit
  --image_type {eps,pdf,png,ps,svg}
                        desired image type (default: png)
  --dpi DPI             desired DPI of output image (default: 600)
  --font_size FONT_SIZE
                        Desired font size (default: 8)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  --width WIDTH         width of output image (default: 6.5)
  --height HEIGHT       height of output image (default: 3.5)
  -w, --cd_window_size CD_WINDOW_SIZE
                        window size used to calculate CD histogram (default: 10000)
  -b, --cd_bin_width CD_BIN_WIDTH
                        width of CD bars in histogram (default: 0.01)
  -q, --quiet           suppress console output

Example: checkm coding_plot ./output ./bins ./plots 95
```


## checkm-genome_tetra_plot

### Tool Description
Create tetranucleotide distance (TD) histogram and delta-TD plot.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm tetra_plot [-h] [--image_type {eps,pdf,png,ps,svg}] [--dpi DPI]
                         [--font_size FONT_SIZE] [-x EXTENSION]
                         [--width WIDTH] [--height HEIGHT] [-w TD_WINDOW_SIZE]
                         [-b TD_BIN_WIDTH] [-q]
                         results_dir bin_input output_dir tetra_profile
                         dist_value [dist_value ...]

Create tetranucleotide distance (TD) histogram and delta-TD plot.

positional arguments:
  results_dir           directory specified during qa command
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to hold plots
  tetra_profile         tetranucleotide profiles for each bin (see tetra command)
  dist_value            reference distribution(s) to plot; integer between 0 and 100

options:
  -h, --help            show this help message and exit
  --image_type {eps,pdf,png,ps,svg}
                        desired image type (default: png)
  --dpi DPI             desired DPI of output image (default: 600)
  --font_size FONT_SIZE
                        Desired font size (default: 8)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  --width WIDTH         width of output image (default: 6.5)
  --height HEIGHT       height of output image (default: 3.5)
  -w, --td_window_size TD_WINDOW_SIZE
                        window size used to calculate TD histogram (default: 5000)
  -b, --td_bin_width TD_BIN_WIDTH
                        width of TD bars in histogram (default: 0.01)
  -q, --quiet           suppress console output

Example: checkm tetra_plot ./output ./bins ./plots tetra.tsv 95
```


## checkm-genome_dist_plot

### Tool Description
Create image with GC, CD, and TD distribution plots together.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm dist_plot [-h] [--image_type {eps,pdf,png,ps,svg}] [--dpi DPI]
                        [--font_size FONT_SIZE] [-x EXTENSION] [--width WIDTH]
                        [--height HEIGHT] [-a GC_WINDOW_SIZE]
                        [-b TD_WINDOW_SIZE] [-c CD_WINDOW_SIZE]
                        [-1 GC_BIN_WIDTH] [-2 TD_BIN_WIDTH] [-3 CD_BIN_WIDTH]
                        [-q]
                        results_dir bin_input output_dir tetra_profile
                        dist_value [dist_value ...]

Create image with GC, CD, and TD distribution plots together.

positional arguments:
  results_dir           directory specified during analyze command
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to hold plots
  tetra_profile         tetranucleotide profiles for each sequence (see tetra command)
  dist_value            reference distribution(s) to plot; integer between 0 and 100

options:
  -h, --help            show this help message and exit
  --image_type {eps,pdf,png,ps,svg}
                        desired image type (default: png)
  --dpi DPI             desired DPI of output image (default: 600)
  --font_size FONT_SIZE
                        Desired font size (default: 8)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  --width WIDTH         width of output image (default: 6.5)
  --height HEIGHT       height of output image (default: 8)
  -a, --gc_window_size GC_WINDOW_SIZE
                        window size used to calculate GC histogram (default: 5000)
  -b, --td_window_size TD_WINDOW_SIZE
                        window size used to calculate TD histogram (default: 5000)
  -c, --cd_window_size CD_WINDOW_SIZE
                        window size used to calculate CD histogram (default: 10000)
  -1, --gc_bin_width GC_BIN_WIDTH
                        width of GC bars in histogram (default: 0.01)
  -2, --td_bin_width TD_BIN_WIDTH
                        width of TD bars in histogram (default: 0.01)
  -3, --cd_bin_width CD_BIN_WIDTH
                        width of CD bars in histogram (default: 0.01)
  -q, --quiet           suppress console output

Example: checkm dist_plot ./output ./bins ./plots tetra.tsv 95
```


## checkm-genome_nx_plot

### Tool Description
Create Nx-plots.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm nx_plot [-h] [--image_type {eps,pdf,png,ps,svg}] [--dpi DPI]
                      [--font_size FONT_SIZE] [-x EXTENSION] [--width WIDTH]
                      [--height HEIGHT] [-s STEP_SIZE] [-q]
                      bin_input output_dir

Create Nx-plots.

positional arguments:
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to hold plots

options:
  -h, --help            show this help message and exit
  --image_type {eps,pdf,png,ps,svg}
                        desired image type (default: png)
  --dpi DPI             desired DPI of output image (default: 600)
  --font_size FONT_SIZE
                        Desired font size (default: 8)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  --width WIDTH         width of output image (default: 6.5)
  --height HEIGHT       height of output image (default: 6.5)
  -s, --step_size STEP_SIZE
                        x step size for calculating Nx (default: 0.05)
  -q, --quiet           suppress console output

Example: checkm nx_plot ./bins ./plots
```


## checkm-genome_len_hist

### Tool Description
Sequence length histogram.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm len_hist [-h] [--image_type {eps,pdf,png,ps,svg}] [--dpi DPI]
                       [--font_size FONT_SIZE] [-x EXTENSION] [--width WIDTH]
                       [--height HEIGHT] [-q]
                       bin_input output_dir

Sequence length histogram.

positional arguments:
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to hold plots

options:
  -h, --help            show this help message and exit
  --image_type {eps,pdf,png,ps,svg}
                        desired image type (default: png)
  --dpi DPI             desired DPI of output image (default: 600)
  --font_size FONT_SIZE
                        Desired font size (default: 8)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  --width WIDTH         width of output image (default: 6.5)
  --height HEIGHT       height of output image (default: 6.5)
  -q, --quiet           suppress console output

Example: checkm len_hist ./bins ./plots
```


## checkm-genome_marker_plot

### Tool Description
Plot position of marker genes on sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm marker_plot [-h] [--image_type {eps,pdf,png,ps,svg}] [--dpi DPI]
                          [--font_size FONT_SIZE] [-x EXTENSION]
                          [--width WIDTH] [--height HEIGHT]
                          [--fig_padding FIG_PADDING] [-q]
                          results_dir bin_input output_dir

Plot position of marker genes on sequences.

positional arguments:
  results_dir           directory specified during qa command
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to hold plots

options:
  -h, --help            show this help message and exit
  --image_type {eps,pdf,png,ps,svg}
                        desired image type (default: png)
  --dpi DPI             desired DPI of output image (default: 600)
  --font_size FONT_SIZE
                        Desired font size (default: 8)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  --width WIDTH         width of output image (default: 6.5)
  --height HEIGHT       height of output image (default: 6.5)
  --fig_padding FIG_PADDING
                        white space to place around figure (in inches) (default: 0.2)
  -q, --quiet           suppress console output

Example: checkm marker_plot ./output ./bins ./plots
```


## checkm-genome_gc_bias_plot

### Tool Description
Plot bin coverage as a function of GC.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm gc_bias_plot [-h] [--image_type {eps,pdf,png,ps,svg}]
                           [--dpi DPI] [--font_size FONT_SIZE] [-x EXTENSION]
                           [--width WIDTH] [--height HEIGHT] [-w WINDOW_SIZE]
                           [-r] [-a MIN_ALIGN] [-e MAX_EDIT_DIST] [-t THREADS]
                           [-q]
                           bin_input output_dir bam_file

Plot bin coverage as a function of GC.

positional arguments:
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to hold plots
  bam_file              BAM file to interrogate for coverage information

options:
  -h, --help            show this help message and exit
  --image_type {eps,pdf,png,ps,svg}
                        desired image type (default: png)
  --dpi DPI             desired DPI of output image (default: 600)
  --font_size FONT_SIZE
                        Desired font size (default: 8)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  --width WIDTH         width of output image (default: 6.5)
  --height HEIGHT       height of output image (default: 3.5)
  -w, --window_size WINDOW_SIZE
                        window size used to calculate plot statistics (default: 5000)
  -r, --all_reads       use all reads to estimate coverage instead of just those in proper pairs
  -a, --min_align MIN_ALIGN
                        minimum alignment length as percentage of read length (default: 0.98)
  -e, --max_edit_dist MAX_EDIT_DIST
                        maximum edit distance as percentage of read length (default: 0.02)
  -t, --threads THREADS
                        number of threads (default: 1)
  -q, --quiet           suppress console output

Example: checkm gc_bias_plot ./bins ./plots example.bam
```


## checkm-genome_unique

### Tool Description
Ensure no sequences are assigned to multiple bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm unique [-h] [-x EXTENSION] bin_input

Ensure no sequences are assigned to multiple bins.

positional arguments:
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]

options:
  -h, --help            show this help message and exit
  -x, --extension EXTENSION
                        extension of bins (all other files in bin directory are ignored) (default: fna)

Example: checkm unique ./bins
```


## checkm-genome_merge

### Tool Description
Identify bins with complementary sets of marker genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm merge [-h] [-g] [--delta_comp DELTA_COMP]
                    [--delta_cont DELTA_CONT] [--merged_comp MERGED_COMP]
                    [--merged_cont MERGED_CONT] [-x EXTENSION] [-t THREADS]
                    [-q]
                    marker_file bin_input output_dir

Identify bins with complementary sets of marker genes.

positional arguments:
  marker_file           marker file to use for assessing potential bin mergers (marker set or HMM file)
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_dir            directory to write output files

options:
  -h, --help            show this help message and exit
  -g, --genes           bins contain genes as amino acids instead of nucleotide contigs
  --delta_comp DELTA_COMP
                        minimum increase in completeness to report pair (default: 5.0)
  --delta_cont DELTA_CONT
                        maximum increase in contamination to report pair (default: 10.0)
  --merged_comp MERGED_COMP
                        minimum merged completeness to report pair (default: 50.0)
  --merged_cont MERGED_CONT
                        maximum merged contamination to report pair (default: 20.0)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  -t, --threads THREADS
                        number of threads (default: 1)
  -q, --quiet           suppress console output

Example: checkm merge bacteria.ms ./bins ./output
```


## checkm-genome_outliers

### Tool Description
Identify outliers in bins relative to reference distributions.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm outliers [-h] [-d dist_value] [-r {any,all}] [-x EXTENSION] [-q]
                       results_dir bin_input tetra_profile output_file

Identify outliers in bins relative to reference distributions.

positional arguments:
  results_dir           directory specified during qa command
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  tetra_profile         tetranucleotide profiles for each sequence (see tetra command)
  output_file           print results to file

options:
  -h, --help            show this help message and exit
  -d, --distributions dist_value
                        reference distribution used to identify outliers; integer between 0 and 100 (default: 95)
  -r, --report_type {any,all}
                        report sequences that are outliers in 'all' or 'any' reference distribution (default: any)
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  -q, --quiet           suppress console output

Example: checkm outliers ./output ./bins tetra.tsv outliers.tsv
```


## checkm-genome_modify

### Tool Description
Modify sequences in a bin.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm modify [-h] [-a ADD] [-r REMOVE] [-o OUTLIER_FILE] [-q]
                     seq_file bin_file output_file

Modify sequences in a bin.

positional arguments:
  seq_file              sequences used to generate bins (fasta format)
  bin_file              bin to be modified
  output_file           modified bin

options:
  -h, --help            show this help message and exit
  -a, --add ADD         ID of sequence to add to bin (may specify multiple times)
  -r, --remove REMOVE   ID of sequence to remove from bin (may specify multiple times)
  -o, --outlier_file OUTLIER_FILE
                        remove all sequences marked as outliers in the bin (see outlier command)
  -q, --quiet           suppress console output

Example: checkm modify -r seq_id1 -r seq_id2 seqs.fna bin.fna new_bin.fna
```


## checkm-genome_unbinned

### Tool Description
Identify unbinned sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm unbinned [-h] [-x EXTENSION] [-s MIN_SEQ_LEN] [-q]
                       bin_input seq_file output_seq_file output_stats_file

Identify unbinned sequences.

positional arguments:
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  seq_file              sequences used to generate bins (fasta format)
  output_seq_file       write unbinned sequences to file
  output_stats_file     write unbinned sequence statistics to file

options:
  -h, --help            show this help message and exit
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  -s, --min_seq_len MIN_SEQ_LEN
                        required length of sequence
  -q, --quiet           suppress console output

Example: checkm unbinned ./bins seqs.fna unbinned.fna unbinned_stats.tsv
```


## checkm-genome_coverage

### Tool Description
Calculate coverage of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm coverage [-h] [-x EXTENSION] [-r] [-a MIN_ALIGN]
                       [-e MAX_EDIT_DIST] [-m MIN_QC] [-t THREADS] [-q]
                       bin_input output_file bam_files [bam_files ...]

Calculate coverage of sequences.

positional arguments:
  bin_input             directory containing bins (fasta format) or path to file describing genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome translation file (pep)]
  output_file           print results to file
  bam_files             BAM files to parse

options:
  -h, --help            show this help message and exit
  -x, --extension EXTENSION
                        extension of bins (other files in directory are ignored) (default: fna)
  -r, --all_reads       use all reads to estimate coverage instead of just those in proper pairs
  -a, --min_align MIN_ALIGN
                        minimum alignment length as percentage of read length (default: 0.98)
  -e, --max_edit_dist MAX_EDIT_DIST
                        maximum edit distance as percentage of read length (default: 0.02)
  -m, --min_qc MIN_QC   minimum quality score (in phred) (default: 15)
  -t, --threads THREADS
                        number of threads (default: 1)
  -q, --quiet           suppress console output

Example: checkm coverage ./bins coverage.tsv example_1.bam example_2.bam
```


## checkm-genome_tetra

### Tool Description
Calculate tetranucleotide signature of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm tetra [-h] [-t THREADS] [-q] seq_file output_file

Calculate tetranucleotide signature of sequences.

positional arguments:
  seq_file              sequences used to generate bins (fasta format)
  output_file           print results to file

options:
  -h, --help            show this help message and exit
  -t, --threads THREADS
                        number of threads (default: 1)
  -q, --quiet           suppress console output

Example: checkm tetra seqs.fna tetra.tsv
```


## checkm-genome_profile

### Tool Description
Calculate percentage of reads mapped to each bin.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/Ecogenomics/CheckM
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm-genome/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm profile [-h] [-f FILE] [--tab_table] [-q] coverage_file

Calculate percentage of reads mapped to each bin.

positional arguments:
  coverage_file    file indicating coverage of each sequence (see coverage command)

options:
  -h, --help       show this help message and exit
  -f, --file FILE  print results to file (default: stdout)
  --tab_table      print tab-separated values table
  -q, --quiet      suppress console output

Example: checkm profile coverage.tsv
```


## Metadata
- **Skill**: generated
