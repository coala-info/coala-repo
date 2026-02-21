cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeTagDirectory
label: homer_makeTagDirectory
doc: "The provided text does not contain help information or usage instructions. It
  is an error log indicating a fatal failure during a container build process (no
  space left on device).\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_makeTagDirectory.out
