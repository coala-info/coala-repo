cwlVersion: v1.2
class: CommandLineTool
baseCommand: gassst_to_sam
label: gassst_gassst_to_sam
doc: "Convert GASSST output to SAM format\n\nTool homepage: https://www.irisa.fr/symbiose/projects/gassst/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gassst:1.28--h503566f_3
stdout: gassst_gassst_to_sam.out
