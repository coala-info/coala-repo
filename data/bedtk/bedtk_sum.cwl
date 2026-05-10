cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedtk_sum
label: bedtk_sum
doc: "Sum the lengths of intervals in a BED file.\n\nTool homepage: https://github.com/lh3/bedtk"
inputs:
  - id: input_bed_file
    type: File
    doc: Input BED file.
    inputBinding:
      position: 1
  - id: column
    type:
      - 'null'
      - int
    doc: The column to use for interval lengths. Defaults to column 3 (end - 
      start).
    inputBinding:
      position: 102
      prefix: --column
  - id: ignore_strand
    type:
      - 'null'
      - boolean
    doc: Ignore strand information in the BED file.
    inputBinding:
      position: 102
      prefix: --ignore-strand
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write the sum to. If not specified, prints to stdout.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtk:1.2--h9990f68_0
