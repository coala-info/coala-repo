cwlVersion: v1.2
class: CommandLineTool
baseCommand: dunovo_correct.py
label: dunovo_correct.py
doc: "The provided text does not contain help information for dunovo_correct.py. It
  contains system log messages and a fatal error regarding a container runtime (Singularity/Apptainer)
  failing to build a SIF image due to lack of disk space.\n\nTool homepage: https://github.com/galaxyproject/dunovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
stdout: dunovo_correct.py.out
