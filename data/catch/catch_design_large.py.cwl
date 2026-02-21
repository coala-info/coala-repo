cwlVersion: v1.2
class: CommandLineTool
baseCommand: catch_design_large.py
label: catch_design_large.py
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  a SIF image due to lack of disk space.\n\nTool homepage: https://github.com/broadinstitute/catch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
stdout: catch_design_large.py.out
