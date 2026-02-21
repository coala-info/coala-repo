cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkm2
label: checkm2
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain the help text or usage information for the checkm2 tool.\n\n
  Tool homepage: https://github.com/chklovski/CheckM2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm2:1.1.0--pyh7e72e81_1
stdout: checkm2.out
