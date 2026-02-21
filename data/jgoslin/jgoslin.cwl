cwlVersion: v1.2
class: CommandLineTool
baseCommand: jgoslin
label: jgoslin
doc: "The provided text is an error log indicating a failure to build or run the container
  image (no space left on device) and does not contain help information or command-line
  arguments for the tool.\n\nTool homepage: https://github.com/lifs-tools/jgoslin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jgoslin:2.2.0--hdfd78af_0
stdout: jgoslin.out
