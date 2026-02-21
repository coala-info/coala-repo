cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtb
label: xtb
doc: "The provided text is a container engine (Apptainer/Singularity) error log and
  does not contain CLI help information or usage instructions for the xtb tool.\n\n
  Tool homepage: https://github.com/grimme-lab/xtb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtb:6.6.1
stdout: xtb.out
