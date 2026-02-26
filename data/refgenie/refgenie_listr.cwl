cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie_listr
label: refgenie_listr
doc: "Remote refgenie assets\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: genome
    type: string
    doc: Specify a genome to view its assets in detail
    inputBinding:
      position: 101
      prefix: -g
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_listr.out
