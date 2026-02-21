cwlVersion: v1.2
class: CommandLineTool
baseCommand: ciri-full_bwa
label: ciri-full_bwa
doc: "The provided text does not contain help information or a description of the
  tool; it is a system log showing a failed container build due to insufficient disk
  space.\n\nTool homepage: https://ciri-cookbook.readthedocs.io/en/latest/CIRI-full.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ciri-full:2.1.2--hdfd78af_1
stdout: ciri-full_bwa.out
