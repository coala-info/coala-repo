cwlVersion: v1.2
class: CommandLineTool
baseCommand: secedo
label: secedo
doc: "secedo -i <input_dir> -o <output_dir> arguments\n\nTool homepage: https://github.com/ratschlab/secedo"
inputs:
  - id: arma_kmeans
    type:
      - 'null'
      - boolean
    doc: Whether to use Armadillo's k-means implementation or our own (which is 
      very simple, but it weights the Fiedler vector higher, reducing the effect
      of the curse of dimensionality)
    inputBinding:
      position: 101
      prefix: -arma_kmeans
  - id: chromosomes
    type:
      - 'null'
      - string
    doc: The chromosomes on which to run the algorithm
    inputBinding:
      position: 101
      prefix: -chromosomes
  - id: clustering
    type:
      - 'null'
      - string
    doc: If provided read the clustering from this file and only perform variant
      calling
    inputBinding:
      position: 101
      prefix: -clustering
  - id: clustering_type
    type:
      - 'null'
      - string
    doc: How to perform spectral clustering. One of FIEDLER, SPECTRAL2, 
      SPECTRAL6. See spectral_clustering.hpp for details.
    inputBinding:
      position: 101
      prefix: -clustering_type
  - id: compute_read_stats
    type:
      - 'null'
      - boolean
    doc: If set to true, the algorithm will compute the maximum fragment length 
      and the longest fragment for each pileup file (expensive)
    inputBinding:
      position: 101
      prefix: -compute_read_stats
  - id: expectation_maximization
    type:
      - 'null'
      - boolean
    doc: If true, the spectral clustering results will be refined using an 
      Expectation Maximization algorithm
    inputBinding:
      position: 101
      prefix: -expectation_maximization
  - id: flagfile
    type:
      - 'null'
      - string
    doc: load flags from file
    inputBinding:
      position: 101
      prefix: -flagfile
  - id: fromenv
    type:
      - 'null'
      - string
    doc: set flags from the environment [use 'export FLAGS_flag1=value']
    inputBinding:
      position: 101
      prefix: -fromenv
  - id: heterozygous_prob
    type:
      - 'null'
      - float
    doc: The probability that a locus is heterozygous in the human genome
    inputBinding:
      position: 101
      prefix: -heterozygous_prob
  - id: homozygous_filtered_rate
    type:
      - 'null'
      - float
    doc: The fraction of homozygous non-informative loci, i.e. the probability 
      that cells at a filtered locus actually have identical homozygous 
      genotype.
    inputBinding:
      position: 101
      prefix: -homozygous_filtered_rate
  - id: input_dir
    type: Directory
    doc: Input file or directory containing 'pileup' textual or binary format 
      from an alignment, as written by preprocessing.py
    inputBinding:
      position: 101
      prefix: -i
  - id: labels_file
    type:
      - 'null'
      - string
    doc: Input file containing labels
    inputBinding:
      position: 101
      prefix: -labels_file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'The log verbosity: debug, trace, info, warn, error, critical, off'
    inputBinding:
      position: 101
      prefix: -log_level
  - id: map_file
    type:
      - 'null'
      - string
    doc: If not empty, maps positions in --reference_genome to positions in the 
      haploid genome that --reference_genome is based on (e.g. to GRCh38)
    inputBinding:
      position: 101
      prefix: -map_file
  - id: max_cell_count
    type:
      - 'null'
      - int
    doc: Maximum expected cell count, used to initialize the cell grouping
    inputBinding:
      position: 101
      prefix: -max_cell_count
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Positions with higher coverage are considered anomalies and discarded
    inputBinding:
      position: 101
      prefix: -max_coverage
  - id: merge_count
    type:
      - 'null'
      - int
    doc: Pool data from  merge_count consecutive cells as if they were a single 
      cell, in  order to artificially increase coverage. Only works on synthetic
      data where we know consecutive cells are part of the same cluster!
    inputBinding:
      position: 101
      prefix: -merge_count
  - id: merge_file
    type:
      - 'null'
      - string
    doc: File containing cell grouping. Cells in the same group are treated as 
      if they were a single cell. Useful for artificially increasing coverage 
      for testing.
    inputBinding:
      position: 101
      prefix: -merge_file
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Stop clustering when the size of a cluster is below this value
    inputBinding:
      position: 101
      prefix: -min_cluster_size
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: epsilon, estimated frequency of mutated loci in the pre-processed data 
      set
    inputBinding:
      position: 101
      prefix: -mutation_rate
  - id: normalization
    type:
      - 'null'
      - string
    doc: How to normalize the similarity matrix. One of ADD_MIN, EXPONENTIATE, 
      SCALE_MAX_1
    inputBinding:
      position: 101
      prefix: -normalization
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: -num_threads
  - id: pos_file
    type:
      - 'null'
      - string
    doc: When present, only consider positions in this file. The file must have 
      2 columns, first one is chromosome id, second is position.
    inputBinding:
      position: 101
      prefix: -pos_file
  - id: reference_genome
    type:
      - 'null'
      - string
    doc: The genome against which variants are called, if provided. The fasta 
      file must have 2x24 sections, with the maternal chromosome being followed 
      by the paternal chromosome
    inputBinding:
      position: 101
      prefix: -reference_genome
  - id: seq_error_rate
    type:
      - 'null'
      - float
    doc: Sequencing errors rate, denoted by theta
    inputBinding:
      position: 101
      prefix: -seq_error_rate
  - id: tab_completion_columns
    type:
      - 'null'
      - int
    doc: Number of columns to use in output for tab completion
    inputBinding:
      position: 101
      prefix: -tab_completion_columns
  - id: tab_completion_word
    type:
      - 'null'
      - string
    doc: If non-empty, HandleCommandLineCompletions() will hijack the process 
      and attempt to do bash-style command line flag completion on this value.
    inputBinding:
      position: 101
      prefix: -tab_completion_word
  - id: termination
    type:
      - 'null'
      - string
    doc: Which criteria to use for determining if a Simple or Multivariate 
      Gaussian matches the data better (AIC/BIC)
    inputBinding:
      position: 101
      prefix: -termination
  - id: tryfromenv
    type:
      - 'null'
      - string
    doc: set flags from the environment if present
    inputBinding:
      position: 101
      prefix: -tryfromenv
  - id: tumor_purity
    type:
      - 'null'
      - int
    doc: Estimated tumor purity (proportion of healthy vs total cells). Only 
      used in the first level of clustering. Values can be 1->10%/90%, 
      2->20%/80%, 3->30%/70%, 4->40%/60% or 5->50%
    inputBinding:
      position: 101
      prefix: -tumor_purity
  - id: undefok
    type:
      - 'null'
      - string
    doc: 'comma-separated list of flag names that it is okay to specify on the command
      line even if the program does not define a flag with that name.  IMPORTANT:
      flags in this list that have arguments MUST use the flag=value format'
    inputBinding:
      position: 101
      prefix: -undefok
outputs:
  - id: output_dir
    type: Directory
    doc: Directory where the output will be written.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secedo:1.0.7--ha041835_4
