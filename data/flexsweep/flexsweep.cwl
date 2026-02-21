cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexsweep
label: flexsweep
doc: "A tool for detecting selective sweeps. (Note: The provided text is a container
  execution error log and does not contain the tool's help documentation or usage
  instructions.)\n\nTool homepage: https://github.com/jmurga/flexsweep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexsweep:1.3--pyhdfd78af_0
stdout: flexsweep.out
