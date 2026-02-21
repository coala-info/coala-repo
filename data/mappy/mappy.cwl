cwlVersion: v1.2
class: CommandLineTool
baseCommand: mappy
label: mappy
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'mappy'.\n\n
  Tool homepage: https://github.com/lh3/minimap2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mappy:2.30--py39h0699b22_0
stdout: mappy.out
