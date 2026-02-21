cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi
label: odgi
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'odgi'.\n\n
  Tool homepage: https://github.com/vgteam/odgi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi.out
