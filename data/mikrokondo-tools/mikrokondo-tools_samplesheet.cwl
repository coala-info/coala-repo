cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikrokondo-tools
  - samplesheet
label: mikrokondo-tools_samplesheet
doc: "Generate a sample sheet for mikrokondo from a directory of FASTQ or FASTA files.\n\nTool homepage:\
  \ https://pypi.org/project/mikrokondo-tools"
inputs:
  - id: output_sheet
    type: string
    doc: The file to write your created output sheet to.
    inputBinding:
      position: 101
      prefix: --output-sheet
  - id: read_1_suffix
    type:
      - 'null'
      - string
    doc: A suffix to identify read 1 (default _R1_).
    inputBinding:
      position: 101
      prefix: --read-1-suffix
  - id: read_2_suffix
    type:
      - 'null'
      - string
    doc: A suffix to identify read 2 (default _R2_).
    inputBinding:
      position: 101
      prefix: --read-2-suffix
  - id: schema_input
    type:
      - 'null'
      - File
    doc: An optional schema_input.json file pre-downloaded for mikrokondo.
    inputBinding:
      position: 101
      prefix: --schema-input
  - id: input_directory
    type: Directory
    doc: Directory of input FASTQ/FASTA files.
    inputBinding:
      position: 201
outputs:
  - id: sheet
    type: File
    doc: Sample sheet (CSV).
    outputBinding:
      glob: $(inputs.output_sheet)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikrokondo-tools:0.0.1rc0--pyhdfd78af_0
