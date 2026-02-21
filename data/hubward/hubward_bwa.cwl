cwlVersion: v1.2
class: CommandLineTool
baseCommand: hubward_bwa
label: hubward_bwa
doc: "The provided text contains system error messages related to a container environment
  (Apptainer/Singularity) and does not contain help documentation for the tool 'hubward_bwa'.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/lh3/bwa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward:0.2.2--py27_1
stdout: hubward_bwa.out
