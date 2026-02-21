cwlVersion: v1.2
class: CommandLineTool
baseCommand: split-paired-reads.py
label: khmer-common_split-paired-reads.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log indicating a failure to build a Singularity/Apptainer container
  due to insufficient disk space.\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/khmer-common:v2.1.2dfsg-6-deb_cv1
stdout: khmer-common_split-paired-reads.py.out
