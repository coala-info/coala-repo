cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfmix_rert
label: gfmix_rert
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build a container due to insufficient disk space.\n\nTool homepage: https://www.mathstat.dal.ca/~tsusko/doc/gfmix.pdf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfmix:1.0.2--h503566f_3
stdout: gfmix_rert.out
