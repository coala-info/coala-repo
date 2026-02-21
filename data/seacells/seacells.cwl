cwlVersion: v1.2
class: CommandLineTool
baseCommand: seacells
label: seacells
doc: "SEACells is an algorithm for computing metacells from single-cell data. (Note:
  The provided text is an error log and does not contain usage information or argument
  definitions.)\n\nTool homepage: https://github.com/dpeerlab/SEACells"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seacells:0.3.3--pyhdfd78af_0
stdout: seacells.out
