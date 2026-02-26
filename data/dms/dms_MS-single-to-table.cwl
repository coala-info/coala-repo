cwlVersion: v1.2
class: CommandLineTool
baseCommand: dms_MS-single-to-table
label: dms_MS-single-to-table
doc: "Converts MS-single output to a table format.\n\nTool homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms"
inputs:
  - id: input_file
    type: File
    doc: Path to the MS-single output file.
    inputBinding:
      position: 1
  - id: include_modified
    type:
      - 'null'
      - boolean
    doc: Include modified peptides in the output table.
    inputBinding:
      position: 102
      prefix: --include-modified
  - id: include_unmodified
    type:
      - 'null'
      - boolean
    doc: Include unmodified peptides in the output table.
    inputBinding:
      position: 102
      prefix: --include-unmodified
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum peptide length to include in the output table. Default is 50.
    default: 50
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum peptide length to include in the output table. Default is 5.
    default: 5
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum score to include a peptide in the output table. Default is 0.0.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --min-score
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Path to the output table file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
