cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-draw
label: ssu-align_ssu-draw
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the OCI image.\n\nTool homepage: http://eddylab.org/software/ssu-align/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
stdout: ssu-align_ssu-draw.out
