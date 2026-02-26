cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomepy_annotation
label: genomepy_annotation
doc: "Quickly inspect the metadata of each GTF annotation available for the given
  genome.\n\nTool homepage: https://github.com/vanheeringen-lab/genomepy"
inputs:
  - id: name
    type: string
    doc: The name of the genome to inspect annotations for.
    inputBinding:
      position: 1
  - id: lines
    type:
      - 'null'
      - int
    doc: Number of lines to print.
    inputBinding:
      position: 102
      prefix: --lines
  - id: provider
    type:
      - 'null'
      - string
    doc: Only search this provider.
    inputBinding:
      position: 102
      prefix: --provider
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
stdout: genomepy_annotation.out
