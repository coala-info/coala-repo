cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcxdump
label: mcl_mcxdump
doc: "The provided text contains system error messages related to a container runtime
  (Apptainer/Singularity) and does not contain the help documentation for mcxdump.
  No arguments could be parsed.\n\nTool homepage: https://micans.org/mcl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcl:22.282--pl5321h7b50bb2_4
stdout: mcl_mcxdump.out
