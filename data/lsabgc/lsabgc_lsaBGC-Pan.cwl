cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsaBGC-Pan.py
label: lsabgc_lsaBGC-Pan
doc: "The provided text does not contain help information for the tool, but rather
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
stdout: lsabgc_lsaBGC-Pan.out
