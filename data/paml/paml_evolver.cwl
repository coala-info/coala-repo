cwlVersion: v1.2
class: CommandLineTool
baseCommand: evolver
label: paml_evolver
doc: "A program from the PAML suite used for simulating DNA, codon, and amino acid
  sequences, as well as generating random trees and calculating tree distances.\n\n
  Tool homepage: https://evomics.org/resources/software/molecular-evolution-software/paml"
inputs:
  - id: choice
    type: int
    doc: 'The simulation or data generation option (1: DNA, 2: AA, 3: Codon, 4: Tree
      distances, 5: Simulate DNA, 6: Simulate AA, 7: Simulate Codon)'
    inputBinding:
      position: 1
  - id: control_file
    type: File
    doc: The control file containing parameters for the simulation (e.g., MCbase.dat,
      MCaa.dat, or MCcodon.dat)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paml:4.10.10--h7b50bb2_0
stdout: paml_evolver.out
