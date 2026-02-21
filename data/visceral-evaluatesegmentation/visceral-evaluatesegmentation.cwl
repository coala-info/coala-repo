cwlVersion: v1.2
class: CommandLineTool
baseCommand: visceral-evaluatesegmentation
label: visceral-evaluatesegmentation
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/Visceral-Project/EvaluateSegmentation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/visceral-evaluatesegmentation:2021.03.25--h287ed61_0
stdout: visceral-evaluatesegmentation.out
