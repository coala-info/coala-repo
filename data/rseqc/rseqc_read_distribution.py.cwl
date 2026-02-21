cwlVersion: v1.2
class: CommandLineTool
baseCommand: read_distribution.py
label: rseqc_read_distribution.py
doc: "The provided text does not contain help information for rseqc_read_distribution.py;
  it is a log of a fatal error during a container build process. No arguments could
  be extracted.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
stdout: rseqc_read_distribution.py.out
