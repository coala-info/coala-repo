cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmats_rmats.py
label: rmats_rmats.py
doc: "The provided text does not contain help information for the tool; it contains
  error logs related to a container build failure.\n\nTool homepage: http://rnaseq-mats.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmats:4.3.0--py311hf2f0b74_5
stdout: rmats_rmats.py.out
