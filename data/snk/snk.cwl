cwlVersion: v1.2
class: CommandLineTool
baseCommand: snk
label: snk
doc: "The provided text appears to be an error log from a container execution (Apptainer/Singularity)
  rather than help text. As a result, no arguments or usage information could be extracted.\n
  \nTool homepage: https://snk.wytamma.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
stdout: snk.out
