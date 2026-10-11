cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - /usr/local/lib/python3.11/site-packages/neffy/bin/converter
label: neffy_converter
doc: "MSA Converter Tool. Converts the format of an input multiple sequence alignment\
  \ (MSA) file to that of an output MSA file; supports various formats and can validate\
  \ sequences against a specified alphabet.\n\nTool homepage: https://github.com/Maryam-Haghani/NEFFy"
inputs:
  - id: in_file
    type: File
    doc: Path to the input MSA file.
    inputBinding:
      position: 1
      prefix: --in_file=
      separate: false
  - id: out_file
    type: string
    doc: Path to the output MSA file.
    inputBinding:
      position: 2
      prefix: --out_file=
      separate: false
  - id: in_format
    type:
      - 'null'
      - string
    doc: Format of the input file; inferred from the file extension if absent.
    inputBinding:
      position: 10
      prefix: --in_format=
      separate: false
  - id: out_format
    type:
      - 'null'
      - string
    doc: Format of the output file; inferred from the file extension if absent.
    inputBinding:
      position: 10
      prefix: --out_format=
      separate: false
  - id: alphabet
    type:
      - 'null'
      - int
    doc: 'Alphabet for the sequences: 0 Protein (default), 1 RNA, 2 DNA.'
    inputBinding:
      position: 10
      prefix: --alphabet=
      separate: false
  - id: check_validation
    type:
      - 'null'
      - boolean
    doc: If true, validates the sequences to ensure they contain only letters from
      the specified alphabet (default true).
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: converted_msa
    type: File
    doc: The converted MSA file
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 10
    valueFrom: '${ return (inputs.check_validation === null || inputs.check_validation
      === undefined) ? [] : ["--check_validation=" + inputs.check_validation]; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy:0.1.1--py311he264feb_1
stdout: neffy_converter.out
