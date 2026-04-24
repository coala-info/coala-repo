cwlVersion: v1.2
class: CommandLineTool
baseCommand: basil
label: anise_basil
doc: "Scan SAM/BAM file MAPPING for signatures of structural variations.\n\nTool homepage:
  https://github.com/seqan/anise_basil"
inputs:
  - id: auto_library_num_records
    type:
      - 'null'
      - int
    doc: Number of records to use for automatic library evaluation. Set to 0 to evaluate
      all. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --auto-library-num-records
  - id: breakpoint_window_radius
    type:
      - 'null'
      - int
    doc: Radius around breakpoints to extract for remapping. Set to 0 to use maximal
      fragment size. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --breakpoint-window-radius
  - id: clipping_min_coverage
    type:
      - 'null'
      - int
    doc: The number of clipping positions to find in one window such that the window
      is not discarded.
    inputBinding:
      position: 101
      prefix: --clipping-min-coverage
  - id: clipping_min_length
    type:
      - 'null'
      - int
    doc: Smallest number of characters that have to be soft-clipped such that the
      alignment is not ignored.
    inputBinding:
      position: 101
      prefix: --clipping-min-length
  - id: clipping_window_radius
    type:
      - 'null'
      - int
    doc: Window radius to use for clipping position clustering. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --clipping-window-radius
  - id: filter_max_coverage
    type:
      - 'null'
      - int
    doc: Filter out calls at locations that have a higher coverage than this number.
      Set to 0 to disable filter. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --filter-max-coverage
  - id: filter_min_aln_quality
    type:
      - 'null'
      - int
    doc: Ignore alignments with a quality below this value. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --filter-min-aln-quality
  - id: fragment_default_orientation
    type:
      - 'null'
      - string
    doc: Default orientation. One of F+, F-, R+, and R-.
    inputBinding:
      position: 101
      prefix: --fragment-default-orientation
  - id: fragment_size_factor
    type:
      - 'null'
      - float
    doc: Factor to multiple fragment size stddev with to get allowed error. In range
      [0..inf].
    inputBinding:
      position: 101
      prefix: --fragment-size-factor
  - id: fragment_size_median
    type:
      - 'null'
      - int
    doc: Median fragment size. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --fragment-size-median
  - id: fragment_size_std_dev
    type:
      - 'null'
      - int
    doc: Fragment size standard deviation. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --fragment-size-std-dev
  - id: input_mapping
    type: File
    doc: 'SAM/BAM file to use as the input. Valid filetypes are: sam and bam.'
    inputBinding:
      position: 101
      prefix: --input-mapping
  - id: input_reference
    type: File
    doc: 'FASTA file with the reference. Valid filetypes are: fasta and fa.'
    inputBinding:
      position: 101
      prefix: --input-reference
  - id: max_alignment_length
    type:
      - 'null'
      - int
    doc: Maximal alignment length. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --max-alignment-length
  - id: oea_cluster_selection
    type:
      - 'null'
      - string
    doc: Algorithm for OEA cluster selection. One of chaining and set_cover.
    inputBinding:
      position: 101
      prefix: --oea-cluster-selection
  - id: oea_min_support
    type:
      - 'null'
      - int
    doc: Smallest number of EOA reads to support an insertion. In range [1..inf].
    inputBinding:
      position: 101
      prefix: --oea-min-support
  - id: oea_min_support_each_side
    type:
      - 'null'
      - int
    doc: Smallest number of EOA reads on each side to support an insertion. In range
      [1..inf].
    inputBinding:
      position: 101
      prefix: --oea-min-support-each-side
  - id: out_individual_name
    type:
      - 'null'
      - string
    doc: The name of the individual in the output.
    inputBinding:
      position: 101
      prefix: --out-individual-name
  - id: out_variation_type
    type:
      - 'null'
      - string
    doc: The types of variants to write out. One of insertion.
    inputBinding:
      position: 101
      prefix: --out-variation-type
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only print on errors.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: realignment_num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for the realignment. In range [1..inf].
    inputBinding:
      position: 101
      prefix: --realignment-num-threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Higher verbosity.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Highest verbosity.
    inputBinding:
      position: 101
      prefix: --very-verbose
outputs:
  - id: out_vcf
    type: File
    doc: 'VCF file to write variations to. Use "-" for stdout. Valid filetype is:
      vcf.'
    outputBinding:
      glob: $(inputs.out_vcf)
  - id: output_debug_dir
    type:
      - 'null'
      - Directory
    doc: Directory for debug output files. Created if required.
    outputBinding:
      glob: $(inputs.output_debug_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anise_basil:1.2.0--py312hdcc493e_9
