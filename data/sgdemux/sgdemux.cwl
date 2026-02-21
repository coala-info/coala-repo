cwlVersion: v1.2
class: CommandLineTool
baseCommand: sgdemux
label: sgdemux
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'sgdemux'.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/Singular-Genomics/singular-demux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sgdemux:1.2.0--h3ab6199_4
stdout: sgdemux.out
