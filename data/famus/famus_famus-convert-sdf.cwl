cwlVersion: v1.2
class: CommandLineTool
baseCommand: famus-convert-sdf
label: famus_famus-convert-sdf
doc: "A tool for converting SDF files. (Note: The provided text contains system error
  logs rather than help documentation, so no arguments could be extracted.)\n\nTool
  homepage: https://github.com/burstein-lab/famus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
stdout: famus_famus-convert-sdf.out
