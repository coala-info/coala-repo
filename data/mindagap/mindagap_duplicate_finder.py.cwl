cwlVersion: v1.2
class: CommandLineTool
baseCommand: mindagap_duplicate_finder.py
label: mindagap_duplicate_finder.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/ViriatoII/MindaGap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap_duplicate_finder.py.out
