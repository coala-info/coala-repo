cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - lo
label: ska2_lo
doc: "Finds 'left out' SNPs and INDELs using a graph\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: input_skf
    type: File
    doc: 'input SKA2 file'
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: 'prefix of output files'
    inputBinding:
      position: 2
  - id: reference
    type:
      - 'null'
      - File
    doc: 'reference genome for SNP positioning'
    inputBinding:
      position: 101
      prefix: --reference
  - id: missing
    type:
      - 'null'
      - float
    doc: 'maximum fraction of missing data [default: 0.1]'
    inputBinding:
      position: 101
      prefix: --missing
  - id: depth
    type:
      - 'null'
      - int
    doc: 'maximum depth of recursive paths [default: 4]'
    inputBinding:
      position: 101
      prefix: --depth
  - id: indel_kmers
    type:
      - 'null'
      - int
    doc: 'maximum number of internal indel k-mers [default: 2]'
    inputBinding:
      position: 101
      prefix: --indel-kmers
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: 'Output files written with the given prefix'
    outputBinding:
      glob: '$(inputs.output_prefix)*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
