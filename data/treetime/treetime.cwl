cwlVersion: v1.2
class: CommandLineTool
baseCommand: treetime
label: treetime
doc: "Maximum-likelihood phylodynamic analysis\n\nTool homepage: https://github.com/neherlab/treetime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
stdout: treetime.out
