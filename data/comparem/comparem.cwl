cwlVersion: v1.2
class: CommandLineTool
baseCommand: comparem
label: comparem
doc: "Compare sequences in multiple FASTA files.\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA files to compare.
    inputBinding:
      position: 1
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum sequence identity threshold (0.0 to 1.0).
    inputBinding:
      position: 102
      prefix: --min-identity
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length to consider for comparison.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for comparison.
    inputBinding:
      position: 102
      prefix: --threads
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
    type:
      - 'null'
      - File
    doc: Output file to write the comparison results to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
