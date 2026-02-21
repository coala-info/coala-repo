cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst-merge.py
label: metamlst_metamlst-merge.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/SegataLab/metamlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst_metamlst-merge.py.out
