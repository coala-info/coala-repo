cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamstats
label: bamstats
doc: "Generate genomic coverage statistics for BAM files\n\nTool homepage: https://github.com/guigolab/bamstats"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: element annotation file
    inputBinding:
      position: 101
      prefix: --annotaion
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of cpus to be used
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu
  - id: input_file
    type: File
    doc: input file
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: logging level
    default: warn
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: max_buf
    type:
      - 'null'
      - int
    doc: maximum number of buffered records
    default: 1000000
    inputBinding:
      position: 101
      prefix: --max-buf
  - id: reads
    type:
      - 'null'
      - int
    doc: number of records to process
    default: -1
    inputBinding:
      position: 101
      prefix: --reads
  - id: uniq
    type:
      - 'null'
      - boolean
    doc: output genomic coverage statistics for uniqely mapped reads too
    inputBinding:
      position: 101
      prefix: --uniq
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamstats:0.3.5--he881be0_0
