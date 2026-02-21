cwlVersion: v1.2
class: CommandLineTool
baseCommand: srf-n-trf
label: srf-n-trf
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions for the tool 'srf-n-trf'.\n
  \nTool homepage: https://github.com/koisland/srf-n-trf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srf-n-trf:0.1.2--h4349ce8_0
stdout: srf-n-trf.out
