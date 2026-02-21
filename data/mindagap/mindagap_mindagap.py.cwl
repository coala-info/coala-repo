cwlVersion: v1.2
class: CommandLineTool
baseCommand: mindagap.py
label: mindagap_mindagap.py
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/ViriatoII/MindaGap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap_mindagap.py.out
