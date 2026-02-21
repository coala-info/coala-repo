cwlVersion: v1.2
class: CommandLineTool
baseCommand: inner_distance.py
label: rseqc_inner_distance.py
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process. No arguments could be extracted.\n\nTool homepage:
  https://rseqc.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
stdout: rseqc_inner_distance.py.out
