cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntroot
label: ntroot
doc: "A tool for rooting phylogenetic trees (Note: The provided help text contains
  only container execution errors and no usage information).\n\nTool homepage: https://github.com/bcgsc/ntroot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntroot:1.1.6--py313pl5321hdfd78af_0
stdout: ntroot.out
