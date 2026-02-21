cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobster
label: mobster
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the 'mobster' tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/jyhehir/mobster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mobster:0.2.4.1--1
stdout: mobster.out
