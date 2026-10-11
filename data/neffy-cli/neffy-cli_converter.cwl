cwlVersion: v1.2
class: CommandLineTool
baseCommand: [converter]
label: neffy-cli_converter
doc: "This program converts the format of an input Multiple Sequence Alignment (MSA)
  file to that of an output MSA file. It supports various formats and can validate
  sequences against a specified alphabet.\n\nTool homepage: https://maryam-haghani.github.io/NEFFy"
inputs:
  - id: in_file
    type: File
    doc: Path to the input MSA file.
    inputBinding:
      position: 101
      prefix: --in_file=
      separate: false
  - id: out_file_path
    type: string
    doc: Path to the output MSA file.
    inputBinding:
      position: 102
      prefix: --out_file=
      separate: false
  - id: in_format
    type: ['null', string]
    doc: "Format of the input file. If not provided, the format is inferred from the file extension."
    inputBinding:
      position: 103
      prefix: "--in_format="
      separate: false
  - id: out_format
    type: ['null', string]
    doc: "Format of the output file. If not provided, the format is inferred from the file extension."
    inputBinding:
      position: 104
      prefix: "--out_format="
      separate: false
  - id: alphabet
    type: ['null', int]
    doc: "Alphabet for the sequences: 0 Protein (default), 1 RNA, 2 DNA."
    inputBinding:
      position: 105
      prefix: "--alphabet="
      separate: false
  - id: check_validation
    type: ['null', boolean]
    doc: "If true, validates that sequences contain only letters from the specified alphabet (tool default true)."
    inputBinding:
      position: 106
      prefix: "--check_validation="
      separate: false
      valueFrom: '$(self ? "true" : "false")'
outputs:
  - id: out_file
    type: File
    doc: Path to the output MSA file.
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy-cli:0.1.1--h9948957_0
