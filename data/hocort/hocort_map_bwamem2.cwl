cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hocort
  - map
  - bwamem2
label: hocort_map_bwamem2
doc: "map reads to a BWA-MEM2 index and output mapped/unmapped reads (gz input not supported)\n\nTool homepage: https://github.com/ignasrum/hocort"
inputs:
  - id: index_dir
    type: Directory
    doc: Directory with the index made by the matching hocort index command
  - id: index_name
    type: string
    doc: 'Base name of the index inside the index directory'
    inputBinding:
      position: 101
      prefix: --index
      valueFrom: $(inputs.index_dir.path)/$(inputs.index_name)
  - id: input
    type:
      type: array
      items: File
    doc: 'path to sequence files, max 2'
    inputBinding:
      position: 102
      prefix: --input
  - id: output
    type:
      type: array
      items: string
    doc: 'path to output files, max 2'
    inputBinding:
      position: 103
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: max available on machine)'
    inputBinding:
      position: 103
      prefix: '--threads'
  - id: filter
    type:
      - 'null'
      - string
    doc: 'set to false to output mapped sequences, true to output unmapped sequences (default: true)'
    inputBinding:
      position: 103
      prefix: '--filter'
  - id: config
    type:
      - 'null'
      - string
    doc: 'used to pass along arguments to the aligner, use with caution'
    inputBinding:
      position: 103
      prefix: '--config='
      separate: false
outputs:
  - id: output_fastq
    type:
      type: array
      items: File
    doc: Output fastq files (mapped or unmapped reads)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
