cwlVersion: v1.2
class: CommandLineTool
baseCommand: tofasta
label: seqfu_tofasta
doc: "Convert various sequence formats to FASTA format.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files in various sequence formats
    inputBinding:
      position: 1
  - id: replace_iupac
    type:
      - 'null'
      - boolean
    doc: Replace non-IUPAC characters with 'N'
    inputBinding:
      position: 102
      prefix: --replace-iupac
  - id: to_lowercase
    type:
      - 'null'
      - boolean
    doc: Convert sequences to lowercase
    inputBinding:
      position: 102
      prefix: --to-lowercase
  - id: to_uppercase
    type:
      - 'null'
      - boolean
    doc: Convert sequences to uppercase
    inputBinding:
      position: 102
      prefix: --to-uppercase
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print progress information to stderr
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Write output to FILE (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
