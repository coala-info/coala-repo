cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdst mst
label: cdst_mst
doc: "Compute the Minimum Spanning Tree (MST) of a difference matrix.\n\nTool homepage:
  https://github.com/l1-mh/CDST"
inputs:
  - id: matrix
    type: File
    doc: Input difference matrix CSV
    inputBinding:
      position: 101
      prefix: --matrix
  - id: output_path
    type: string
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0
