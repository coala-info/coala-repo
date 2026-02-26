cwlVersion: v1.2
class: CommandLineTool
baseCommand: python eKLIPse
label: eklipse_eKLIPse.py
doc: "eKLIPse: a tool for identifying circular DNA breakpoints\n\nTool homepage: https://github.com/dooguypapua/eKLIPse"
inputs:
  - id: blast_cost_to_extend_a_gap
    type:
      - 'null'
      - int
    doc: BLAST cost to extend a gap
    default: 2
    inputBinding:
      position: 101
      prefix: -gapext
  - id: blast_cost_to_open_a_gap
    type:
      - 'null'
      - int
    doc: BLAST cost to open a gap
    default: 0:proton, 5:illumina
    inputBinding:
      position: 101
      prefix: -gapopen
  - id: blast_percent_coverage_threshold
    type:
      - 'null'
      - int
    doc: BLAST %coverage threshold
    default: 70
    inputBinding:
      position: 101
      prefix: -cov
  - id: blast_percent_identity_threshold
    type:
      - 'null'
      - int
    doc: BLAST %identity threshold
    default: 80
    inputBinding:
      position: 101
      prefix: -id
  - id: blastn_bin_path
    type:
      - 'null'
      - string
    doc: BLASTn bin path
    default: $PATH
    inputBinding:
      position: 101
      prefix: -blastn
  - id: breakpoint_blast_shift_length
    type:
      - 'null'
      - int
    doc: Breakpoint BLAST shift length
    default: 5
    inputBinding:
      position: 101
      prefix: -shift
  - id: circos_bin_path
    type:
      - 'null'
      - string
    doc: circos bin path
    default: $PATH
    inputBinding:
      position: 101
      prefix: -circos
  - id: downsampling_reads_number
    type:
      - 'null'
      - int
    doc: Downsampling reads number (0=disable)
    default: 500000
    inputBinding:
      position: 101
      prefix: -downcov
  - id: filter_non_bilateral_blast_deletions
    type:
      - 'null'
      - boolean
    doc: Filter non-bilateral BLAST deletions
    default: true
    inputBinding:
      position: 101
      prefix: -bilateral
  - id: input_file
    type: File
    doc: FILE with Alignment paths
    inputBinding:
      position: 101
      prefix: -in
  - id: makeblastdb_bin_path
    type:
      - 'null'
      - string
    doc: makeblastdb bin path
    default: $PATH
    inputBinding:
      position: 101
      prefix: -makeblastdb
  - id: min_blast_per_breakpoint
    type:
      - 'null'
      - int
    doc: Minimal number of BLAST per breakpoint
    default: 1
    inputBinding:
      position: 101
      prefix: -minblast
  - id: min_mitochondria_size
    type:
      - 'null'
      - int
    doc: Minimal resulting mitochondria size
    default: 1000
    inputBinding:
      position: 101
      prefix: -mitosize
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Disable output colors
    inputBinding:
      position: 101
      prefix: --nocolor
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory path
    default: current
    inputBinding:
      position: 101
      prefix: -out
  - id: read_length_threshold
    type:
      - 'null'
      - int
    doc: Read length threshold
    default: 100
    inputBinding:
      position: 101
      prefix: -minlen
  - id: read_quality_threshold
    type:
      - 'null'
      - int
    doc: Read quality threshold
    default: 20
    inputBinding:
      position: 101
      prefix: -minq
  - id: reference_gbk
    type: File
    doc: GBK reference
    inputBinding:
      position: 101
      prefix: -ref
  - id: samtools_bin_path
    type:
      - 'null'
      - string
    doc: samtools bin path
    default: $PATH
    inputBinding:
      position: 101
      prefix: -samtools
  - id: soft_clipping_min_length
    type:
      - 'null'
      - int
    doc: Soft-clipping minimal length
    default: 25
    inputBinding:
      position: 101
      prefix: -scsize
  - id: test
    type:
      - 'null'
      - boolean
    doc: eKLIPse test
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of thread to use
    default: 2
    inputBinding:
      position: 101
      prefix: -thread
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory path
    default: /tmp
    inputBinding:
      position: 101
      prefix: -tmp
  - id: upstream_mapping_length
    type:
      - 'null'
      - int
    doc: Upstream mapping length
    default: 20
    inputBinding:
      position: 101
      prefix: -mapsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eklipse:1.8--hdfd78af_2
stdout: eklipse_eKLIPse.py.out
