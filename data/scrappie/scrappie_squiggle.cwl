cwlVersion: v1.2
class: CommandLineTool
baseCommand: squiggle
label: scrappie_squiggle
doc: "Scrappie squiggler\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Input FASTA files
    inputBinding:
      position: 1
  - id: licence
    type:
      - 'null'
      - boolean
    doc: Print licensing information
    inputBinding:
      position: 102
      prefix: --licence
  - id: license
    type:
      - 'null'
      - boolean
    doc: Print licensing information
    inputBinding:
      position: 102
      prefix: --license
  - id: limit
    type:
      - 'null'
      - int
    doc: Maximum number of reads to call (0 is unlimited)
    inputBinding:
      position: 102
      prefix: --limit
  - id: model
    type:
      - 'null'
      - string
    doc: 'Squiggle model to use: "squiggle_r94", "squiggle_r94_rna", "squiggle_r10"'
    inputBinding:
      position: 102
      prefix: --model
  - id: no_rescale
    type:
      - 'null'
      - boolean
    doc: Rescale network output
    inputBinding:
      position: 102
      prefix: --no-rescale
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to append to name of each read
    inputBinding:
      position: 102
      prefix: --prefix
  - id: rescale
    type:
      - 'null'
      - boolean
    doc: Rescale network output
    inputBinding:
      position: 102
      prefix: --rescale
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write to file rather than stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
