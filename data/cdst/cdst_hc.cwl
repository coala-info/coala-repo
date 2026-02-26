cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdst hc
label: cdst_hc
doc: "Performs hierarchical clustering on a difference matrix.\n\nTool homepage: https://github.com/l1-mh/CDST"
inputs:
  - id: matrix
    type: File
    doc: Input difference matrix CSV
    inputBinding:
      position: 101
      prefix: --matrix
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0
