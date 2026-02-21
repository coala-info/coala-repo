cwlVersion: v1.2
class: CommandLineTool
baseCommand: abundance-dist.py
label: khmer-common_abundance-dist.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a Singularity/Apptainer container build failure.\n
  \nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/khmer-common:v2.1.2dfsg-6-deb_cv1
stdout: khmer-common_abundance-dist.py.out
