cwlVersion: v1.2
class: CommandLineTool
baseCommand: pb-assembly
label: pb-assembly
doc: "The provided text does not contain help information or a description of the
  tool; it contains container execution logs and a fatal error indicating the executable
  was not found.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pb-assembly:0.0.8--0
stdout: pb-assembly.out
