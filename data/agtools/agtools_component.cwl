cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agtools
  - component
label: agtools_component
doc: "Extract a component containing a given segment\n\nTool homepage: https://github.com/Vini2/agtools"
inputs:
  - id: graph
    type: File
    doc: path(s) to the assembly graph file(s)
    inputBinding:
      position: 101
      prefix: --graph
  - id: segment
    type: string
    doc: segment ID
    inputBinding:
      position: 101
      prefix: --segment
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
