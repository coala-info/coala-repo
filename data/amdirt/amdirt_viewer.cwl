cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amdirt
  - viewer
label: amdirt_viewer
doc: "A tool to view the AMDIRT Streamlit app.\n\nTool homepage: https://github.com/SPAAM-community/AMDirT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
stdout: amdirt_viewer.out
