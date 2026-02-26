cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - fltuniq
label: fermi_fltuniq
doc: "Filter unique sequences from a FASTA file.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_fltuniq.out
