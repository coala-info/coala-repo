cwlVersion: v1.2
class: CommandLineTool
baseCommand: mark-nonconverted-reads.py
label: mark-nonconverted-reads_mark-nonconverted-reads.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container environment (Singularity/Apptainer)
  failing due to lack of disk space.\n\nTool homepage: https://github.com/nebiolabs/mark-nonconverted-reads"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mark-nonconverted-reads:1.2--pyhdfd78af_0
stdout: mark-nonconverted-reads_mark-nonconverted-reads.py.out
