cwlVersion: v1.2
class: CommandLineTool
baseCommand: gappa
label: gappa
doc: "The provided text does not contain help information for the tool 'gappa'. It
  contains error logs related to a container environment (Apptainer/Singularity) failing
  to pull or build the image due to lack of disk space.\n\nTool homepage: https://github.com/lczech/gappa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
stdout: gappa.out
