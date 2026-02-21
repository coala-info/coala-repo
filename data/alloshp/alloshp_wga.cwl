cwlVersion: v1.2
class: CommandLineTool
baseCommand: alloshp_wga
label: alloshp_wga
doc: "The provided text appears to be a system error log from a container runtime
  (Apptainer/Singularity) rather than CLI help text. No tool-specific arguments or
  descriptions could be extracted.\n\nTool homepage: https://github.com/eead-csic-compbio/AlloSHP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0
stdout: alloshp_wga.out
