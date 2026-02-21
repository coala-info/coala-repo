cwlVersion: v1.2
class: CommandLineTool
baseCommand: freddie_freddie_isoforms.py
label: freddie_freddie_isoforms.py
doc: "The provided text does not contain help information for the tool, but rather
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/vpc-ccg/freddie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freddie:0.4--hdfd78af_0
stdout: freddie_freddie_isoforms.py.out
