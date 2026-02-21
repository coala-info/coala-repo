cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotsr
label: plotsr
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain the help text or usage information for the tool 'plotsr'. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/schneebergerlab/plotsr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plotsr:1.1.1--pyh7cba7a3_0
stdout: plotsr.out
