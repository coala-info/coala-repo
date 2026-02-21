cwlVersion: v1.2
class: CommandLineTool
baseCommand: codeml
label: paml_codeml
doc: "codeml is a program in the PAML (Phylogenetic Analysis by Maximum Likelihood)
  package that analyzes DNA or protein sequences using maximum likelihood.\n\nTool
  homepage: https://evomics.org/resources/software/molecular-evolution-software/paml"
inputs:
  - id: control_file
    type:
      - 'null'
      - File
    doc: Path to the control file (typically codeml.ctl). If not provided, the program
      looks for 'codeml.ctl' in the current directory.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paml:4.10.10--h7b50bb2_0
stdout: paml_codeml.out
