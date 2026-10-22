cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - humanise
label: ska_humanise
doc: "Print kmers from a split kmer file in human readable format\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: input_skf
    type: File
    doc: 'Input split kmer file.'
    inputBinding:
      position: 101
      prefix: -i
  - id: tabulated
    type:
      - 'null'
      - boolean
    doc: 'Print tabulated output.'
    inputBinding:
      position: 101
      prefix: -t
  - id: output_prefix
    type:
      - 'null'
      - string
    default: humanised_kmers
    doc: 'Output file prefix. [Default = humanised_kmers]'
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: humanised_files
    type:
      type: array
      items: File
    doc: 'Human readable kmer files'
    outputBinding:
      glob: '$(inputs.output_prefix)*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska:1.0--h077b44d_7
