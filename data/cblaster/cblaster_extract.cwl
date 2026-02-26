cwlVersion: v1.2
class: CommandLineTool
baseCommand: cblaster extract
label: cblaster_extract
doc: "Extract information from session files\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: session
    type: File
    doc: cblaster session file
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Sequence description delimiter
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: extract_sequences
    type:
      - 'null'
      - boolean
    doc: Extract sequences, in FASTA format, for each extracted record
    inputBinding:
      position: 102
      prefix: --extract_sequences
  - id: name_only
    type:
      - 'null'
      - boolean
    doc: Do not save sequence descriptions (i.e. no genomic coordinates)
    inputBinding:
      position: 102
      prefix: --name_only
  - id: organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: Organism names, accepts regular expressions
    inputBinding:
      position: 102
      prefix: --organisms
  - id: queries
    type:
      - 'null'
      - type: array
        items: string
    doc: IDs of query sequences
    inputBinding:
      position: 102
      prefix: --queries
  - id: scaffolds
    type:
      - 'null'
      - type: array
        items: string
    doc: Scaffold names/ranges, in the form scaffold_name:start-stop
    inputBinding:
      position: 102
      prefix: --scaffolds
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
