cwlVersion: v1.2
class: CommandLineTool
baseCommand: bctools
label: bctools
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/dmaticzka/bctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
stdout: bctools.out
