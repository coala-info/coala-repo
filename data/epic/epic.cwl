cwlVersion: v1.2
class: CommandLineTool
baseCommand: epic
label: epic
doc: "Diffuse domain caller for ChIP-seq data (Note: The provided text contains only
  container execution errors and no usage information; arguments could not be extracted
  from the input).\n\nTool homepage: http://github.com/endrebak/epic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epic:0.2.12--py27h24bf2e0_0
stdout: epic.out
