cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec_check
label: seqspec_check
doc: "Validate seqspec file against the specification schema.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
  - id: skip
    type:
      - 'null'
      - type: array
        items: string
    doc: Skip checks
    inputBinding:
      position: 102
      prefix: --skip
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
