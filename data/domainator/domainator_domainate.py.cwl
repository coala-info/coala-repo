cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_domainate.py
label: domainator_domainate.py
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to lack of disk space.\n\nTool homepage:
  https://github.com/nebiolabs/domainator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.0--pyhdfd78af_0
stdout: domainator_domainate.py.out
