cwlVersion: v1.2
class: CommandLineTool
baseCommand: ima3
label: ima3
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or argument definitions for the ima3
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/jodyhey/IMa3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ima3:1.13--h503566f_2
stdout: ima3.out
