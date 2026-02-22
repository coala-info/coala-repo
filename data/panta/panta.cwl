cwlVersion: v1.2
class: CommandLineTool
baseCommand: panta
label: panta
doc: "A fast and flexible pangenome analysis tool. (Note: The provided text contains
  system error messages regarding disk space and container execution rather than CLI
  help documentation; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/amromics/panta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panta:1.0.1--pyhdfd78af_0
stdout: panta.out
