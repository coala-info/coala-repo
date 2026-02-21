cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dms
  - MS-comp-taxa
label: dms_MS-comp-taxa
doc: "The provided text contains system error messages related to container image
  conversion and disk space issues rather than the tool's help documentation. Consequently,
  no functional description or arguments could be extracted.\n\nTool homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
stdout: dms_MS-comp-taxa.out
