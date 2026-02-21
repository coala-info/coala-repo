cwlVersion: v1.2
class: CommandLineTool
baseCommand: lirtmats
label: lirtmats
doc: "Long-read Isoform Reconstruction and rMATS-based differential splicing analysis.
  (Note: The provided text contains system error messages regarding container execution
  and does not include the tool's help documentation or argument list.)\n\nTool homepage:
  https://pypi.org/project/lirtmats/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lirtmats:1.0.0--pyhdfd78af_0
stdout: lirtmats.out
