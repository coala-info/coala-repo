cwlVersion: v1.2
class: CommandLineTool
baseCommand: ezcharts
label: ezcharts
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the ezcharts
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/epi2me-labs/ezcharts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezcharts:0.15.2--pyhdfd78af_0
stdout: ezcharts.out
