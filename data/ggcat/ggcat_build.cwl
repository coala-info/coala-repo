cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ggcat
  - build
label: ggcat_build
doc: "Builds a k-mer graph from input files.\n\nTool homepage: https://github.com/algbio/ggcat"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: The input files
    inputBinding:
      position: 1
  - id: buckets_count_log
    type:
      - 'null'
      - int
    doc: The log2 of the number of buckets
    inputBinding:
      position: 102
      prefix: --buckets-count-log
  - id: colored_input_lists
    type:
      - 'null'
      - type: array
        items: string
    doc: The lists of input files with colors in format 
      <COLOR_NAME><TAB><FILE_PATH>
    inputBinding:
      position: 102
      prefix: --colored-input-lists
  - id: colors
    type:
      - 'null'
      - boolean
    doc: Enable colors
    inputBinding:
      position: 102
      prefix: --colors
  - id: disk_optimization_level
    type:
      - 'null'
      - int
    doc: Sets the level of disk optimization (0 disabled)
    inputBinding:
      position: 102
      prefix: --disk-optimization-level
  - id: eulertigs
    type:
      - 'null'
      - boolean
    doc: Generate eulertigs instead of maximal unitigs
    inputBinding:
      position: 102
      prefix: --eulertigs
  - id: fast_eulertigs
    type:
      - 'null'
      - boolean
    doc: Generate eulertigs instead of maximal unitigs, faster version
    inputBinding:
      position: 102
      prefix: --fast-eulertigs
  - id: fast_simplitigs
    type:
      - 'null'
      - boolean
    doc: Generate simplitigs instead of maximal unitigs, faster version
    inputBinding:
      position: 102
      prefix: --fast-simplitigs
  - id: forward_only
    type:
      - 'null'
      - boolean
    doc: Treats reverse complementary kmers as different
    inputBinding:
      position: 102
      prefix: --forward-only
  - id: generate_maximal_unitigs_links
    type:
      - 'null'
      - boolean
    doc: "Generate maximal unitigs connections references, in BCALM2 format\n    \
      \                                        L:<+/->:<other id>:<+/->\n"
    inputBinding:
      position: 102
      prefix: --generate-maximal-unitigs-links
  - id: gfa_v1
    type:
      - 'null'
      - boolean
    doc: Output the graph in GFA format v1
    inputBinding:
      position: 102
      prefix: --gfa-v1
  - id: gfa_v2
    type:
      - 'null'
      - boolean
    doc: Output the graph in GFA format v2
    inputBinding:
      position: 102
      prefix: --gfa-v2
  - id: greedy_matchtigs
    type:
      - 'null'
      - boolean
    doc: Generate greedy matchtigs instead of maximal unitigs
    inputBinding:
      position: 102
      prefix: --greedy-matchtigs
  - id: hash_type
    type:
      - 'null'
      - string
    doc: Hash type used to identify kmers
    inputBinding:
      position: 102
      prefix: --hash-type
  - id: input_lists
    type:
      - 'null'
      - type: array
        items: string
    doc: The lists of input files
    inputBinding:
      position: 102
      prefix: --input-lists
  - id: intermediate_compression_level
    type:
      - 'null'
      - int
    doc: The level of lz4 compression to be used for the intermediate files
    inputBinding:
      position: 102
      prefix: --intermediate-compression-level
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep intermediate temporary files for debugging purposes
    inputBinding:
      position: 102
      prefix: --keep-temp-files
  - id: kmer_length
    type: int
    doc: Specifies the k-mers length
    inputBinding:
      position: 102
      prefix: --kmer-length
  - id: last_step
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --last-step
  - id: memory
    type:
      - 'null'
      - int
    doc: "Maximum suggested memory usage (GB) The tool will try use only up to this
      GB of memory to store temporary\n            files without writing to disk.
      This usage does not include the needed memory for the processing steps. GGCAT\n\
      \            can allocate extra memory for files if the current memory is not
      enough to complete the current operation"
    inputBinding:
      position: 102
      prefix: --memory
  - id: min_multiplicity
    type:
      - 'null'
      - int
    doc: Minimum multiplicity required to keep a kmer
    inputBinding:
      position: 102
      prefix: --min-multiplicity
  - id: minimizer_length
    type:
      - 'null'
      - int
    doc: Overrides the default m-mers (minimizers) length
    inputBinding:
      position: 102
      prefix: --minimizer-length
  - id: output_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: --output-file
  - id: pathtigs
    type:
      - 'null'
      - boolean
    doc: Generate pathtigs instead of maximal unitigs
    inputBinding:
      position: 102
      prefix: --pathtigs
  - id: prefer_memory
    type:
      - 'null'
      - boolean
    doc: Use all the given memory before writing to disk
    inputBinding:
      position: 102
      prefix: --prefer-memory
  - id: step
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --step
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files (default .temp_files)
    inputBinding:
      position: 102
      prefix: --temp-dir
  - id: threads_count
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --threads-count
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
stdout: ggcat_build.out
