cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtdbg2
label: wtdbg_wtdbg2
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch the tool's image.\n\nTool homepage: https://github.com/ruanjue/wtdbg-1.2.8"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtdbg:2.5--h577a1d6_6
stdout: wtdbg_wtdbg2.out
