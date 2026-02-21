cwlVersion: v1.2
class: CommandLineTool
baseCommand: tapestry
label: tapestry
doc: "Tapestry is a tool for genomic visualization and assembly evaluation. (Note:
  The provided text appears to be a container build log rather than CLI help text;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/johnomics/tapestry"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tapestry:1.0.1--pyhdfd78af_0
stdout: tapestry.out
