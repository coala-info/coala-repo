cwlVersion: v1.2
class: CommandLineTool
baseCommand: siann_siann.py
label: siann_siann.py
doc: "SIANN (Strain Identification and Antimicrobial resistance analysis from Next-generation
  sequencing)\n\nTool homepage: https://github.com/signaturescience/siann/wiki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/siann:1.3--hdfd78af_0
stdout: siann_siann.py.out
