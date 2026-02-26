cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy_merge_star_count
label: iobrpy_merge_star_count
doc: "Merge STAR counts from multiple samples.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: path
    type: Directory
    doc: Folder containing STAR outputs
    inputBinding:
      position: 101
      prefix: --path
  - id: project
    type: string
    doc: Output name prefix
    inputBinding:
      position: 101
      prefix: --project
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
stdout: iobrpy_merge_star_count.out
