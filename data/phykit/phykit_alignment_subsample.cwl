cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - alignment_subsample
label: phykit_alignment_subsample
doc: Randomly subsample genes, partitions, or sites from phylogenomic datasets.
inputs:
  - id: mode
    type: string
    doc: 'subsampling mode: genes, partitions, or sites'
    inputBinding:
      position: 101
      prefix: --mode
  - id: alignment
    type: File
    doc: alignment file (FASTA). Required for partitions and sites modes.
    inputBinding:
      position: 101
      prefix: --alignment
  - id: list
    type:
      - 'null'
      - File
    doc: file listing alignment paths (one per line). Required for genes mode.
    inputBinding:
      position: 101
      prefix: --list
  - id: partition
    type:
      - 'null'
      - File
    doc: RAxML-style partition file. Required for partitions mode.
    inputBinding:
      position: 101
      prefix: --partition
  - id: number
    type:
      - 'null'
      - int
    doc: exact number of items to select
    inputBinding:
      position: 101
      prefix: --number
  - id: fraction
    type:
      - 'null'
      - float
    doc: fraction of items to select (0.0 to 1.0)
    inputBinding:
      position: 101
      prefix: --fraction
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: sample with replacement
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: output
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File[]
    doc: output file prefix
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
