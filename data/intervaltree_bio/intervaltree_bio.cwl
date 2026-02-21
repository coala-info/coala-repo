cwlVersion: v1.2
class: CommandLineTool
baseCommand: intervaltree_bio
label: intervaltree_bio
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/konstantint/intervaltree-bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/intervaltree-bio:v1.0.1-3-deb-py3_cv1
stdout: intervaltree_bio.out
