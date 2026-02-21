cwlVersion: v1.2
class: CommandLineTool
baseCommand: estscan
label: estscan
doc: "ESTScan is a program that can detect coding regions in DNA sequences, even if
  they are of low quality (e.g., containing sequencing errors like insertions or deletions).\n
  \nTool homepage: https://github.com/sib-swiss/ESTScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/estscan:v3.0.3-3-deb_cv1
stdout: estscan.out
