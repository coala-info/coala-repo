cwlVersion: v1.2
class: CommandLineTool
baseCommand: addeam-bam2prof.py
label: addeam_addeam-bam2prof.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container image build failure (no space left
  on device).\n\nTool homepage: https://github.com/LouisPwr/AdDeam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0
stdout: addeam_addeam-bam2prof.py.out
