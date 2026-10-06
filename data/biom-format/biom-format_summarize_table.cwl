cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - summarize-table
label: biom-format_summarize_table
doc: "Summarize sample or observation data in a BIOM table.\n\nTool homepage: http://www.biom-format.org"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_fp
    type: File
    doc: The input BIOM table
    inputBinding:
      position: 101
      prefix: --input-fp
  - id: output_fp
    type:
      - 'null'
      - string
    doc: An output file-path
    inputBinding:
      position: 101
      prefix: --output-fp
  - id: qualitative
    type:
      - 'null'
      - boolean
    doc: Present counts as number of unique observation ids per sample, rather than counts
      of observations per sample.
    inputBinding:
      position: 101
      prefix: --qualitative
  - id: observations
    type:
      - 'null'
      - boolean
    doc: Summarize over observations
    inputBinding:
      position: 101
      prefix: --observations
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Summary file, when output_fp is given
    outputBinding:
      glob: '$(inputs.output_fp ? inputs.output_fp : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
stdout: biom-format_summarize_table.out
