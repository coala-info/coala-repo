cwlVersion: v1.2
class: CommandLineTool
baseCommand: gimme
label: gimmemotifs_gimme
doc: "The provided text does not contain help information for the tool, but rather
  a fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs:0.18.1--h9ee0642_0
stdout: gimmemotifs_gimme.out
