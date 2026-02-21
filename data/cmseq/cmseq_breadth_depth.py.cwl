cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmseq_breadth_depth.py
label: cmseq_breadth_depth.py
doc: "The provided text does not contain help information for the tool; it contains
  system error logs related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/SegataLab/cmseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmseq:1.0.4--pyhb7b1952_0
stdout: cmseq_breadth_depth.py.out
