cwlVersion: v1.2
class: CommandLineTool
baseCommand: dist_est
label: dist_est
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to pull or build the container image due to lack of disk space.\n\nTool
  homepage: https://www.mathstat.dal.ca/~tsusko/doc/ras.pdf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dist_est:1.1--h503566f_3
stdout: dist_est.out
