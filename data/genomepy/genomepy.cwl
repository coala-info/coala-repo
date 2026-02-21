cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomepy
label: genomepy
doc: "A tool for downloading and managing genomes. (Note: The provided help text contains
  only system error messages and no usage information.)\n\nTool homepage: https://github.com/vanheeringen-lab/genomepy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
stdout: genomepy.out
