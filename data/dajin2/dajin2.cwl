cwlVersion: v1.2
class: CommandLineTool
baseCommand: dajin2
label: dajin2
doc: "DAJIN2: A tool for Nanopore sequencing analysis of genome editing (Note: The
  provided text was an error log and did not contain help documentation).\n\nTool
  homepage: https://github.com/akikuno/DAJIN2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dajin2:0.8.0--pyhdfd78af_0
stdout: dajin2.out
