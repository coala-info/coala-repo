cwlVersion: v1.2
class: CommandLineTool
baseCommand: swga
label: swga
doc: "Selective Whole Genome Amplification (SWGA) tool\n\nTool homepage: https://github.com/eclarke/swga"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
stdout: swga.out
