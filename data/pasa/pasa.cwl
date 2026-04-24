cwlVersion: v1.2
class: CommandLineTool
baseCommand: pasa
label: pasa
doc: "Perform PASA analysis on input files.\n\nTool homepage: https://pasapipeline.github.io/"
inputs:
  - id: input_file
    type: File
    doc: Input file for PASA analysis
    inputBinding:
      position: 1
  - id: fuzzlength
    type:
      - 'null'
      - int
    doc: bp to discount at alignment termini during pairwise compatibility 
      checks.
    inputBinding:
      position: 102
      prefix: -F
  - id: illustrate_alignments
    type:
      - 'null'
      - boolean
    doc: illustrate incoming alignments only. No assembly performed.
    inputBinding:
      position: 102
      prefix: -a
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pasa:2.5.3--h4ac6f70_0
stdout: pasa.out
