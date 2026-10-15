cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_easy_lastz
label: phyluce_phyluce_probe_easy_lastz
doc: "Run lastz in an easy way\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: target
    type: File
    doc: The path to the target file (2bit/fasta)
    inputBinding:
      prefix: --target
  - id: query
    type: File
    doc: The path to the query file (2bit/fasta)
    inputBinding:
      prefix: --query
  - id: output_path
    type: string
    doc: The path to the output file
    inputBinding:
      prefix: --output
  - id: identity
    type:
      - 'null'
      - float
    doc: The minimum percent identity to require for a match
    inputBinding:
      prefix: --identity
  - id: coverage
    type:
      - 'null'
      - float
    doc: The minimum coverage (%) required for a match
    inputBinding:
      prefix: --coverage
  - id: min_match
    type:
      - 'null'
      - int
    doc: The minimum number of base pairs required for a match
    inputBinding:
      prefix: --min_match
outputs:
  - id: output
    type: File
    doc: The lastz alignment file.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
