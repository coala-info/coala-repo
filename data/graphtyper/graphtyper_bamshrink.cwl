cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphtyper
label: graphtyper_bamshrink
doc: "GraphTyper\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: bam_path_in
    type: File
    doc: Input BAM file path.
    inputBinding:
      position: 1
  - id: avg_cov_by_readlen
    type:
      - 'null'
      - float
    doc: Average coverage divided by read length.
    default: 0.3
    inputBinding:
      position: 102
      prefix: --avg-cov-by-readlen
  - id: index
    type:
      - 'null'
      - File
    doc: Input BAM bai/CRAM crai index file.
    default: <bamPathIn>.[bai,crai]
    inputBinding:
      position: 102
      prefix: --index
  - id: interval
    type:
      - 'null'
      - string
    doc: Interval/region to filter on in format chrA:N-M, where chrA is the 
      contig name, N is the begin position, and M is the end position of the 
      interval.
    inputBinding:
      position: 102
      prefix: --interval
  - id: interval_file
    type:
      - 'null'
      - File
    doc: File with interval(s)/region(s) to filter on.
    inputBinding:
      position: 102
      prefix: --interval-file
  - id: log_file
    type:
      - 'null'
      - string
    doc: Set path to log file.
    inputBinding:
      position: 102
      prefix: --log
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: Maximum fragment length allowed.
    default: 1000
    inputBinding:
      position: 102
      prefix: --max-fragment-length
  - id: min_num_matching
    type:
      - 'null'
      - int
    doc: Minumum number of matching bases in read.
    default: 55
    inputBinding:
      position: 102
      prefix: --min-num-matching
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 102
      prefix: --vverbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BAM file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
