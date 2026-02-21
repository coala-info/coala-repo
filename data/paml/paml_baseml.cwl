cwlVersion: v1.2
class: CommandLineTool
baseCommand: baseml
label: paml_baseml
doc: "BASEML is a program for Maximum Likelihood analysis of nucleotide sequences,
  part of the PAML (Phylogenetic Analysis by Maximum Likelihood) package. It uses
  a control file to specify parameters for the analysis.\n\nTool homepage: https://evomics.org/resources/software/molecular-evolution-software/paml"
inputs:
  - id: control_file
    type:
      - 'null'
      - File
    doc: Path to the control file (defaults to baseml.ctl if not specified).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paml:4.10.10--h7b50bb2_0
stdout: paml_baseml.out
