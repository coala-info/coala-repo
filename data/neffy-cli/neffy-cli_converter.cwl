cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./converter
label: neffy-cli_converter
doc: "This program converts the format of an input Multiple Sequence Alignment (MSA)
  file\nto that of an output MSA file. It supports various formats and can validate
  sequences\nagainst a specified alphabet.\n\nTool homepage: https://maryam-haghani.github.io/NEFFy"
inputs:
  - id: alphabet
    type:
      - 'null'
      - int
    doc: "Specifies the alphabet for the sequences:\n        0 : Protein (default)\n\
      \        1 : RNA\n        2 : DNA"
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: check_validation
    type:
      - 'null'
      - boolean
    doc: If true, validates the sequences to ensure they contain only letters 
      from the specified alphabet.
    inputBinding:
      position: 101
      prefix: --check_validation
  - id: in_file
    type: File
    doc: Path to the input MSA file.
    inputBinding:
      position: 101
      prefix: --in_file
  - id: in_format
    type:
      - 'null'
      - string
    doc: Format of the input file. If not provided, the format is inferred from 
      the file extension.
    inputBinding:
      position: 101
      prefix: --in_format
  - id: out_format
    type:
      - 'null'
      - string
    doc: Format of the output file. If not provided, the format is inferred from
      the file extension.
    inputBinding:
      position: 101
      prefix: --out_format
outputs:
  - id: out_file
    type: File
    doc: Path to the output MSA file.
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy-cli:0.1.1--h9948957_0
