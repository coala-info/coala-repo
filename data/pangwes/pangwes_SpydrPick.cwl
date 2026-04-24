cwlVersion: v1.2
class: CommandLineTool
baseCommand: SpydrPick
label: pangwes_SpydrPick
doc: "MI-ARACNE genome-wide co-evolution analysis.\n\nTool homepage: https://github.com/jurikuronen/PANGWES"
inputs:
  - id: alignment_file_positional
    type: File
    doc: The input alignment filename(s). When two filenames are specified, only inter-alignment
      links will be probed for.
    inputBinding:
      position: 1
  - id: alignment_file
    type:
      - 'null'
      - type: array
        items: File
    doc: The input alignment filename(s). When two filenames are specified, only inter-alignment
      links will be probed for.
    inputBinding:
      position: 102
      prefix: --alignmentfile
  - id: aracne_block_size
    type:
      - 'null'
      - int
    doc: Block size for graph processing.
    inputBinding:
      position: 102
      prefix: --aracne-block-size
  - id: aracne_edge_threshold
    type:
      - 'null'
      - float
    doc: Equality tolerance threshold. Edges differing by less than this value are
      considered equal in strength.
    inputBinding:
      position: 102
      prefix: --aracne-edge-threshold
  - id: aracne_node_grouping_size
    type:
      - 'null'
      - int
    doc: Grouping size for node processing.
    inputBinding:
      position: 102
      prefix: --aracne-node-grouping-size
  - id: begin
    type:
      - 'null'
      - int
    doc: The first locus index to work on. Used to define a range.
    inputBinding:
      position: 102
      prefix: --begin
  - id: end
    type:
      - 'null'
      - int
    doc: The last locus index to work on (-1=end of input). Used to define a range.
    inputBinding:
      position: 102
      prefix: --end
  - id: exclude_list
    type:
      - 'null'
      - File
    doc: Name of file containing list of loci to exclude from analysis.
    inputBinding:
      position: 102
      prefix: --exclude-list
  - id: gap_threshold
    type:
      - 'null'
      - float
    doc: Gap frequency threshold. Positions with a gap frequency above the threshold
      are excluded from the pair-analysis.
    inputBinding:
      position: 102
      prefix: --gap-threshold
  - id: genome_size
    type:
      - 'null'
      - int
    doc: 'Genome size, if different from input. Default = 0: detect size from input.'
    inputBinding:
      position: 102
      prefix: --genome-size
  - id: include_list
    type:
      - 'null'
      - File
    doc: Name of file containing list of loci to include in analysis.
    inputBinding:
      position: 102
      prefix: --include-list
  - id: input_indexing_base
    type:
      - 'null'
      - int
    doc: Base index for input.
    inputBinding:
      position: 102
      prefix: --input-indexing-base
  - id: ld_threshold
    type:
      - 'null'
      - float
    doc: Threshold distance for linkage disequilibrium (LD).
    inputBinding:
      position: 102
      prefix: --ld-threshold
  - id: linear_genome
    type:
      - 'null'
      - boolean
    doc: Assume linear genome in distance calculations.
    inputBinding:
      position: 102
      prefix: --linear-genome
  - id: maf_threshold
    type:
      - 'null'
      - float
    doc: Minor state frequency threshold. Loci with less than 2 states above threshold
      are removed from alignment.
    inputBinding:
      position: 102
      prefix: --maf-threshold
  - id: mapping_list
    type:
      - 'null'
      - File
    doc: Name of file containing loci mappings.
    inputBinding:
      position: 102
      prefix: --mapping-list
  - id: mi_pseudocount
    type:
      - 'null'
      - float
    doc: The MI pseudocount value.
    inputBinding:
      position: 102
      prefix: --mi-pseudocount
  - id: mi_threshold
    type:
      - 'null'
      - float
    doc: The MI threshold value. Experience suggests that a value of 0.11 is often
      reasonable. Zero indicates no threshold and negative values will trigger auto-define
      heuristics.
    inputBinding:
      position: 102
      prefix: --mi-threshold
  - id: mi_threshold_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations for estimating saving threshold.
    inputBinding:
      position: 102
      prefix: --mi-threshold-iterations
  - id: mi_threshold_pairs
    type:
      - 'null'
      - int
    doc: Number of sampled pairs for estimating saving threshold (0=determine automatically).
    inputBinding:
      position: 102
      prefix: --mi-threshold-pairs
  - id: mi_values
    type:
      - 'null'
      - int
    doc: Approximate number of MI values to calculate from data (default=#samples*100).
    inputBinding:
      position: 102
      prefix: --mi-values
  - id: no_aracne
    type:
      - 'null'
      - boolean
    doc: Skip ARACNE, only calculate MI.
    inputBinding:
      position: 102
      prefix: --no-aracne
  - id: no_filter_alignment
    type:
      - 'null'
      - boolean
    doc: Do not filter alignment columns by applying MAF and GAP thresholds.
    inputBinding:
      position: 102
      prefix: --no-filter-alignment
  - id: no_sample_reweighting
    type:
      - 'null'
      - boolean
    doc: Turn sample reweighting off, i.e. do not try to correct for population structure.
    inputBinding:
      position: 102
      prefix: --no-sample-reweighting
  - id: output_indexing_base
    type:
      - 'null'
      - int
    doc: Base index for output.
    inputBinding:
      position: 102
      prefix: --output-indexing-base
  - id: rescale_sample_weights
    type:
      - 'null'
      - boolean
    doc: Rescale sample weights so that n(effective) == n.
    inputBinding:
      position: 102
      prefix: --rescale-sample-weights
  - id: sample_list
    type:
      - 'null'
      - File
    doc: The sample filter list input filename.
    inputBinding:
      position: 102
      prefix: --sample-list
  - id: sample_reweighting_threshold
    type:
      - 'null'
      - float
    doc: Fraction of identical positions required for two samples to be considered
      identical.
    inputBinding:
      position: 102
      prefix: --sample-reweighting-threshold
  - id: sample_weights
    type:
      - 'null'
      - File
    doc: Name of file containing sample weights.
    inputBinding:
      position: 102
      prefix: --sample-weights
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads per MPI/shared memory node (-1=use all hardware threads
      that the OS/environment exposes).
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_state_frequencies
    type:
      - 'null'
      - File
    doc: Write column-wise state frequencies to file.
    outputBinding:
      glob: $(inputs.output_state_frequencies)
  - id: output_sample_weights
    type:
      - 'null'
      - File
    doc: Output sample weights.
    outputBinding:
      glob: $(inputs.output_sample_weights)
  - id: output_sample_distance_matrix
    type:
      - 'null'
      - File
    doc: Output triangular sample-sample Hamming distance matrix.
    outputBinding:
      glob: $(inputs.output_sample_distance_matrix)
  - id: output_alignment
    type:
      - 'null'
      - File
    doc: Write alignment to file.
    outputBinding:
      glob: $(inputs.output_alignment)
  - id: output_filtered_alignment
    type:
      - 'null'
      - File
    doc: Write filtered alignment to file.
    outputBinding:
      glob: $(inputs.output_filtered_alignment)
  - id: aracne_output_file
    type:
      - 'null'
      - File
    doc: The ARACNE output filename. This is a binary file for "plot.r".
    outputBinding:
      glob: $(inputs.aracne_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
