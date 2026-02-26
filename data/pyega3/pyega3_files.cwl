cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyega3
  - files
label: pyega3_files
doc: "List files in a dataset\n\nTool homepage: https://github.com/EGA-archive/ega-download-client"
inputs:
  - id: identifier
    type: string
    doc: Dataset ID (e.g. EGAD00000000001)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
stdout: pyega3_files.out
