cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_interpop_chars.pl
label: stacks_extract_interpop_chars.pl
doc: "Extract inter-population (inter-species) characters from a file of interspecies tags.

Tool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: input_file
    type: File
    doc: "input file containing interspecies tags"
    inputBinding:
      position: 101
      prefix: -f
  - id: barcodes
    type: File
    doc: "list of barcodes to process (one barcode per population)"
    inputBinding:
      position: 101
      prefix: -b
  - id: output_file
    type:
      - 'null'
      - string
    doc: "output file"
    inputBinding:
      position: 101
      prefix: -o
  - id: min_populations
    type:
      - 'null'
      - int
    doc: "minimum number of populations required before recording a marker"
    inputBinding:
      position: 101
      prefix: -p
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "turn on debug output"
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: '${ return inputs.output_file ? inputs.output_file : []; }'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_extract_interpop_chars.pl.out
