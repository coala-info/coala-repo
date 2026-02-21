cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbcommand
label: pbcommand
doc: "The provided text does not contain help information for the tool. It consists
  of container execution logs and a fatal error indicating that the executable 'pbcommand'
  was not found in the system PATH.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbcommand:2.1.1--py_2
stdout: pbcommand.out
