cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracy
  - basecall
label: tracy_basecall
doc: "Basecalling of Sanger trace files\n\nTool homepage: https://github.com/gear-genomics/tracy"
inputs:
  - id: trace_file
    type: File
    doc: Input trace file (e.g., trace.ab1)
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: output format [json|tsv|fasta|fastq]
    default: json
    inputBinding:
      position: 102
      prefix: --format
  - id: otype
    type:
      - 'null'
      - string
    doc: fasta/fastq sequence [primary|secondary|consensus]
    default: primary
    inputBinding:
      position: 102
      prefix: --otype
  - id: pratio
    type:
      - 'null'
      - float
    doc: peak ratio to call a base
    default: 0.330000013
    inputBinding:
      position: 102
      prefix: --pratio
  - id: trim
    type:
      - 'null'
      - int
    doc: 'trimming stringency [1:9], 0: use trimLeft and trimRight'
    default: 0
    inputBinding:
      position: 102
      prefix: --trim
  - id: trim_left
    type:
      - 'null'
      - int
    doc: trim size left
    default: 0
    inputBinding:
      position: 102
      prefix: --trimLeft
  - id: trim_right
    type:
      - 'null'
      - int
    doc: trim size right
    default: 0
    inputBinding:
      position: 102
      prefix: --trimRight
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: basecalling output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
