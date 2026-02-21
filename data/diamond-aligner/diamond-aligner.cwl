cwlVersion: v1.2
class: CommandLineTool
baseCommand: diamond
label: diamond-aligner
doc: "The provided text does not contain help information for diamond-aligner; it
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing due to insufficient disk space.\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/diamond-aligner:v0.9.24dfsg-1-deb_cv1
stdout: diamond-aligner.out
