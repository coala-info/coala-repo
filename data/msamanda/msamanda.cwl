cwlVersion: v1.2
class: CommandLineTool
baseCommand: msamanda
label: msamanda
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the msamanda tool. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/hgb-bin-proteomics/MSAmanda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/msamanda:v1.0.0.5242_cv4
stdout: msamanda.out
