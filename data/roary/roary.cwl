cwlVersion: v1.2
class: CommandLineTool
baseCommand: roary
label: roary
doc: "The provided text contains error logs from a container runtime (Singularity/Apptainer)
  and does not contain the help text for the tool 'roary'. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/sanger-pathogens/Roary"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/roary:3.13.0--pl526h516909a_0
stdout: roary.out
