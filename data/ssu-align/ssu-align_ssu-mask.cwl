cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-mask
label: ssu-align_ssu-mask
doc: "The provided text does not contain help information for ssu-mask; it contains
  a fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch or build the OCI image.\n\nTool homepage: http://eddylab.org/software/ssu-align/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
stdout: ssu-align_ssu-mask.out
