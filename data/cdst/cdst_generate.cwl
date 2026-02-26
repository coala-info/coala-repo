cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdst_generate
label: cdst_generate
doc: "Generate CDS files\n\nTool homepage: https://github.com/l1-mh/CDST"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Input CDS FASTA files
    inputBinding:
      position: 101
      prefix: --input
  - id: min_cds_len
    type:
      - 'null'
      - int
    doc: Minimum CDS length
    inputBinding:
      position: 101
      prefix: --min-cds-len
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0
