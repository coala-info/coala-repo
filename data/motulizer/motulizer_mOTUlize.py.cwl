cwlVersion: v1.2
class: CommandLineTool
baseCommand: motulizer_mOTUlize.py
label: motulizer_mOTUlize.py
doc: "Note: The provided text does not contain help information for the tool. It contains
  container runtime error messages (Singularity/Apptainer) indicating a failure to
  build the image due to lack of disk space.\n\nTool homepage: https://github.com/moritzbuck/mOTUlizer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
stdout: motulizer_mOTUlize.py.out
